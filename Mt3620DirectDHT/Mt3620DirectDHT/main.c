#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"

#include <applibs/gpio.h>
#include <applibs/log.h>
#include <applibs/wificonfig.h>

#include "mt3620_rdb.h"
#include "led_blink_utility.h"
#include "..\DHTlib\Inc\Public\DHTlib.h"

#ifndef AZURE_IOT_HUB_CONFIGURED
#error \
    "WARNING: Please add a project reference to the Connected Service first \
(right-click References -> Add Connected Service)."
#endif

// This sample C application for a MT3620 Reference Development Board (Azure Sphere) demonstrates 
// how to connect an Azure Sphere device to an Azure IoT Hub and 
// read temperature and sensor data from a DHT22/DHT11 sensor.
// To use this sample, you must first add the Azure IoT Hub Connected Service reference to the project 
// (right-click References -> Add Connected Service -> Azure IoT Hub), which populates this project
// with additional sample code used to communicate with an Azure IoT Hub.
//
// The sample leverages these functionalities of the Azure IoT SDK C:
// - Device to cloud messages;
// - Direct Method invocation;
// - Device Twin management;
//
// A description of the sample follows:
// - LED 1 flashes green when the devices retrieves a Method call and returns temperature/hiumidity data
//   it flashes red when the sensor failed to deliver data.
// - Pressing button B triggers the sending of a temperatur/humidy message to the IoT Hub.
// - LED 2 flashes green when button B is pressed (and a
//   message is sent) and flashes red when the sensor failed to deliver data.
// - LED 3 indicates whether network connection to the Azure IoT Hub has been
//   established.
//
// Direct Method related notes:
// - Invoking the method named "DHTReadDataMethod" (no payload required)
//   triggers a sensor reading and returns the results
//
// Device Twin related notes:
// - Pressing button A causes the sample to report the temperature & humidity data to the device
//   twin on the IoT Hub.

// This sample uses the API for the following Azure Sphere application libraries:
// - gpio (digital input for button)
// - log (messages shown in Visual Studio's Device Output window during debugging)
#define JSON_BUFFER_SIZE 256

// An array defining the RGB GPIOs for each LED on the device
static const GPIO_Id ledsPins[3][3] = {
    {MT3620_RDB_LED1_RED, MT3620_RDB_LED1_GREEN, MT3620_RDB_LED1_BLUE}, {MT3620_RDB_LED2_RED, MT3620_RDB_LED2_GREEN, MT3620_RDB_LED2_BLUE}, {MT3620_RDB_LED3_RED, MT3620_RDB_LED3_GREEN, MT3620_RDB_LED3_BLUE}};

// Button GPIO file descriptors - initialized to invalid value
static int messageSendButtonFd = -1;

// Button state
static GPIO_Value_Type messageSendButtonState = GPIO_Value_High;

// LED state
static RgbLed ledMethodReceived = RGBLED_INIT_VALUE;
static RgbLed ledMessageSent = RGBLED_INIT_VALUE;
static RgbLed ledNetworkStatus = RGBLED_INIT_VALUE;
static RgbLed *rgbLeds[] = {&ledMethodReceived, &ledMessageSent, &ledNetworkStatus};
static const size_t rgbLedsCount = sizeof(rgbLeds) / sizeof(*rgbLeds);

// json format string for reported properties
static const char cstrReportedPropertiesJson[] = "{\"Temp_C\":\"%.2f\",\"Temp_F\":\"%.2f\",\"Humidity\":\"%.2f\"}";
static const char cstrJsonErrorNoData[] = "{ \"success\" : false, \"message\" : \"could not read DHT sensor data\" }";
static const char noMethodFound[] = "\"method not found '%s'\"";
static const char cstrJsonSuccessAndData[] = "{\"success\":true,\"Temp_C\":\"%.2f\",\"Temp_F\":\"%.2f\",\"Humidity\":\"%.2f\"}";

// how often we automatically send the temperature.
static int sendTempIntervalSeconds = 15;

// Connectivity state
static bool connectedToIoTHub = false;

// Termination state
static volatile sig_atomic_t terminationRequested = false;

/// <summary>
///     Signal handler for termination requests. This handler must be async-signal-safe.
/// </summary>
static void TerminationHandler(int signalNumber)
{
    // Don't use Log_Debug here, as it is not guaranteed to be async signal safe
    terminationRequested = true;
}


/// <summary>
///     Helper function to open a file descriptor for the given GPIO as an input.
/// </summary>
/// <param name="button">The GPIO to which the button is attached.</param>
/// <param name="outGpioButtonFd">File descriptor of the opened GPIO.</param>
/// <returns>True if successful, false if an error occurred.</return>
static bool OpenButton(GPIO_Id button, int *outGpioButtonFd)
{
    *outGpioButtonFd = GPIO_OpenAsInput(button);
    if (*outGpioButtonFd < 0) {
        Log_Debug("ERROR: Could not open button GPIO\n");
        return false;
    }

    return true;
}

/// <summary>
///     Helper function to read the DHT sensor valuesand create response json if jsonBuffer is available.
/// </summary>
/// <param name="jsonBuffer">pointer to string buffer for json result. NULL if no json is requested</param>
/// <param name="jsonBufferSize">length of pre-allocated json string buffer</param>
/// <returns>True if successful, false if an error occurred.</return>
bool GetAndReportSensorData(char * jsonBuffer, size_t jsonBufferSize )
{
	DHT_SensorData * pDHT = DHT_ReadData(MT3620_GPIO0);
	if (pDHT != NULL)
	{

		char *jsonPropertyBuffer = (char *)malloc(JSON_BUFFER_SIZE);
		if (jsonPropertyBuffer != NULL)
		{
			snprintf(jsonPropertyBuffer, JSON_BUFFER_SIZE, cstrReportedPropertiesJson, pDHT->TemperatureCelsius, pDHT->TemperatureFahrenheit, pDHT->Humidity);
			AzureIoT_TwinReportStateJson(jsonPropertyBuffer, strlen(jsonPropertyBuffer));
			free(jsonPropertyBuffer);
		}
		else {
			Log_Debug("ERROR: failed to allocate buffer for reported state.\n");
		}


		if (jsonBuffer != NULL) {
			// prepare data to be sent via AzureIoT_SendMessage
			snprintf(jsonBuffer, jsonBufferSize, cstrJsonSuccessAndData, pDHT->TemperatureCelsius, pDHT->TemperatureFahrenheit, pDHT->Humidity);
		}
		return true;
	}
	return false;
}

/// <summary>
///     Sends a message to the IoT Hub.
/// </summary>
static void SendMessageToIotHub()
{
    if (connectedToIoTHub) {
		char * jsonBuffer = (char *)malloc(JSON_BUFFER_SIZE);
		if (GetAndReportSensorData(jsonBuffer, JSON_BUFFER_SIZE)) {

			// Send a message
			AzureIoT_SendMessage(jsonBuffer);
			Log_Debug("INFO: SendMessageToIoTHub %s\n", jsonBuffer);
			// Set the send/receive LED to blink once immediately to indicate the message has been queued
			LedBlinkUtility_BlinkNow(&ledMessageSent, LedBlinkUtility_Colors_Green);
		}
    } else {
		// Send/receive LED to blink once red to indicate sensor failure
		LedBlinkUtility_BlinkNow(&ledMessageSent, LedBlinkUtility_Colors_Red);
		Log_Debug("WARNING: Cannot send message: not connected to the IoT Hub\n");
    }
}

/// <summary>
///    Check for button presses and respond if one is detected
/// </summary>
/// <returns>0 if the check was successful, or -1 in the case of a failure</returns>
static int CheckForButtonPresses()
{
	GPIO_Value_Type newGpioButtonState = GPIO_Value_Low;

    // Check for a button press on messageSendButtonFd
    int result = GPIO_GetValue(messageSendButtonFd, &newGpioButtonState);
    if (result != 0) {
        Log_Debug("ERROR: Could not read button GPIO\n");
        return -1;
    }

    if (newGpioButtonState != messageSendButtonState) {
        // If the button state has changed, then respond
        // The button has GPIO_Value_Low when pressed and GPIO_Value_High when released
        if (newGpioButtonState == GPIO_Value_Low) {
            SendMessageToIotHub();
        }
        // Save the button's new state
        messageSendButtonState = newGpioButtonState;
    }

    return 0;
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
		if( !GetAndReportSensorData(jsonBuffer, JSON_BUFFER_SIZE) ){
            result = 400;
            Log_Debug("INFO: DHTReadDataMethod: no DHT data available.\n");

            strncpy( jsonBuffer, cstrJsonErrorNoData, JSON_BUFFER_SIZE);
            *responsePayload = jsonBuffer;
            *responsePayloadSize = strlen(jsonBuffer);

			LedBlinkUtility_BlinkNow(&ledMethodReceived, LedBlinkUtility_Colors_Red);
        } else {
            // DHT data is available.
            result = 200;
			Log_Debug("INFO: DHTReadDataMethod returns %s\n", jsonBuffer);

            *responsePayload = jsonBuffer;
            *responsePayloadSize = strlen(jsonBuffer);
			LedBlinkUtility_BlinkNow(&ledMethodReceived, LedBlinkUtility_Colors_Green);
		}
    } else {
        result = 404;
        Log_Debug("INFO: Method not found called: '%s'.\n", methodName);

        size_t responseMaxLength = sizeof(noMethodFound) + strlen(methodName);
        *responsePayload = SetupHeapMessage(noMethodFound, responseMaxLength, methodName);
        if (*responsePayload == NULL) {
            Log_Debug("ERROR: Could not allocate buffer for direct method response payload.\n");
            abort();
        }
        *responsePayloadSize = strlen(*responsePayload);
		LedBlinkUtility_BlinkNow(&ledMethodReceived, LedBlinkUtility_Colors_Yellow);
	}

    return result;
}

/// <summary>
///     IoT Hub connection status callback function.
/// </summary>
/// <param name="connected">'true' when the connection to the IoT Hub is established.</param>
static void IoTHubConnectionStatusChanged(bool connected)
{
    connectedToIoTHub = connected;
}

/// <summary>
///     Initialize peripherals, termination handler, and Azure IoT
/// </summary>
/// <returns>0 on success, or -1 on failure</returns>
static int Init(void)
{
    // Register a SIGTERM handler for termination requests
    struct sigaction action;
    memset(&action, 0, sizeof(struct sigaction));
    action.sa_handler = TerminationHandler;
    sigaction(SIGTERM, &action, NULL);

    // Open button B
    Log_Debug("Open MT3620_RDB_BUTTON_B\n");
    if (!OpenButton(MT3620_RDB_BUTTON_B, &messageSendButtonFd)) {
        return -1;
    }

    // Open file descriptors for the RGB LEDs and store them in the rgbLeds array (and in turn in
    // the ledMethodReceived, ledMessageEventSending, ledNetworkStatus variables)
    LedBlinkUtility_OpenLeds(rgbLeds, rgbLedsCount, ledsPins);

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

    return 0;
}

/// <summary>
///     Close peripherals and Azure IoT
/// </summary>
static void ClosePeripherals(void)
{
    Log_Debug("Closing GPIOs and Azure IoT\n");

    // Close the button file descriptors
    if (messageSendButtonFd >= 0) {
        int result = close(messageSendButtonFd);
        if (result != 0) {
            Log_Debug("WARNING: Problem occurred closing messageSendButton GPIO: %s (%d).\n",
                      strerror(errno), errno);
        }
    }

    // Close the LEDs and leave then off
    LedBlinkUtility_CloseLeds(rgbLeds, rgbLedsCount);

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

    int initResult = Init();
    if (initResult != 0) {
        terminationRequested = true;
    }

    const struct timespec timespec_1ms = {0, 1000000};

	time_t lastSentTemperature = time(0);

    // Main loop
    while (!terminationRequested) {
        // Set network status LED color
        LedBlinkUtility_Colors color =
            (connectedToIoTHub ? LedBlinkUtility_Colors_Green : LedBlinkUtility_Colors_Off);
        if (LedBlinkUtility_SetLed(&ledNetworkStatus, color) != 0) {
            Log_Debug("Error: Set color for network status LED failed\n");
            break;
        }

        // Trigger LEDs to blink as appropriate
        if (LedBlinkUtility_BlinkLeds(rgbLeds, rgbLedsCount) != 0) {
            Log_Debug("ERROR: Blinking LEDs failed\n");
            break;
        }

        // Setup the IoT Hub client.
        // Notes:
        // - it is safe to call this function even if the client has already been set up, as in
        //   this case it would have no effect;
        // - a failure to setup the client is a fatal error.
        if (!AzureIoT_SetupClient()) {
            Log_Debug("ERROR: Failed to set up IoT Hub client\n");
            break;
        }

        // AzureIoT_DoPeriodicTasks() needs to be called frequently in order to keep active
        // the flow of data with the Azure IoT Hub
        AzureIoT_DoPeriodicTasks();

        if (CheckForButtonPresses() != 0) {
            break;
        }

		// once we are connected and we have the correct time
		// we send the temperature every sendTempIntervalSeconds
		if (connectedToIoTHub) {
			time_t now = time(0);
			if (lastSentTemperature < now - sendTempIntervalSeconds) {
				SendMessageToIotHub();
				lastSentTemperature = time(0);
			}
		}
		
        nanosleep(&timespec_1ms, NULL);
    }

    ClosePeripherals();
    Log_Debug("Application exiting\n");
    return 0;
}
