#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <time.h>

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"

#include <applibs/log.h>
#include <applibs/i2c.h>
#include <applibs/gpio.h>
#include <applibs/networking.h>
#include <applibs/wificonfig.h>
#include <applibs/powermanagement.h>

#include "mt3620_rdb.h"
#include "rgbled_utility.h"
#include "epoll_timerfd_utilities.h"

#include "BME280/Inc/libBME280.h"


// This sample C application for a MT3620 Reference Development Board (Azure Sphere) demonstrates how to
// connect an Azure Sphere device to Azure IoT Central. To use this sample, you must first
// run the ShowIoTCentralConfig.exe from <see href="https://github.com/Azure/azure-sphere-samples/tree/master/Samples/AzureIoT/Tools" />
// which outputs the required "CmdArgs" with the DPS scope id and "AllowedConnections" properties 
// for the Manifest (app_manifest.json) .
// You will also need to update the "DeviceAuthentication" property in the manifest 
// with your Azure Sphere TenantID. To find your TenantId, i.e. run the Azure Sphere Command line
//		azsphere tenant show-selected
//
// The sample leverages these functionalities of the Azure IoT SDK C together with Azure IoT Central:
// - Device to cloud messages;
// - Cloud to device messages;
// - Direct Method invocation;
// - Device Twin management;
//
// A description of the sample follows:
// - LED 1 blinks constantly.
// - Pressing button A toggles the rate at which LED 1 blinks between three values.
// - Pressing button B triggers reading sensor data and sending a message to the IoT Hub.
// - LED 2 flashes red when button B is pressed (and a
//   message is sent) and flashes yellow when a message is received.
// - NETWORK LED indicates whether network connection to the Azure IoT Hub has been
//   established (Red:No Network, Green:WiFi, Blue:IoT Hub connected).
//
// Direct Method related notes:
// - Invoking the method named "setColorMethod" with a payload containing '{"color":"red"}'
//   will set the color of blinking LED 1 to red.
// - Invoking the method named "resetMethod" with a payload containing '{"resetTimer":5}'
//   will arm a reset-timer to reboot the device after # seconds.
//
// Device Twin related notes:
// - Setting blinkRateProperty in the Device Twin to a value from 0 to 2 causes the sample to
//   update the blink rate of LED 1 accordingly, e.g '{"blinkRateProperty": { "value" : 2 }}';
// - Upon receipt of the blinkRateProperty desired value from the IoT hub, the sample updates
//   the device twin on the IoT hub with the new value for blinkRateProperty.
// - Pressing button A causes the sample to report the blink rate to the device
//   twin on the IoT Hub.

// This sample uses the API for the following Azure Sphere application libraries:
// - i2c (serial port for BME280 sensor);
// - gpio (digital input for button);
// - log (messages shown in Visual Studio's Device Output window during debugging);
// - wificonfig (configure WiFi settings);
// - azureiot (interaction with Azure IoT services)

#include "azure_iot_utilities.h"

// An array defining the RGB GPIOs for each LED on the device
static const GPIO_Id ledsPins[3][3] = {
    {MT3620_RDB_LED1_RED, MT3620_RDB_LED1_GREEN, MT3620_RDB_LED1_BLUE}, 
	{MT3620_RDB_LED2_RED, MT3620_RDB_LED2_GREEN, MT3620_RDB_LED2_BLUE}, 
	{MT3620_RDB_NETWORKING_LED_RED, MT3620_RDB_NETWORKING_LED_GREEN, MT3620_RDB_NETWORKING_LED_BLUE}
};

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
static int telemetryTimerFd = -1;
static int resetTimerFd = -1;
static int i2cBME280Fd = -1;

///<summary>telemetryTimerIntervals is set to send teleletry every 30 seconds</summary>
static const struct timespec telemetryTimerIntervals = {30, 0};
///<summary>default resetTimerInterval is set to reboot after 5 second (overridden by resetTimer property)</summary>
static struct timespec resetTimerInterval = { 5, 0 };


// Azure IoT poll periods
static const int AzureIoTDefaultPollPeriodSeconds = 5;
static const int AzureIoTMinReconnectPeriodSeconds = 60;
static const int AzureIoTMaxReconnectPeriodSeconds = 10 * 60;

static int azureIoTPollPeriodSeconds = -1;


static const char cstrErrorOutOfMemory[] = "ERROR: Could not allocate buffer for direct method response payload.\n";

// event telemetry strings
static const char cstrEvtConnected[] = "connect";
static const char cstrEvtButtonB[] = "buttonB";
static const char cstrEvtButtonA[] = "buttonA";
static const char cstrMsgOccurred[] = "occurred";
static const char cstrMsgPressed[] = "pressed";
static const char cstrMsgAppStart[] = "Application started";

// IoT Hub/IoT Central direct method names
static const char cstrSetColorMethod[] = "setColorMethod";
static const char cstrResetMethod[] = "resetMethod";

// forward declarations for method handlers
HTTP_STATUS_CODE SetColorMethod(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress);
HTTP_STATUS_CODE ResetMethod(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress);

// forward declarations for close handlers
void ClosePeripheralsAndHandlers(void);

// list of method registrations
static const MethodRegistration Methods[] = {
    {.MethodName = cstrSetColorMethod, .MethodHandler = &SetColorMethod},
    {.MethodName = cstrResetMethod, .MethodHandler = &ResetMethod},
    {.MethodName = NULL, .MethodHandler = NULL}
};


// json property names and values
static const char cstrColorProperty[] = "color";
static const char cstrResetTimerProperty[] = "resetTimer";
static const char cstrSuccessProperty[] = "success";
static const char cstrMessageProperty[] = "message";
static const char cstrTemperatureProperty[] = "temperature";
static const char cstrPressureProperty[] = "pressure";
static const char cstrHumidityProperty[] = "humidity";
static const char cstrLedBlinkRateProperty[] = "blinkRateProperty";
static const char cstrLedBlinkRateValuePath[] = "blinkRateProperty.value";
static const char cstrValueProperty[] = "value";
static const char cstrSysVersionProperty[] = "$version";
static const char cstrStatusProperty[] = "status";
static const char cstrDesiredVersionProperty[] = "desiredVersion";
static const char cstrCompleted[] = "completed";

///<summary>Azure IoT PnP compatible DeviceInformation</summary>  
static const char cstrDeviceInformation[] = 
"{"
"\"manufacturer\":\"Seeed\","
"\"model\":\"MT3620 Developer Kit\","
"\"swVersion\":\"SphereBME280Lab v20.04\","
"\"osName\":\"Azure Sphere IoT OS\","
"\"processorArchitecture\":\"ARM Core A7,M4\","
"\"processorManufacturer\":\"MediaTek\","
"\"totalStorage\":16384,"
"\"totalMemory\":4096"
"}";

// method response messages
static const char cstrColorResponseMsg[] = "LED color set to %s";
static const char cstrResetResponseMsg[] = "Reset in %d seconds";

static const char cstrBadDataResponseMsg[] = "Request does not contain identifiable data.";

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
static const struct timespec defaultBlinkTimeLed2 = {0, 300 * 1000 * 1000};
//static const struct timespec errorBlinkTimeLed2 = { 1, 0 };


// forward declarations for timer handler
void ButtonPollTimerHandler(EventData* eventData);
void Led1UpdateHandler(EventData* eventData);
void Led2UpdateHandler(EventData* eventData);
void AzureIoTDoWorkHandler(EventData* eventData);
void TelemetryTimerHandler(EventData* eventData);
void ResetTimerHandler(EventData* eventData);

// event handler data structures. Only the event handler field needs to be populated.
static EventData buttonPollTimerEventData = { .eventHandler = &ButtonPollTimerHandler };
static EventData led1EventData = { .eventHandler = &Led1UpdateHandler };
static EventData led2EventData = { .eventHandler = &Led2UpdateHandler };
static EventData azureIoTEventData = { .eventHandler = &AzureIoTDoWorkHandler };
static EventData telemetryTimerEventData = { .eventHandler = &TelemetryTimerHandler };
static EventData resetTimerEventData = { .eventHandler = &ResetTimerHandler };

/// <summary>
/// IoT hub client status
/// </summary>
static bool connectedToIoTHub = false;
/// <summary>
/// Reason for last disconnect
/// </summary>
static const char* pstrConnectionStatus = cstrMsgAppStart;

/// <summary>
/// desired property blinkRateProperty 
/// </summary>
static size_t blinkIntervalIndex = 0;

/// <summary>
/// desired property blinkRateProperty version
/// </summary>
static unsigned int blinkIntervalVersion = 1;

/// <summary>
/// Termination state
/// </summary>
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
///     Allocates and formats a string message on the heap.
/// </summary>
/// <param name="messageFormat">The format of the message</param>
/// <param name="maxLength">The maximum length of the formatted message string</param>
/// <returns>The pointer to the heap allocated memory.</returns>
static void* SetupHeapMessage(const char* messageFormat, size_t maxLength, ...)
{
    char* message = malloc(maxLength + 1); // Ensure there is space for the null terminator put by vsnprintf.
    if (message == NULL) {
        Log_Debug(cstrErrorOutOfMemory);
        abort();
    }

    va_list args;
    va_start(args, maxLength);
    vsnprintf(message, maxLength, messageFormat, args);
    va_end(args);
    return message;
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
static void BlinkLed2Once( RgbLedUtility_Colors color )
{
    RgbLedUtility_SetLed(&led2,color);
    SetTimerFdToSingleExpiry(led2BlinkTimerFd, ((color == RgbLedUtility_Colors_Red) ? &defaultBlinkTimeLed2 : &defaultBlinkTimeLed2));
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
///     Toggles the blink speed of the blink LED between 3 values.
/// </summary>
/// <param name="rate">ptr to blink rate</param>
static void SetLedRate(const struct timespec * pBlinkRate)
{
    if (SetTimerFdToPeriod(led1BlinkTimerFd, pBlinkRate) != 0) {
        Log_Debug("ERROR: could not set the period of the LED.\n");
        terminationRequired = true;
        return;
    }
}

/// <summary>
/// Sends an event to Azure IoT Central
/// </summary>
/// <param name="cstrEvent">event name</param>
/// <param name="pstrMessage">event message</param>
static void SendEventMessage(const char * cstrEvent, const char * cstrMessage)
{
	if (connectedToIoTHub) {
		Log_Debug("[Send] Event '%s' is '%s'\n", cstrEvent, cstrMessage);

        JSON_Value* jsonRoot = json_value_init_object();
        json_object_set_string(json_object(jsonRoot), cstrEvent, cstrMessage);

		// Send a message
		AzureIoT_SendJsonMessage(jsonRoot);

        json_value_free(jsonRoot);

		// Set the send/receive LED2 to blink once immediately to indicate 
		// the message has been queued.
		BlinkLed2Once(RgbLedUtility_Colors_Green);
	}
	else {
		Log_Debug("[Send] not connected to IoT Central: no event sent.\n");
		BlinkLed2Once(RgbLedUtility_Colors_Red);
	}
}

/// <summary>
///     Sends a telemetry message to Azure IoT Central.
/// </summary>
static void SendTelemetryMessage(void)
{
    if (connectedToIoTHub) {
		bme280_data_t bmeData;
		
		if (BME280_GetSensorData(&bmeData) == 0)
		{
			Log_Debug("[Send] Temperature: %.2f, Pressure: %.2f, Humidity: %.2f\n", bmeData.temperature, bmeData.pressure, bmeData.humidity);

            JSON_Value * jsonRoot = json_value_init_object();
            JSON_Object* jsonObject = json_value_get_object( jsonRoot );
            json_object_set_number(jsonObject, cstrTemperatureProperty, bmeData.temperature);
            json_object_set_number(jsonObject, cstrPressureProperty, bmeData.pressure);
            json_object_set_number(jsonObject, cstrHumidityProperty, bmeData.humidity);
            
            // Send a message
            AzureIoT_SendJsonMessage(jsonRoot);

            json_value_free(jsonRoot);

			// Set the send/receive LED2 to blink once immediately to indicate 
			// the message has been queued.
			BlinkLed2Once( RgbLedUtility_Colors_Green );
		}
    } else {
		Log_Debug("[Send] not connected to IoT Central: no telemtry sent.\n");
		BlinkLed2Once(RgbLedUtility_Colors_Red);
	}
}

/// <summary>
///     MessageReceived callback function, called when a message is received from the Azure IoT Hub.
/// </summary>
/// <param name="payload">The payload of the received message.</param>
static void MessageReceived(const char *payload)
{
    // Set the send/receive LED2 to blink once immediately to indicate a message has been received.
	BlinkLed2Once(RgbLedUtility_Colors_Blue);
}

/// <summary>
///     Device Twin update callback function, called when an update is received from the Azure IoT
///     Hub.
/// </summary>
/// <param name="desiredProperties">The JSON root object containing the desired Device Twin
/// properties received from the Azure IoT Hub.</param>
static void DeviceTwinUpdate(JSON_Object *desiredProperties)
{
	if (json_object_has_value_of_type(desiredProperties, cstrLedBlinkRateProperty, JSONObject))
	{
        unsigned int desiredVersion = (unsigned int)json_object_get_number(desiredProperties, cstrSysVersionProperty);

        JSON_Object * desiredBlinkRateProperty = json_object_get_object(desiredProperties, cstrLedBlinkRateProperty);
		size_t desiredBlinkRate = (size_t)json_object_get_number(desiredBlinkRateProperty, cstrValueProperty);

		blinkIntervalIndex = desiredBlinkRate % blinkIntervalsCount; // Clamp value to [0..blinkIntervalsCount) .
        blinkIntervalVersion = desiredVersion;

		Log_Debug("[DeviceTwinUpdate] Received desired value %zu for blinkRateProperty, setting it to %zu.\n",
			desiredBlinkRate, blinkIntervalIndex);

		blinkingLedPeriod = blinkIntervals[blinkIntervalIndex];
		SetLedRate(&blinkIntervals[blinkIntervalIndex]);

        // REMARK: IoT Central desired property response needs to be { "blinkRateProperty" : { "value" : ##, "desiredVersion" : ##, "status" : "completed" } } 
        JSON_Value* jsonRoot = json_value_init_object();
        JSON_Value* jsonProperty = json_value_init_object();
        JSON_Object* jsonObject = json_value_get_object(jsonProperty);

        json_object_set_value(json_object(jsonRoot), cstrLedBlinkRateProperty, jsonProperty);

        json_object_set_number(jsonObject, cstrValueProperty, (double)blinkIntervalIndex);
        json_object_set_number(jsonObject, cstrDesiredVersionProperty, (double)blinkIntervalVersion);
        json_object_set_string(jsonObject, cstrStatusProperty, cstrCompleted);

        // Report the current state to the Device Twin on the IoT Hub.
        AzureIoT_TwinReportStateJson(jsonRoot);

        json_value_free(jsonRoot);


		BlinkLed2Once(RgbLedUtility_Colors_Blue);
	} else {
		Log_Debug( "[DeviceTwinUpdate] received update with incorrect data:\n");
		BlinkLed2Once(RgbLedUtility_Colors_Red);
	}
}


///<summary>
/// setColor-Method takes payload in form of { "color": "red" } to set LED blink color
///</summary>
/// <param name="jsonParameters">json message payload</param>
/// <param name="jsonResponseAddress">address of response message payload</param>
/// <returns>HTTP status return value.</returns>
HTTP_STATUS_CODE SetColorMethod(JSON_Value * jsonParameters, JSON_Value** jsonResponseAddress)
{
    Log_Debug("[SetColorMethod]: Invoked.\n");

    HTTP_STATUS_CODE result = HTTP_BAD_REQUEST; // HTTP status code : Bad Request.
    RgbLedUtility_Colors ledColor = RgbLedUtility_Colors_Unknown;
    JSON_Value* jsonResponse = json_value_init_object();
    JSON_Object* jsonObject = json_value_get_object(jsonResponse);

    // The payload should contains JSON such as: { "color": "red"}
    if (jsonParameters != NULL) {
        JSON_Object* jsonRootObject = json_value_get_object(jsonParameters);
        const char* pszColorName = json_object_get_string(jsonRootObject, cstrColorProperty);
        if (pszColorName != NULL) {
            size_t nColorNameLength = strlen(pszColorName);
            ledColor = RgbLedUtility_GetColorFromString(pszColorName, nColorNameLength);
            if (ledColor != RgbLedUtility_Colors_Unknown) { // Color's name has been identified.

                json_object_set_boolean(jsonObject, cstrSuccessProperty, true);
                char* pszMsg = SetupHeapMessage(cstrColorResponseMsg, 64, pszColorName);
                json_object_set_string(jsonObject, cstrMessageProperty, pszMsg);
                free(pszMsg);
                
                // Set the blinking LED color.
                ledBlinkColor = ledColor;
                Log_Debug("[SetColorMethod]: LED color set to: '%s'.\n", pszColorName);
                result = HTTP_OK;
            }
        }
    }

    if (result != HTTP_OK)
    {
        Log_Debug("[SetColorMethod]: Unrecognised payload.\n");
        json_object_set_boolean(jsonObject, cstrSuccessProperty, false);
        json_object_set_string(jsonObject, cstrMessageProperty, cstrBadDataResponseMsg);
    }

    *jsonResponseAddress = jsonResponse;
    return result;
}

///<summary>
/// reset-Method arms the reset counter 
///</summary>
/// <param name="jsonParameters">json message payload</param>
/// <param name="jsonResponseAddress">address of response message payload</param>
/// <returns>HTTP status return value.</returns>
HTTP_STATUS_CODE ResetMethod(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress)
{
    Log_Debug("[ResetMethod]: Invoked.\n");

    HTTP_STATUS_CODE result = HTTP_BAD_REQUEST; // HTTP status code : Bad Request.
    JSON_Value* jsonResponse = json_value_init_object();
    JSON_Object* jsonObject = json_value_get_object(jsonResponse);

    // The payload should contain JSON such as: { "resetTimer": 5}
    if (jsonParameters != NULL) {
        JSON_Object* jsonRootObject = json_value_get_object(jsonParameters);
        time_t tResetInterval = (time_t) json_object_get_number(jsonRootObject, cstrResetTimerProperty);
        if ((tResetInterval > 1) && (tResetInterval < 10)) {

            resetTimerInterval.tv_sec = (time_t)tResetInterval;
            // arm count down timer
            SetTimerFdToSingleExpiry(resetTimerFd, &resetTimerInterval);
            Log_Debug("[ResetMethod]: set timer to %d seconds.\n", resetTimerInterval.tv_sec);

            json_object_set_boolean(jsonObject, cstrSuccessProperty, true);
            char* pszMsg = SetupHeapMessage(cstrResetResponseMsg, 64, (int)tResetInterval);
            json_object_set_string(jsonObject, cstrMessageProperty, pszMsg);
            free(pszMsg);

            result = HTTP_OK;
        }
    }

    if (result != HTTP_OK)
    {
        Log_Debug("[ResetMethod]: Unrecognised payload.\n");
        json_object_set_boolean(jsonObject, cstrSuccessProperty, false);
        json_object_set_string(jsonObject, cstrMessageProperty, cstrBadDataResponseMsg);
    }

    *jsonResponseAddress = jsonResponse;
    return result;
}



/// <summary>
///     IoT Hub connection status callback function.
/// </summary>
/// <param name="connected">'true' when the connection to the IoT Hub is established.</param>
/// <param name="statusText">connect/disconnect reason</param>
static void IoTHubConnectionStatusChanged(bool connected, const char *statusText)
{
    connectedToIoTHub = connected;
	if (connectedToIoTHub)
	{
        Log_Debug("[IoTHubConnectionStatusChanged]: Connected.\n");
        // send a "connect" event telemetry message
		SendEventMessage(cstrEvtConnected, pstrConnectionStatus);
        pstrConnectionStatus = cstrEvtConnected;

        // report initial Azure IoT PnP-compatible DeviceInformation
        AzureIoT_TwinReportState( cstrDeviceInformation, sizeof(cstrDeviceInformation));

        // and at last start the telemetry timer
        SetTimerFdToPeriod(telemetryTimerFd, &telemetryTimerIntervals);
    }
    else {
        Log_Debug("[IoTHubConnectionStatusChanged]: Disconnected.\n");
        SetTimerFdToPeriod(telemetryTimerFd, &nullPeriod);
        pstrConnectionStatus = statusText;
    }
}

/// <summary>
///     Handle the blinking for LED1.
/// </summary>
void Led1UpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(led1BlinkTimerFd) != 0) {
        terminationRequired = true;
        return;
    }

    // Set network status with LED3 color.
	RgbLedUtility_Colors color = RgbLedUtility_Colors_Red;
	bool bNetworkReady = false;
	Networking_IsNetworkingReady(&bNetworkReady);
	if (bNetworkReady)
	{
		color = (connectedToIoTHub ? RgbLedUtility_Colors_Blue : RgbLedUtility_Colors_Green);
	}
    RgbLedUtility_SetLed(&ledNetwork, color);

    // Trigger LED1 to blink as appropriate.
    blinkingLedState = !blinkingLedState;
    color = (blinkingLedState ? ledBlinkColor : RgbLedUtility_Colors_Off);
    RgbLedUtility_SetLed(&led1, color);
}

/// <summary>
///     Handle the blinking for LED2.
/// </summary>
void Led2UpdateHandler(EventData *eventData)
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
void ButtonPollTimerHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(buttonPollTimerFd) != 0) {
        terminationRequired = true;
        return;
    }

    // If the button A is pressed, change the LED blink interval, and update the Twin Device.
    static GPIO_Value_Type blinkButtonState;
    if (IsButtonPressed(ledBlinkRateButtonGpioFd, &blinkButtonState)) {
		blinkIntervalIndex = (blinkIntervalIndex + 1) % blinkIntervalsCount;
        SetLedRate(&blinkIntervals[blinkIntervalIndex]);

        if (connectedToIoTHub) {
            // REMARK: IoT Central in short form desired property is { "blinkRateProperty" : { "value" : ## } } 
            JSON_Value* jsonRoot = json_value_init_object();
            json_object_dotset_number(json_object(jsonRoot), cstrLedBlinkRateValuePath, (double)blinkIntervalIndex);

            // Report the current state to the Device Twin on the IoT Hub.
            AzureIoT_TwinReportStateJson(jsonRoot);

            json_value_free(jsonRoot);

            SendEventMessage(cstrEvtButtonA, cstrMsgPressed);
        }
        else {
            Log_Debug("WARNING: Cannot send buttonA event: not connected to the IoT Hub.\n");
        }
    }

    // If the button B is pressed, send a message to the IoT Hub.
    static GPIO_Value_Type messageButtonState;
    if (IsButtonPressed(sendMessageButtonGpioFd, &messageButtonState)) {
        if (connectedToIoTHub) {
		    SendEventMessage(cstrEvtButtonB, cstrMsgPressed);
		    SendTelemetryMessage();
        }
        else {
            Log_Debug("WARNING: Cannot send buttonB event: not connected to the IoT Hub.\n");
        }
    }
}

/// <summary>
///     Hand over control periodically to the Azure IoT SDK's DoWork.
/// </summary>
void AzureIoTDoWorkHandler(EventData *eventData)
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

/// <summary>
///     Handle telemetry timer event.
/// </summary>
void TelemetryTimerHandler(EventData *eventData)
{
	if (ConsumeTimerFdEvent(eventData->fd) != 0) {
		terminationRequired = true;
		return;
	}

	SendTelemetryMessage();
}


/// <summary>
///     Handle reset timer event.
/// </summary>
void ResetTimerHandler(EventData* eventData)
{
    if (ConsumeTimerFdEvent(eventData->fd) != 0) {
        terminationRequired = true;
        return;
    }

    PowerManagement_ForceSystemReboot();
    terminationRequired = true;
}

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

    Log_Debug("INFO: Opening MT3620_ISU3_I2C.\n");
    if ((i2cBME280Fd = I2CMaster_Open(MT3620_ISU3_I2C)) < 0)
    {
        return -1;
    }

    // Open file descriptors for the RGB LEDs and store them in the rgbLeds array (and in turn in
    // the ledBlink, ledMessageEventSentReceived, ledNetworkStatus variables)
    RgbLedUtility_OpenLeds(rgbLeds, rgbLedsCount, ledsPins);

    // Initialize I2C sensor(s)
    Log_Debug("INFO: Initializing BME280 I2C sensor on primary address.\n");
    bool bInitSuccessful = BME280_Init(i2cBME280Fd, GROOVE_BME280_I2C_ADDRESS);
    if (!bInitSuccessful) {
        return -1;
    }

    // Initialize the Azure IoT SDK
    if (!AzureIoT_Initialize()) {
        Log_Debug("ERROR: Cannot initialize Azure IoT Hub SDK.\n");
        return -1;
    }

    // Set the Azure IoT hub related callbacks
    AzureIoT_SetMessageReceivedCallback( &MessageReceived );
    AzureIoT_SetDeviceTwinUpdateCallback( &DeviceTwinUpdate );
    AzureIoT_RegisterDirectMethodHandlers( &Methods[0] );
    AzureIoT_SetConnectionStatusCallback( &IoTHubConnectionStatusChanged );

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

    // Set up a a dis-armed timer for blinking LED2 once.
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


	// Set up a timer for telemetry intervals
	telemetryTimerFd = CreateTimerFdAndAddToEpoll(epollFd, &nullPeriod,
		&telemetryTimerEventData, EPOLLIN);
	if (telemetryTimerFd < 0) {
		return -1;
	}

    // Set up a dis-armed timer for the reset interval
    resetTimerFd = CreateTimerFdAndAddToEpoll(epollFd, &nullPeriod,
        &resetTimerEventData, EPOLLIN);
    if (resetTimerFd < 0) {
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

    return 0;
}

/// <summary>
///     Close peripherals and Azure IoT
/// </summary>
void ClosePeripheralsAndHandlers(void)
{
    Log_Debug("INFO: Closing GPIOs and Azure IoT client.\n");

    // Close timer file descriptors
    CloseFdAndPrintError(resetTimerFd, "ResetTimer");
    CloseFdAndPrintError(telemetryTimerFd, "TelemetryTimer");
    CloseFdAndPrintError(buttonPollTimerFd, "ButtonPollTimer");
    CloseFdAndPrintError(led2BlinkTimerFd, "Led2BlinkTimer");
    CloseFdAndPrintError(led1BlinkTimerFd, "Led1BlinkTimer");
    CloseFdAndPrintError(azureIoTDoWorkTimerFd, "IoTDoWorkTimer");
    CloseFdAndPrintError(epollFd, "Epoll");

    // Close IO file descriptors
    CloseFdAndPrintError(ledBlinkRateButtonGpioFd, "LedBlinkRateButtonGpio");
    CloseFdAndPrintError(sendMessageButtonGpioFd, "SendMessageButtonGpio");
    CloseFdAndPrintError(i2cBME280Fd, "I2C ISU3");

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

	if (argc > 1)
	{
		// 2nd parameter should be DPS Scope ID
		AzureIoT_SetDPSScopeID(argv[1]);
	}



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
