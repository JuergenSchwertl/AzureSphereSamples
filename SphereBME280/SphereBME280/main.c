#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <time.h>

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"
#include "epoll_timerfd_utilities.h"

#include <applibs/i2c.h>
#include <applibs/gpio.h>
#include <applibs/log.h>
#include <applibs/wificonfig.h>

#include "mt3620_rdb.h"
#include "rgbled_utility.h"

#include "libBME280.h"

// This sample C application for a MT3620 Reference Development Board (Azure Sphere) demonstrates how to
// connect an Azure Sphere device to an Azure IoT Hub. To use this sample, you must first
// add the Azure IoT Hub Connected Service reference to the project (right-click
// References -> Add Connected Service -> Azure IoT Hub), which populates this project
// with additional sample code used to communicate with an Azure IoT Hub.
//
// The sample leverages these functionalities of the Azure IoT SDK C:
// - Device to cloud messages;
// - Cloud to device messages;
// - Direct Method invocation;
// - Device Twin management;
//
// A description of the sample follows:
// - LED 1 blinks constantly.
// - Pressing button A toggles the rate at which LED 1 blinks
//   between three values.
// - Pressing button B triggers the sending of a message to the IoT Hub.
// - LED 2 flashes red when button B is pressed (and a
//   message is sent) and flashes yellow when a message is received.
// - LED 3 indicates whether network connection to the Azure IoT Hub has been
//   established.
//
// Direct Method related notes:
// - Invoking the method named "LedColorControlMethod" with a payload containing '{"color":"red"}'
//   will set the color of LED 1 to red;
//
// Device Twin related notes:
// - Setting LedBlinkRateProperty in the Device Twin to a value from 0 to 2 causes the sample to
//   update the blink rate of LED 1 accordingly, e.g '{"LedBlinkRateProperty": 2}';
// - Upon receipt of the LedBlinkRateProperty desired value from the IoT hub, the sample updates
//   the device twin on the IoT hub with the new value for LedBlinkRateProperty.
// - Pressing button A causes the sample to report the blink rate to the device
//   twin on the IoT Hub.

// This sample uses the API for the following Azure Sphere application libraries:
// - gpio (digital input for button);
// - log (messages shown in Visual Studio's Device Output window during debugging);
// - wificonfig (configure WiFi settings);
// - azureiot (interaction with Azure IoT services)

#ifndef AZURE_IOT_HUB_CONFIGURED
#error \
    "WARNING: Please add a project reference to the Connected Service first \
(right-click References -> Add Connected Service)."
#endif

#include "azure_iot_utilities.h"

// An array defining the RGB GPIOs for each LED on the device
static const GPIO_Id ledsPins[3][3] = {
    {MT3620_RDB_LED1_RED, MT3620_RDB_LED1_GREEN, MT3620_RDB_LED1_BLUE}, 
	{MT3620_RDB_LED2_RED, MT3620_RDB_LED2_GREEN, MT3620_RDB_LED2_BLUE}, 
	{MT3620_RDB_NETWORKING_LED_RED, MT3620_RDB_NETWORKING_LED_GREEN, MT3620_RDB_NETWORKING_LED_BLUE}
};

static size_t blinkIntervalIndex = 0;
static RgbLedUtility_Colors ledBlinkColor = RgbLedUtility_Colors_Blue;

static const struct timespec blinkIntervals[] = {{0, 125000000}, {0, 250000000}, {0, 500000000}};
static const size_t blinkIntervalsCount = sizeof(blinkIntervals) / sizeof(*blinkIntervals);

// File descriptors - initialized to invalid value
static int epollFd = -1;
static int ledBlinkRateButtonGpioFd = -1;
static int sendMessageButtonGpioFd = -1;
static int buttonPollTimerFd = -1;
static int led1BlinkTimerFd = -1;
static int led2BlinkTimerFd = -1;
static int azureIoTDoWorkTimerFd = -1;

static int i2cBME280Fd = -1;

// Azure IoT poll periods
static const int AzureIoTDefaultPollPeriodSeconds = 5;
static const int AzureIoTMinReconnectPeriodSeconds = 60;
static const int AzureIoTMaxReconnectPeriodSeconds = 10 * 60;

static int azureIoTPollPeriodSeconds = -1;

static const char strJsonFormat[] = "{\"temperature\":%0.2f,\"pressure\":%0.2f,\"humidity\":%0.2f}";

// LED state
static RgbLed led1 = RGBLED_INIT_VALUE;
static RgbLed led2 = RGBLED_INIT_VALUE;
static RgbLed ledNetwork = RGBLED_INIT_VALUE;
static RgbLed *rgbLeds[] = {&led1, &led2, &ledNetwork };
static const size_t rgbLedsCount = sizeof(rgbLeds) / sizeof(*rgbLeds);

// Default blinking rate of LED1
static struct timespec blinkingLedPeriod = {0, 125000000};
static bool blinkingLedState;

// A null period to not start the timer when it is created with CreateTimerFdAndAddToEpoll.
static const struct timespec nullPeriod = {0, 0};
static const struct timespec defaultBlinkTimeLed2 = {0, 150 * 1000 * 1000};

// Connectivity state
static bool connectedToIoTHub = false;

// Termination state
static volatile sig_atomic_t terminationRequired = false;

/// <summary>
///     Signal handler for termination requests. This handler must be async-signal-safe.
/// </summary>
static void TerminationHandler(int signalNumber)
{
    // Don't use Log_Debug here, as it is not guaranteed to be async-signal-safe.
    terminationRequired = true;
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
    } else {
        Log_Debug("INFO: Currently connected WiFi network: \n");
        Log_Debug("INFO: SSID \"%.*s\", BSSID %02x:%02x:%02x:%02x:%02x:%02x, Frequency %dMHz.\n",
                  network.ssidLength, network.ssid, network.bssid[0], network.bssid[1],
                  network.bssid[2], network.bssid[3], network.bssid[4], network.bssid[5],
                  network.frequencyMHz);
    }
}

/// <summary>
///     Helper function to blink LED2 once.
/// </summary>
static void BlinkLed2Once(void)
{
    RgbLedUtility_SetLed(&led2, RgbLedUtility_Colors_Red);
    SetTimerFdToSingleExpiry(led2BlinkTimerFd, &defaultBlinkTimeLed2);
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
///     Toggles the blink speed of the blink LED between 3 values, and updates the device twin.
/// </summary>
/// <param name="rate">The blink rate</param>
static void SetLedRate(const struct timespec *rate)
{
    if (SetTimerFdToPeriod(led1BlinkTimerFd, rate) != 0) {
        Log_Debug("ERROR: could not set the period of the LED.\n");
        terminationRequired = true;
        return;
    }

    if (connectedToIoTHub) {
        // Report the current state to the Device Twin on the IoT Hub.
        AzureIoT_TwinReportState("LedBlinkRateProperty", blinkIntervalIndex);
    } else {
        Log_Debug("WARNING: Cannot send reported property; not connected to the IoT Hub.\n");
    }
}

/// <summary>
///     Sends a message to the IoT Hub.
/// </summary>
static void SendMessageToIoTHub(void)
{
    if (connectedToIoTHub) {
		bme280_data_t bmeData;
		char strJsonData[128];
		if (BME280_GetSensorData(&bmeData) == 0)
		{
			snprintf(strJsonData, sizeof(strJsonData), strJsonFormat,
				bmeData.temperature, bmeData.pressure, bmeData.humidity);
			Log_Debug("[SendMessage] %s\r\n",strJsonData);
			AzureIoT_SendMessage(strJsonData);

			// Set the send/receive LED2 to blink once immediately to indicate the message has been
			// queued.
			BlinkLed2Once();
		}
        // Send a message
    } else {
        Log_Debug("WARNING: Cannot send message: not connected to the IoT Hub.\n");
    }
}

/// <summary>
///     MessageReceived callback function, called when a message is received from the Azure IoT Hub.
/// </summary>
/// <param name="payload">The payload of the received message.</param>
static void MessageReceived(const char *payload)
{
    // Set the send/receive LED2 to blink once immediately to indicate a message has been received.
    BlinkLed2Once();
}

/// <summary>
///     Device Twin update callback function, called when an update is received from the Azure IoT
///     Hub.
/// </summary>
/// <param name="desiredProperties">The JSON root object containing the desired Device Twin
/// properties received from the Azure IoT Hub.</param>
static void DeviceTwinUpdate(JSON_Object *desiredProperties)
{
    JSON_Value *blinkRateJson = json_object_get_value(desiredProperties, "LedBlinkRateProperty");

    // If the attribute is missing or its type is not a number.
    if (blinkRateJson == NULL) {
        Log_Debug(
            "INFO: A device twin update was received that did not contain the property "
            "\"LedBlinkRateProperty\".\n");
    } else if (json_value_get_type(blinkRateJson) != JSONNumber) {
        Log_Debug(
            "INFO: Device twin desired property \"LedBlinkRateProperty\" was received with "
            "incorrect type; it must be an integer.\n");
    } else {
        // Get the value of the LedBlinkRateProperty and print it.
        size_t desiredBlinkRate = (size_t)json_value_get_number(blinkRateJson);

        blinkIntervalIndex =
            desiredBlinkRate % blinkIntervalsCount; // Clamp value to [0..blinkIntervalsCount) .

        Log_Debug("INFO: Received desired value %zu for LedBlinkRateProperty, setting it to %zu.\n",
                  desiredBlinkRate, blinkIntervalIndex);

        blinkingLedPeriod = blinkIntervals[blinkIntervalIndex];
        SetLedRate(&blinkIntervals[blinkIntervalIndex]);
    }
}

/// <summary>
///     Allocates and formats a string message on the heap.
/// </summary>
/// <param name="messageFormat">The format of the message</param>
/// <param name="maxLength">The maximum length of the formatted message string</param>
/// <returns>The pointer to the heap allocated memory.</returns>
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
/// <returns>200 HTTP status code if the method name is "LedColorControlMethod" and the color is
/// correctly parsed;
/// 400 HTTP status code is the color has not been recognised in the payload;
/// 404 HTTP status code if the method name is unknown.</returns>
static int DirectMethodCall(const char *methodName, const char *payload, size_t payloadSize,
                            char **responsePayload, size_t *responsePayloadSize)
{
    // Prepare the payload for the response. This is a heap allocated null terminated string.
    // The Azure IoT Hub SDK is responsible of freeing it.
    *responsePayload = NULL;  // Reponse payload content.
    *responsePayloadSize = 0; // Response payload content size.

    int result = 404; // HTTP status code.

    if (strcmp(methodName, "LedColorControlMethod") != 0) {
        result = 404;
        Log_Debug("INFO: Method not found called: '%s'.\n", methodName);

        static const char noMethodFound[] = "\"method not found '%s'\"";
        size_t responseMaxLength = sizeof(noMethodFound) + strlen(methodName);
        *responsePayload = SetupHeapMessage(noMethodFound, responseMaxLength, methodName);
        if (*responsePayload == NULL) {
            Log_Debug("ERROR: Could not allocate buffer for direct method response payload.\n");
            abort();
        }
        *responsePayloadSize = strlen(*responsePayload);
        return result;
    }

    RgbLedUtility_Colors ledColor = RgbLedUtility_Colors_Unknown;
    // The payload should contains JSON such as: { "color": "red"}
    char *directMethodCallContent = malloc(payloadSize + 1); // +1 to store null char at the end.
    if (directMethodCallContent == NULL) {
        Log_Debug("ERROR: Could not allocate buffer for direct method request payload.\n");
        abort();
    }

    memcpy(directMethodCallContent, payload, payloadSize);
    directMethodCallContent[payloadSize] = 0; // Null terminated string.
    JSON_Value *payloadJson = json_parse_string(directMethodCallContent);
    if (payloadJson == NULL) {
        goto colorNotFound;
    }
    JSON_Object *colorJson = json_value_get_object(payloadJson);
    if (colorJson == NULL) {
        goto colorNotFound;
    }
    const char *colorName = json_object_get_string(colorJson, "color");
    if (colorName == NULL) {
        goto colorNotFound;
    }

    ledColor = RgbLedUtility_GetColorFromString(colorName, strlen(colorName));

    // If color's name has not been identified.
    if (ledColor == RgbLedUtility_Colors_Unknown) {
        goto colorNotFound;
    }

    // Color's name has been identified.
    result = 200;
    const char *colorString = RgbLedUtility_GetStringFromColor(ledColor);
    Log_Debug("INFO: LED color set to: '%s'.\n", colorString);
    // Set the blinking LED color.
    ledBlinkColor = ledColor;

    static const char colorOkResponse[] =
        "{ \"success\" : true, \"message\" : \"led color set to %s\" }";
    size_t responseMaxLength = sizeof(colorOkResponse) + strlen(payload);
    *responsePayload = SetupHeapMessage(colorOkResponse, responseMaxLength, colorString);
    if (*responsePayload == NULL) {
        Log_Debug("ERROR: Could not allocate buffer for direct method response payload.\n");
        abort();
    }
    *responsePayloadSize = strlen(*responsePayload);

    return result;

colorNotFound:
    result = 400; // Bad request.
    Log_Debug("INFO: Unrecognised direct method payload format.\n");

    static const char noColorResponse[] =
        "{ \"success\" : false, \"message\" : \"request does not contain an identifiable "
        "color\" }";
    responseMaxLength = sizeof(noColorResponse);
    *responsePayload = SetupHeapMessage(noColorResponse, responseMaxLength);
    if (*responsePayload == NULL) {
        Log_Debug("ERROR: Could not allocate buffer for direct method response payload.\n");
        abort();
    }
    *responsePayloadSize = strlen(*responsePayload);

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
///     Handle the blinking for LED1.
/// </summary>
static void Led1UpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(led1BlinkTimerFd) != 0) {
        terminationRequired = true;
        return;
    }

    // Set network status with LED3 color.
    RgbLedUtility_Colors color =
        (connectedToIoTHub ? RgbLedUtility_Colors_Green : RgbLedUtility_Colors_Off);
    RgbLedUtility_SetLed(&ledNetwork, color);

    // Trigger LED to blink as appropriate.
    blinkingLedState = !blinkingLedState;
    color = (blinkingLedState ? ledBlinkColor : RgbLedUtility_Colors_Off);
    RgbLedUtility_SetLed(&led1, color);
}

/// <summary>
///     Handle the blinking for LED2.
/// </summary>
static void Led2UpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(led2BlinkTimerFd) != 0) {
        terminationRequired = true;
        return;
    }

    // Clear the send/receive LED2.
    RgbLedUtility_SetLed(&led2, RgbLedUtility_Colors_Off);
}

/// <summary>
///     Check whether a given button has just been pressed.
/// </summary>
/// <param name="fd">The button file descriptor</param>
/// <param name="oldState">Old state of the button (pressed or released)</param>
/// <returns>true if pressed, false otherwise</returns>
static bool IsButtonPressed(int fd, GPIO_Value_Type *oldState)
{
    bool isButtonPressed = false;
    GPIO_Value_Type newState;
    int result = GPIO_GetValue(fd, &newState);
    if (result != 0) {
        Log_Debug("ERROR: Could not read button GPIO: %s (%d).\n", strerror(errno), errno);
        terminationRequired = true;
    } else {
        // Button is pressed if it is low and different than last known state.
        isButtonPressed = (newState != *oldState) && (newState == GPIO_Value_Low);
        *oldState = newState;
    }

    return isButtonPressed;
}

/// <summary>
///     Handle button timer event: if the button is pressed, change the LED blink rate.
/// </summary>
static void ButtonPollTimerHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(buttonPollTimerFd) != 0) {
        terminationRequired = true;
        return;
    }

    // If the button is pressed, change the LED blink interval, and update the Twin Device.
    static GPIO_Value_Type blinkButtonState;
    if (IsButtonPressed(ledBlinkRateButtonGpioFd, &blinkButtonState)) {
        blinkIntervalIndex = (blinkIntervalIndex + 1) % blinkIntervalsCount;
        SetLedRate(&blinkIntervals[blinkIntervalIndex]);
    }

    // If the button is pressed, send a message to the IoT Hub.
    static GPIO_Value_Type messageButtonState;
    if (IsButtonPressed(sendMessageButtonGpioFd, &messageButtonState)) {
        SendMessageToIoTHub();
    }
}

/// <summary>
///     Hand over control periodically to the Azure IoT SDK's DoWork.
/// </summary>
static void AzureIoTDoWorkHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(azureIoTDoWorkTimerFd) != 0) {
        terminationRequired = true;
        return;
    }

    // Set up the connection to the IoT Hub client.
    // Notes it is safe to call this function even if the client has already been set up, as in
    //   this case it would have no effect
    if (AzureIoT_SetupClient()) {
        if (azureIoTPollPeriodSeconds != AzureIoTDefaultPollPeriodSeconds) {
            azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;

            struct timespec azureTelemetryPeriod = {azureIoTPollPeriodSeconds, 0};
            SetTimerFdToPeriod(azureIoTDoWorkTimerFd, &azureTelemetryPeriod);
        }

        // AzureIoT_DoPeriodicTasks() needs to be called frequently in order to keep active
        // the flow of data with the Azure IoT Hub
        AzureIoT_DoPeriodicTasks();
    } else {
        // If we fail to connect, reduce the polling frequency, starting at
        // AzureIoTMinReconnectPeriodSeconds and with a backoff up to
        // AzureIoTMaxReconnectPeriodSeconds
        if (azureIoTPollPeriodSeconds == AzureIoTDefaultPollPeriodSeconds) {
            azureIoTPollPeriodSeconds = AzureIoTMinReconnectPeriodSeconds;
        } else {
            azureIoTPollPeriodSeconds *= 2;
            if (azureIoTPollPeriodSeconds > AzureIoTMaxReconnectPeriodSeconds) {
                azureIoTPollPeriodSeconds = AzureIoTMaxReconnectPeriodSeconds;
            }
        }

        struct timespec azureTelemetryPeriod = {azureIoTPollPeriodSeconds, 0};
        SetTimerFdToPeriod(azureIoTDoWorkTimerFd, &azureTelemetryPeriod);

        Log_Debug("ERROR: Failed to connect to IoT Hub; will retry in %i seconds\n",
                  azureIoTPollPeriodSeconds);
    }
}

// event handler data structures. Only the event handler field needs to be populated.
static EventData buttonPollTimerEventData = {.eventHandler = &ButtonPollTimerHandler};
static EventData led1EventData = {.eventHandler = &Led1UpdateHandler};
static EventData led2EventData = {.eventHandler = &Led2UpdateHandler};
static EventData azureIoTEventData = {.eventHandler = &AzureIoTDoWorkHandler};

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

    // Open button A
    Log_Debug("INFO: Opening MT3620_RDB_BUTTON_A.\n");
    if (!OpenGpioFdAsInput(MT3620_RDB_BUTTON_A, &ledBlinkRateButtonGpioFd)) {
        return -1;
    }

    // Open button B
    Log_Debug("INFO: Opening MT3620_RDB_BUTTON_B.\n");
    if (!OpenGpioFdAsInput(MT3620_RDB_BUTTON_B, &sendMessageButtonGpioFd)) {
        return -1;
    }

    // Open file descriptors for the RGB LEDs and store them in the rgbLeds array (and in turn in
    // the ledBlink, ledMessageEventSentReceived, ledNetworkStatus variables)
    RgbLedUtility_OpenLeds(rgbLeds, rgbLedsCount, ledsPins);

    // Initialize the Azure IoT SDK
    if (!AzureIoT_Initialize()) {
        Log_Debug("ERROR: Cannot initialize Azure IoT Hub SDK.\n");
        return -1;
    }

    // Set the Azure IoT hub related callbacks
    AzureIoT_SetMessageReceivedCallback(&MessageReceived);
    AzureIoT_SetDeviceTwinUpdateCallback(&DeviceTwinUpdate);
    AzureIoT_SetDirectMethodCallback(&DirectMethodCall);
    AzureIoT_SetConnectionStatusCallback(&IoTHubConnectionStatusChanged);

    // Display the currently connected WiFi connection.
    DebugPrintCurrentlyConnectedWiFiNetwork();

    epollFd = CreateEpollFd();
    if (epollFd < 0) {
        return -1;
    }

    // Set up a timer for LED1 blinking
    led1BlinkTimerFd =
        CreateTimerFdAndAddToEpoll(epollFd, &blinkingLedPeriod, &led1EventData, EPOLLIN);
    if (led1BlinkTimerFd < 0) {
        return -1;
    }

    // Set up a timer for blinking LED2 once.
    led2BlinkTimerFd = CreateTimerFdAndAddToEpoll(epollFd, &nullPeriod, &led2EventData, EPOLLIN);
    if (led2BlinkTimerFd < 0) {
        return -1;
    }

    // Set up a timer for buttons status check
    static struct timespec buttonsPressCheckPeriod = {0, 1000000};
    buttonPollTimerFd = CreateTimerFdAndAddToEpoll(epollFd, &buttonsPressCheckPeriod,
                                                   &buttonPollTimerEventData, EPOLLIN);
    if (buttonPollTimerFd < 0) {
        return -1;
    }

    // Set up a timer for Azure IoT SDK DoWork execution.
    azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;
    struct timespec azureIoTDoWorkPeriod = {azureIoTPollPeriodSeconds, 0};
    azureIoTDoWorkTimerFd =
        CreateTimerFdAndAddToEpoll(epollFd, &azureIoTDoWorkPeriod, &azureIoTEventData, EPOLLIN);
    if (azureIoTDoWorkTimerFd < 0) {
        return -1;
    }

	i2cBME280Fd = BME280_Init(MT3620_I2C_ISU0, GROOVE_BME280_I2C_ADDRESS);
	if (i2cBME280Fd < 0) {
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
    CloseFdAndPrintError(ledBlinkRateButtonGpioFd, "LedBlinkRateButtonGpio");
    CloseFdAndPrintError(sendMessageButtonGpioFd, "SendMessageButtonGpio");
    CloseFdAndPrintError(buttonPollTimerFd, "ButtonPollTimer");
    CloseFdAndPrintError(azureIoTDoWorkTimerFd, "IoTDoWorkTimer");
    CloseFdAndPrintError(led1BlinkTimerFd, "Led1BlinkTimer");
    CloseFdAndPrintError(led2BlinkTimerFd, "Led2BlinkTimer");
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
    Log_Debug("INFO: Azure IoT application starting.\n");

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
