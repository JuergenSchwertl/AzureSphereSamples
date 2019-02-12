#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"
#include "epoll_timerfd_utilities.h"

#include <applibs/gpio.h>
#include <applibs/log.h>
#include <applibs/networking.h>
#include <applibs/wificonfig.h>

#include "mt3620_rdb.h"
#include "rgbled_utility.h"
#include "..\DHTlib\Inc\Public\DHTlib.h"

#ifndef AZURE_IOT_HUB_CONFIGURED
#error \
    "WARNING: Please add a project reference to the Connected Service first \
(right-click References -> Add Connected Service)."
#endif

#include "azure_iot_utilities.h"

///<summary> 
/// This sample C application for a MT3620 Reference Development Board (Azure Sphere) demonstrates 
/// how to connect an Azure Sphere device to an Azure IoT Hub and read data from a DHT22/DHT11 sensor.
/// It also extends the epoll_timerfd_utilities.h|event_data_t structure by an event context pointer.
///
/// To use this sample, you must first add the Azure IoT Hub Connected Service reference to the project 
/// (right-click References -> Add Connected Service -> Azure IoT Hub), which populates this project
/// with additional sample code used to communicate with an Azure IoT Hub.
///
/// The sample leverages these functionalities of the Azure IoT SDK C:
/// - Device to cloud messages;
/// - Direct Method invocation;
/// - Device Twin management;
///
/// A description of the sample follows:
/// - LED 1 flashes green when the device receives a Direct Method call and returns temperature/hiumidity data
///   it flashes red when the sensor failed to deliver data.
/// - Pressing button B triggers the sending of a temperatur/humidy message to the IoT Hub.
/// - LED 2 flashes green: when button B is pressed and a
///   message is sent; red : when the sensor failed to deliver data.
/// - WiFi LED indicates in green when the device is connected to WiFi and blue if connection to the Azure IoT Hub has been
///   established.
///
/// Direct Method related notes:
/// - Invoking the method named "DHTReadDataMethod" (no payload required)
///   triggers a sensor reading and returns the results
///
/// Device Twin related notes:
/// - Pressing button A causes the sample to report the temperature & humidity data to the device
///   twin on the IoT Hub.
//
/// This sample uses the API for the following Azure Sphere application libraries:
/// - gpio (digital input for button)
/// - log (messages shown in Visual Studio's Device Output window during debugging)
///</summary>

// 256 byte buffer size for json data
#define JSON_BUFFER_SIZE 256

// An array defining the RGB GPIOs for each used LED on the device
static const GPIO_Id ledsPins[4][3] = {
    {MT3620_RDB_LED1_RED, MT3620_RDB_LED1_GREEN, MT3620_RDB_LED1_BLUE}, 
	{MT3620_RDB_LED2_RED, MT3620_RDB_LED2_GREEN, MT3620_RDB_LED2_BLUE},
	{MT3620_RDB_LED3_RED, MT3620_RDB_LED3_GREEN, MT3620_RDB_LED3_BLUE},
	{MT3620_RDB_NETWORKING_LED_RED, MT3620_RDB_NETWORKING_LED_GREEN, MT3620_RDB_NETWORKING_LED_BLUE}
};

// Epoll file descriptors
static int epollFd = -1;

static int timerFdButtonManagement = -1;
static int timerFdTelemetry = -1;
static int timerFdReportedPropertiesLed = -1;
static int timerFdMethodReceivedLed = -1;
static int timerFdSendMessageLed = -1;
static int timerFdAzureIotDoWork = -1;


// Button GPIO file descriptors - initialized to invalid value
static int gpioFdMessageSendButton = -1;

// Button state
static GPIO_Value_Type messageSendButtonState = GPIO_Value_High;

// LED state
static RgbLed ledReportedProperties = RGBLED_INIT_VALUE; // LED1
static RgbLed ledMethodReceived = RGBLED_INIT_VALUE; // LED2
static RgbLed ledSendMessage = RGBLED_INIT_VALUE; // LED3
static RgbLed ledNetworkStatus = RGBLED_INIT_VALUE;
static RgbLed *rgbLeds[] = { &ledReportedProperties, &ledMethodReceived, &ledSendMessage, &ledNetworkStatus};
static const size_t rgbLedsCount = sizeof(rgbLeds) / sizeof(*rgbLeds);

static const struct timespec defaultLedBlinkTime = { 0, 250 * 1000 * 1000 }; // 250ms
static const struct timespec nullPeriod = { 0, 0 };

// json format strings
static const char cstrJsonData[] = "{\"Temp_C\":\"%.2f\",\"Temp_F\":\"%.2f\",\"Humidity\":\"%.2f\"}";
static const char cstrJsonSuccessAndData[] = "{\"success\":true,\"Temp_C\":\"%.2f\",\"Temp_F\":\"%.2f\",\"Humidity\":\"%.2f\"}";
static const char cstrJsonErrorNoData[] = "{\"success\":false,\"message\":\"could not read DHT sensor data\"}";
static const char cstrJsonMethodNotFound[] = "{\"success\":false,\"message\":\"method not found '%s'\"}";

// Telemetry interval.
static struct timespec telemetrySendInterval = { 15, 0 }; // every 15s

// Connectivity state
static bool connectedToIoTHub = false;

// Termination state
static volatile sig_atomic_t terminationRequired = false;

/// <summary>
///     Signal handler for termination requests. This handler must be async-signal-safe.
/// </summary>
static void TerminationHandler(int signalNumber)
{
    // Don't use Log_Debug here, as it is not guaranteed to be async signal safe
	terminationRequired = true;
}



/// <summary>
///     Helper function to open a file descriptor for the given GPIO as input mode.
/// </summary>
/// <param name="gpioId">The GPIO to open.</param>
/// <param name="outGpioFd">File descriptor of the opened GPIO.</param>
/// <returns>True if successful, false if an error occurred.</return>
static bool OpenGpioFdAsInput(GPIO_Id gpioId, int *outGpioFd)
{
	*outGpioFd = GPIO_OpenAsInput(gpioId);
	if (*outGpioFd < 0) {
		Log_Debug("ERROR: Could not open GPIO '%d': %d (%s).\n", gpioId, errno, strerror(errno));
		return false;
	}

	return true;
}

/// <summary>
///     Show details of the currently connected WiFi network.
/// </summary>
static void DebugPrintCurrentlyConnectedWiFiNetwork(void)
{
	WifiConfig_ConnectedNetwork network;
	int result = WifiConfig_GetCurrentNetwork(&network);
	if (result < 0) {
		Log_Debug("INFO: Not currently connected to a WiFi network.\n");
	}
	else {
		Log_Debug("INFO: Currently connected WiFi network: \n");
		Log_Debug("INFO: SSID \"%.*s\", BSSID %02x:%02x:%02x:%02x:%02x:%02x, Frequency %dMHz.\n",
			network.ssidLength, network.ssid, network.bssid[0], network.bssid[1],
			network.bssid[2], network.bssid[3], network.bssid[4], network.bssid[5],
			network.frequencyMHz);
	}
}

/// <summary>
///     Helper function to blink LED once.
/// </summary>
static void BlinkLedOnce(const RgbLed *pRgbLed, int fdLedTimer, RgbLedUtility_Colors color)
{
	RgbLedUtility_SetLed(pRgbLed, color);
	SetTimerFdToSingleExpiry(fdLedTimer, &defaultLedBlinkTime);
}

/// <summary>
///     Helper function to read the DHT sensor values and create response json if jsonBuffer and cstrJsonFormat is available.
/// </summary>
/// <param name="jsonBuffer">pointer to string buffer for json result.</param>
/// <param name="jsonBufferSize">length of pre-allocated json string buffer</param>
/// <returns>True if successful, false if an error occurred.</returns>
bool GetSensorDataJson(char * jsonBuffer, size_t jsonBufferSize, const char * cstrJsonFormat )
{
	if ((jsonBuffer == NULL) || (cstrJsonFormat==NULL))
	{ 
		return false;
	}

	DHT_SensorData * pDHT = DHT_ReadData(MT3620_GPIO0);
	if (pDHT == NULL)
	{
		strncpy(jsonBuffer, cstrJsonErrorNoData, jsonBufferSize);
		return false;
	}

	// prepare json data to be sent 
	snprintf(jsonBuffer, jsonBufferSize, cstrJsonSuccessAndData, 
				pDHT->TemperatureCelsius, pDHT->TemperatureFahrenheit, pDHT->Humidity);
	return true;
}

/// <summary>
///     Sends a message to Azure IoT Hub.
/// </summary>
static void SendMessageToIotHub(void)
{
    if (connectedToIoTHub) {
		char * jsonBuffer = (char *)malloc(JSON_BUFFER_SIZE);
		if (GetSensorDataJson(jsonBuffer, JSON_BUFFER_SIZE, cstrJsonSuccessAndData)) {

			// Send a message
			AzureIoT_SendMessage(jsonBuffer);
			Log_Debug("INFO: SendMessageToIoTHub %s\n", jsonBuffer);
			// Set the send/receive LED to blink once immediately to indicate the message has been queued
			BlinkLedOnce(&ledSendMessage, timerFdSendMessageLed, RgbLedUtility_Colors_Green);
		}
		else
		{
			// Send/receive LED to blink once red to indicate sensor failure
			BlinkLedOnce(&ledSendMessage, timerFdSendMessageLed, RgbLedUtility_Colors_Red);
		}
		free(jsonBuffer);
    } else {
		Log_Debug("[SendMessageToIoTHub]: Cannot send message: not connected to the IoT Hub\n");
    }
}

/// <summary>
///     Report properties to Azure IoT Hub.
/// </summary>
static void ReportProperties(void)
{
	char *jsonPropertyBuffer = (char *)malloc(JSON_BUFFER_SIZE);
	if (jsonPropertyBuffer == NULL)
	{
		Log_Debug("[ReportProperties] ERROR: cannot allocate buffer for reported properties");
		return;
	}

	if (GetSensorDataJson(jsonPropertyBuffer, JSON_BUFFER_SIZE, cstrJsonData)) {
		// report properties to Azure IoT Hub
		Log_Debug("[ReportProperties] reported properties JSON is '%s'\n", jsonPropertyBuffer);
		AzureIoT_TwinReportStateJson(jsonPropertyBuffer, strlen(jsonPropertyBuffer));
		BlinkLedOnce(&ledReportedProperties, timerFdReportedPropertiesLed, RgbLedUtility_Colors_Green);
	}
	else
	{
		BlinkLedOnce(&ledReportedProperties, timerFdReportedPropertiesLed, RgbLedUtility_Colors_Red);
	}

	// cleanup heap message (required as implicit IoTHubDeviceClient_LL_SendReportedState doesn't free buffer)
	free(jsonPropertyBuffer);
}

static void *SetupHeapMessage(const char *messageFormat, size_t maxLength, ...)
{
    va_list args;
    va_start(args, maxLength);
    char *message =
        malloc(maxLength + 1); // Ensure there is space for the null terminator put by vsnprintf.
    if (message != NULL) {
        vsnprintf(message, maxLength, messageFormat, args);
    }
    va_end(args);
    return message;
}

/// <summary>
///     Direct Method callback function, called when a Direct Method call is received from the Azure
///     IoT Hub.
/// </summary>
/// <param name="methodName">The name of the method being called.</param>
/// <param name="payload">The payload of the method.</param>
/// <param name="responsePayload">The response payload content. This must be a heap-allocated
/// string, 'free' will be called on this buffer by the Azure IoT Hub SDK.</param>
/// <param name="responsePayloadSize">The size of the response payload content.</param>
/// <returns>200 HTTP status code if the method name is "DHTReadDataMethod" and the DHT sensor delivered correct data
/// 400 HTTP status code is the DHT sensor delivered erroneous data
/// 404 HTTP status code if the method name is unknown.</returns>
static int DirectMethodCall(const char *methodName, const char *payload, size_t payloadSize,
                            char **responsePayload, size_t *responsePayloadSize)
{
	// Prepare the payload for the response. This is a heap allocated null terminated string.
    // The Azure IoT Hub SDK is responsible of freeing it.
    *responsePayload = NULL;  // Reponse payload content.
    *responsePayloadSize = 0; // Response payload content size.

    int result = 404; // HTTP status code

    if (strcmp(methodName, "DHTReadDataMethod") == 0) {

		char * jsonBuffer = (char *)malloc(JSON_BUFFER_SIZE);
		if( !GetSensorDataJson(jsonBuffer, JSON_BUFFER_SIZE, cstrJsonSuccessAndData) ){
			result = 400;
			BlinkLedOnce(&ledMethodReceived, timerFdMethodReceivedLed, RgbLedUtility_Colors_Red);
        } else {
            // DHT data is available.
			result = 200;
			BlinkLedOnce(&ledMethodReceived, timerFdMethodReceivedLed, RgbLedUtility_Colors_Green);
		}
		*responsePayload = jsonBuffer;
		*responsePayloadSize = strlen(jsonBuffer);
		Log_Debug("[DirectMethodCall] 'DHTReadDataMethod' returns %s\n", jsonBuffer);
	} else {
        result = 404;
        Log_Debug("[DirectMethodCall] unknown method '%s' called.\n", methodName);

        size_t responseMaxLength = sizeof(cstrJsonMethodNotFound) + strlen(methodName);
        *responsePayload = SetupHeapMessage(cstrJsonMethodNotFound, responseMaxLength, methodName);
        if (*responsePayload == NULL) {
            Log_Debug("[DirectMethodCall] ERROR: Could not allocate buffer for response payload.\n");
            abort();
        }
        *responsePayloadSize = strlen(*responsePayload);
		BlinkLedOnce(&ledMethodReceived, timerFdMethodReceivedLed, RgbLedUtility_Colors_Yellow);
	}

    return result;
}

/// <summary>
///     IoT Hub connection status callback function.
/// </summary>
/// <param name="connected">'true' when the connection to the IoT Hub is established.</param>
static void SetNetworkStatusLed(void)
{
	bool bActiveNetwork = false;
	RgbLedUtility_Colors colStatus = RgbLedUtility_Colors_Red;

	Networking_IsNetworkingReady(&bActiveNetwork);
	if (bActiveNetwork)
	{
		if (connectedToIoTHub)
		{
			colStatus = RgbLedUtility_Colors_Blue;
		}
		else
		{
			colStatus = RgbLedUtility_Colors_Green;
		}
	}

	RgbLedUtility_SetLed(&ledNetworkStatus, colStatus);
}

/// <summary>
///     IoT Hub connection status callback function.
/// </summary>
/// <param name="connected">'true' when the connection to the IoT Hub is established.</param>
static void IoTHubConnectionStatusChanged(bool connected)
{
	Log_Debug("[IoTHubConnectionStatusChanged]:%d.\n", (int)connected);
    connectedToIoTHub = connected;
	SetNetworkStatusLed();
}

/// <summary>
///    Check for button presses and respond if one is detected
/// </summary>
/// <returns>0 if the check was successful, or -1 in the case of a failure</returns>
static void ButtonHandler(event_data_t *eventData)
{
	GPIO_Value_Type newGpioButtonState = GPIO_Value_Low;

	// Check for a button press on Send Button
	int result = GPIO_GetValue(gpioFdMessageSendButton, &newGpioButtonState);
	if (result != 0) {
		Log_Debug("[ButtonHandler] ERROR: Could not read button GPIO\n");
		return;
	}

	if (newGpioButtonState != messageSendButtonState) {
		// If the button state has changed, then respond
		// The button has GPIO_Value_Low when pressed and GPIO_Value_High when released
		if (newGpioButtonState == GPIO_Value_Low) {
			ReportProperties();
		}
		// Save the button's new state
		messageSendButtonState = newGpioButtonState;
	}

	return;
}

/// <summary>
///     Handle the blinking for LEDs.
/// </summary>
static void LedUpdateHandler(event_data_t *eventData)
{
	
	if (ConsumeTimerFdEvent(eventData->fd) != 0) {
		terminationRequired = true;
		return;
	}

	// Clear the send/receive LED2.
	RgbLedUtility_SetLed((RgbLed *) eventData->ptr, RgbLedUtility_Colors_Off);
}

/// <summary>
///     Hand over control periodically to the Azure IoT SDK's DoWork.
/// </summary>
static void AzureIotDoWorkHandler(event_data_t *eventData)
{
	if (ConsumeTimerFdEvent(timerFdAzureIotDoWork) != 0) {
		terminationRequired = true;
		return;
	}

	// Set up the connection to the IoT Hub client.
	// Notes it is safe to call this function even if the client has already been set up, as in
	//   this case it would have no effect
	if (AzureIoT_SetupClient()) {
		// AzureIoT_DoPeriodicTasks() needs to be called frequently in order to keep active
		// the flow of data with the Azure IoT Hub
		AzureIoT_DoPeriodicTasks();
	}
}

/// <summary>
///     Periodic telemetry interval handler.
/// </summary>
static void TelemetryIntervalHandler(event_data_t *eventData)
{
	Log_Debug("[TelemetryIntervalHandler]\n");

	if (ConsumeTimerFdEvent(timerFdTelemetry) != 0) {
		terminationRequired = true;
		return;
	}

	SendMessageToIotHub();
}

// event handler data structures. eventHandler field needs to be initialized.
static event_data_t eventDataButtons = { .eventHandler = &ButtonHandler,.fd = -1,.ptr = NULL };
static event_data_t eventDataMessageSentLed = { .eventHandler = &LedUpdateHandler,.fd = -1,.ptr = (void *) &ledSendMessage };
static event_data_t eventDataMethodReceivedLed = { .eventHandler = &LedUpdateHandler,.fd = -1,.ptr = (void *) &ledMethodReceived};
static event_data_t eventDataReportedPropertiesLed = { .eventHandler = &LedUpdateHandler,.fd = -1,.ptr = (void *) &ledReportedProperties };
static event_data_t eventDataAzureIoT = { .eventHandler = &AzureIotDoWorkHandler,.fd = -1,.ptr = NULL };
static event_data_t eventDataTelemetry = { .eventHandler = &TelemetryIntervalHandler,.fd = -1,.ptr = NULL };



/// <summary>
///     Initialize peripherals, termination handler, and Azure IoT
/// </summary>
/// <returns>0 on success, or -1 on failure</returns>
static int InitPeripheralsAndHandlers(void)
{
	// Register a SIGTERM handler for termination requests
	struct sigaction action;
	memset(&action, 0, sizeof(struct sigaction));
	action.sa_handler = TerminationHandler;
	sigaction(SIGTERM, &action, NULL);

	// Open button B
	Log_Debug("INFO: Opening MT3620_RDB_BUTTON_B.\n");
	if (!OpenGpioFdAsInput(MT3620_RDB_BUTTON_B, &gpioFdMessageSendButton)) {
		return -1;
	}

	// Open file descriptors for the RGB LEDs and store them in the rgbLeds array (and in turn in
	// the ledBlink, ledMessageEventSentReceived, ledNetworkStatus variables)
	RgbLedUtility_OpenLeds(rgbLeds, rgbLedsCount, ledsPins);

	SetNetworkStatusLed();

	// Initialize the Azure IoT SDK
	if (!AzureIoT_Initialize()) {
		Log_Debug("ERROR: Cannot initialize Azure IoT Hub SDK.\n");
		return -1;
	}

	// Set the Azure IoT hub related callbacks
	//AzureIoT_SetMessageReceivedCallback(&MessageReceived);
	//AzureIoT_SetDeviceTwinUpdateCallback(&DeviceTwinUpdate);
	AzureIoT_SetDirectMethodCallback(&DirectMethodCall);
	AzureIoT_SetConnectionStatusCallback(&IoTHubConnectionStatusChanged);
	
	DebugPrintCurrentlyConnectedWiFiNetwork();

	epollFd = CreateEpollFd();
	if (epollFd < 0) {
		return -1;
	}

	// Set up a timer for reported properties (LED1) blink once
	timerFdReportedPropertiesLed =
		CreateTimerFdAndAddToEpoll(epollFd, &nullPeriod, &eventDataReportedPropertiesLed, EPOLLIN);
	if (timerFdReportedPropertiesLed < 0) {
		return -1;
	}

	// Set up a timer for Send-Message (LED2) blink once.
	timerFdSendMessageLed = CreateTimerFdAndAddToEpoll(epollFd, &nullPeriod, &eventDataMessageSentLed, EPOLLIN);
	if (timerFdSendMessageLed < 0) {
		return -1;
	}

	// Set up a timer for Direct Method Received (LED3) blink once.
	timerFdMethodReceivedLed = CreateTimerFdAndAddToEpoll(epollFd, &nullPeriod, &eventDataMethodReceivedLed, EPOLLIN);
	if (timerFdMethodReceivedLed < 0) {
		return -1;
	}

	// Set up a timer for buttons status check
	static struct timespec buttonsPressCheckPeriod = { 0, 10 * 1000 * 1000 }; // every 10ms
	timerFdButtonManagement =
		CreateTimerFdAndAddToEpoll(epollFd, &buttonsPressCheckPeriod, &eventDataButtons, EPOLLIN);
	if (timerFdButtonManagement < 0) {
		return -1;
	}

	// Set up a timer for regular telemetry send intervals
	timerFdTelemetry =
		CreateTimerFdAndAddToEpoll(epollFd, &telemetrySendInterval, &eventDataTelemetry, EPOLLIN);
	if (timerFdButtonManagement < 0) {
		return -1;
	}

	// Set up a timer for Azure IoT SDK DoWork execution.
	static struct timespec azureIotDoWorkPeriod = { 10, 0 };
	timerFdAzureIotDoWork =
		CreateTimerFdAndAddToEpoll(epollFd, &azureIotDoWorkPeriod, &eventDataAzureIoT, EPOLLIN);
	if (timerFdAzureIotDoWork < 0) {
		return -1;
	}

	return 0;
}

/// <summary>
///     Close peripherals and Azure IoT
/// </summary>
static void ClosePeripheralsAndHandlers(void)
{
	Log_Debug("INFO: Closing GPIOs and Azure IoT client.\n");

	// Close all file descriptors
	CloseFdAndPrintError(gpioFdMessageSendButton, "SendMessageButton");
	CloseFdAndPrintError(timerFdButtonManagement, "ButtonsManagementTimer");
	CloseFdAndPrintError(timerFdAzureIotDoWork, "IotDoWorkTimer");
	CloseFdAndPrintError(timerFdReportedPropertiesLed, "ReportedPropertiesLedTimer");
	CloseFdAndPrintError(timerFdSendMessageLed, "MessageSentLedTimer");
	CloseFdAndPrintError(timerFdMethodReceivedLed, "MethodReceivedLedTimer");
	CloseFdAndPrintError(epollFd, "Epoll");

	// Close the LEDs and leave then off
	RgbLedUtility_CloseLeds(rgbLeds, rgbLedsCount);

	// Destroy the IoT Hub client
	AzureIoT_DestroyClient();
	AzureIoT_Deinitialize();
}

/// <summary>
///     Main entry point for this application.
/// </summary>
int main(int argc, char *argv[])
{
    Log_Debug("MT3620 direct DHT sensor application starting\n");

	int initResult = InitPeripheralsAndHandlers();
	if (initResult != 0) {
		terminationRequired = true;
	}

	while (!terminationRequired) {
		if (WaitForEventAndCallHandler(epollFd) != 0) {
			terminationRequired = true;
		}
	}

	ClosePeripheralsAndHandlers();
	Log_Debug("INFO: Application exiting.\n");
	return 0;
}
