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
#include <applibs/applications.h>

#ifdef BME280
#include <libBME280.h>
#endif

#ifdef BMP280
#include <libBMP280.h>
#endif

#include "mt3620_rdb.h"
#include "rgbled_utility.h"
#include "epoll_timerfd_utilities.h"
#include "azure_iot_utilities.h"


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
// - LED 2 flashes red when a message is sent and flashes yellow when a message is received.
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
//   update the blink rate of LED 1 accordingly, e.g '{"blinkRateProperty": 2 }';
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

// An array defining the RGB GPIOs for each LED on the device
static const GPIO_Id gpioLedPins[3][3] = {
    {MT3620_RDB_LED1_RED, MT3620_RDB_LED1_GREEN, MT3620_RDB_LED1_BLUE}, 
	{MT3620_RDB_LED2_RED, MT3620_RDB_LED2_GREEN, MT3620_RDB_LED2_BLUE}, 
	{MT3620_RDB_NETWORKING_LED_RED, MT3620_RDB_NETWORKING_LED_GREEN, MT3620_RDB_NETWORKING_LED_BLUE}
};

static RgbLedUtility_Colors colBlinkingLedColor = RgbLedUtility_Colors_Blue;

static const struct timespec atsBlinkingIntervals[] = {{0, 125000000}, {0, 250000000}, {0, 500000000}};
static const size_t nBlinkingIntervalsCount = sizeof(atsBlinkingIntervals) / sizeof(*atsBlinkingIntervals);

// File descriptors - initialized to invalid value
static int fdEpoll = -1;
static int fdBlinkRateButtonGpio = -1;
static int fdSendMessageButtonGpio = -1;
static int fdButtonPollTimer = -1;
static int fdLed1BlinkTimer = -1;
static int fdLed2FlashTimer = -1;
static int fdAzureIoTWorkerTimer = -1;
static int fdTelemetryTimer = -1;
static int fdResetTimer = -1;
static int fdSensorI2c = -1;

///<summary>tsTelemetryInterval is set to send teleletry every 30 seconds</summary>
static const struct timespec tsTelemetryInterval = {30, 0};

///<summary>default tsResetDelay is set to reboot after 5 second (overridden by resetTimer property)</summary>
static struct timespec tsResetDelay = { 5, 0 };


// Azure IoT poll periods
static const int AzureIoTDefaultPollPeriodSeconds = 5;
static const int AzureIoTMinReconnectPeriodSeconds = 10;
static const int AzureIoTMaxReconnectPeriodSeconds = 10 * 60;

static int azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;

static const char cstrErrorOutOfMemory[] = "ERROR: Out of memory.\n";

// telemetry events
static const char cstrEvtConnected[] = "connect";
static const char cstrEvtButtonB[] = "buttonB";
static const char cstrEvtButtonA[] = "buttonA";

// telemetry event messages
static const char cstrMsgPressed[] = "pressed";
static const char cstrMsgApplicationStarted[] = "Application started";
//static const char cstrMsgOccurred[] = "occurred";


// forward declarations for method handlers
HTTP_STATUS_CODE SetColorMethod(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress);
HTTP_STATUS_CODE ResetMethod(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress);

// list of method registrations
static const MethodRegistration clstDirectMethods[] = {
    {.MethodName = "setColorMethod", .MethodHandler = &SetColorMethod},
    {.MethodName = "resetMethod", .MethodHandler = &ResetMethod},
    {.MethodName = NULL, .MethodHandler = NULL}
};


// json property names and values
static const char cstrColorProperty[] = "color";
static const char cstrResetTimerProperty[] = "resetTimer";
static const char cstrSuccessProperty[] = "success";
static const char cstrMessageProperty[] = "message";
static const char cstrTemperatureProperty[] = "temperature";
static const char cstrPressureProperty[] = "pressure";
#ifdef BME280
    static const char cstrHumidityProperty[] = "humidity";
#endif
static const char cstrLedBlinkRateProperty[] = "blinkRateProperty";
static const char cstrValueProperty[] = "value";
static const char cstrVersionProperty[] = "av";
static const char cstrStatusProperty[] = "ac";
static const char cstrStatusDescriptionProperty[] = "ad";
static const char cstrSysVersionProperty[] = "$version";
static const char cstrCompleted[] = "completed";

///<summary>Azure IoT PnP compatible DeviceInformation</summary>  
static const char cstrDevInfoManufacturerProperty[] = "manufacturer";
static const char cstrDevInfoModelProperty[] = "model";
static const char cstrDevInfoSWVersionProperty[] = "swVersion";
static const char cstrDevInfoOSNameProperty[] = "osName";
static const char cstrDevInfoProcArchProperty[] = "processorArchitecture";
static const char cstrDevInfoProcMfgrProperty[] = "processorManufacturer";
static const char cstrDevInfoStorageProperty[] = "totalStorage";
static const char cstrDevInfoMemoryProperty[] = "totalMemory";

static const char cstrDevInfoManufacturerValue[] = "Seeed";
static const char cstrDevInfoModelValue[] = "MT3620 Developer Kit";
static const char cstrDevInfoSWVersionValue[] = "SphereBME280 v21.05.17.1130";
static const char cstrDevInfoOSNameValue[] = "Azure Sphere IoT OS";
static const char cstrDevInfoProcArchValue[] = "ARM Core A7,M4";
static const char cstrDevInfoProcMfgrValue[] = "MediaTek";
static const int ciDevInfoStorageValue = 16384;
static const int ciDevInfoMemoryValue = 4096;

///<summary>Azure IoT PnP compatible device-health</summary>
static const char cstrDevHealthTotalMemoryUsed[] ="totalMemoryUsed";
static const char cstrDevHealthUserMemoryUsed[] ="userMemoryUsed";

static size_t nLastTotalMemoryUsed = 0;
static size_t nLastUserMemoryUsed = 0;

// method response messages
static const char cstrColorResponseMsg[] = "LED color set to %s";
static const char cstrResetResponseMsg[] = "Reset in %d seconds";
static const char cstrBadDataResponseMsg[] = "Request does not contain identifiable data.";

// LED state
static RgbLed rgbLed1 = RGBLED_INIT_VALUE;
static RgbLed rgbLed2 = RGBLED_INIT_VALUE;
static RgbLed rgbNetworkLed = RGBLED_INIT_VALUE;
static RgbLed *rgbLeds[] = {&rgbLed1, &rgbLed2, &rgbNetworkLed };
static const size_t nLedCount = sizeof(rgbLeds) / sizeof(*rgbLeds);

// Default blinking rate of LED1
static struct timespec tsBlinkingLedInterval = {0, 125000000};
static bool bBlinkingLedState;

// A null interval to not start the timer when it is created with CreateTimerFdAndAddToEpoll.
static const struct timespec tsNullInterval = {0, 0};

// Led2 flashes for 300ms 
static const struct timespec tsLed2BlinkTime = {0, 300 * 1000 * 1000};

// forward declarations for timer handler
void ButtonPollTimerHandler(EventData* eventData);
void Led1UpdateHandler(EventData* eventData);
void Led2UpdateHandler(EventData* eventData);
void AzureIoTDoWorkHandler(EventData* eventData);
void TelemetryTimerHandler(EventData* eventData);
void ResetTimerHandler(EventData* eventData);

// event handler data structures. Only the event handler field needs to be populated.
static EventData evtdataButtonPollTimer = { .eventHandler = &ButtonPollTimerHandler };
static EventData evtdataLed1Update = { .eventHandler = &Led1UpdateHandler };
static EventData evtdataLed2Update = { .eventHandler = &Led2UpdateHandler };
static EventData evtdataAzureIoTWorker = { .eventHandler = &AzureIoTDoWorkHandler };
static EventData evtdataTelemetryTimer = { .eventHandler = &TelemetryTimerHandler };
static EventData evtdataResetTimer = { .eventHandler = &ResetTimerHandler };


// forward declarations for close handlers
void ClosePeripheralsAndHandlers(void);

/// <summary>
/// network connectivety status. Frequently updated in ButtonPollTimerHandler
/// </summary>
static bool bNetworkReady = false;
/// <summary>
/// IoT hub client status
/// </summary>
static bool connectedToIoTHub = false;
/// <summary>
/// Reason for last disconnect
/// </summary>
static const char* pstrConnectionStatus = cstrMsgApplicationStarted;

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
        Log_Debug("INFO: SSID \"%.*s\", BSSID %02x:%02x:%02x:%02x:%02x:%02x, Frequency %dMHz, Signal %d.\n",
                  network.ssidLength, network.ssid, network.bssid[0], network.bssid[1],
                  network.bssid[2], network.bssid[3], network.bssid[4], network.bssid[5],
                  network.frequencyMHz, network.signalRssi);
    }
}

/// <summary>
///     Helper function to blink LED2 once.
/// </summary>
static void BlinkLed2Once( RgbLedUtility_Colors color )
{
    RgbLedUtility_SetLed(&rgbLed2,color);
    SetTimerFdToSingleExpiry(fdLed2FlashTimer, ((color == RgbLedUtility_Colors_Red) ? &tsLed2BlinkTime : &tsLed2BlinkTime));
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
    if (SetTimerFdToPeriod(fdLed1BlinkTimer, pBlinkRate) != 0) {
        Log_Debug("ERROR: could not set the period of the LED.\n");
        terminationRequired = true;
        return;
    }

    // report changed blink rate as property to IoT Central
    if (connectedToIoTHub) {
        // REMARK: Since August 2020, IoT Central reported property schema is { "blinkRateProperty" : ## } 
        // <seealso href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#properties" />
        JSON_Value* jsonRoot = json_value_init_object();
        json_object_set_number(json_object(jsonRoot), cstrLedBlinkRateProperty, (double)blinkIntervalIndex);

        // Report the current state to the Device Twin on the IoT Hub.
        AzureIoT_TwinReportStateJson(jsonRoot);

        json_value_free(jsonRoot);
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
        JSON_Value * jsonRoot = json_value_init_object();
        JSON_Object* jsonObject = NULL;

#ifdef BME280		
		bme280_data_t bmeData;
		if (BME280_GetSensorData(&bmeData) == 0)
		{
			Log_Debug("[Send] Temperature: %.2f, Pressure: %.2f, Humidity: %.2f\n", bmeData.temperature, bmeData.pressure, bmeData.humidity);
            jsonObject = json_value_get_object( jsonRoot );
            json_object_set_number(jsonObject, cstrTemperatureProperty, bmeData.temperature);
            json_object_set_number(jsonObject, cstrPressureProperty, bmeData.pressure);
            json_object_set_number(jsonObject, cstrHumidityProperty, bmeData.humidity);
		}
#endif

#ifdef BMP280		
		bmp280_data_t bmpData;

		if (BMP280_GetSensorData(&bmpData) == 0)
		{
			Log_Debug("[Send] Temperature: %.2f, Pressure: %.2f\n", bmpData.temperature, bmpData.pressure);
            jsonObject = json_value_get_object( jsonRoot );
            json_object_set_number(jsonObject, cstrTemperatureProperty, bmpData.temperature);
            json_object_set_number(jsonObject, cstrPressureProperty, bmpData.pressure);
		}
#endif

        size_t nTotalMemUsed = Applications_GetTotalMemoryUsageInKB();
        size_t nUserMemUsed = Applications_GetUserModeMemoryUsageInKB();
        if( (nLastTotalMemoryUsed != nTotalMemUsed) || (nLastUserMemoryUsed != nUserMemUsed) ){
			Log_Debug("[Send] TotalMemoryUsed: %d, UserMemoryUsed: %d\n", nTotalMemUsed, nUserMemUsed);

            nLastTotalMemoryUsed = nTotalMemUsed;
            nLastUserMemoryUsed = nUserMemUsed;
            jsonObject = json_value_get_object( jsonRoot );
            json_object_set_number(jsonObject, cstrDevHealthTotalMemoryUsed, nTotalMemUsed);
            json_object_set_number(jsonObject, cstrDevHealthUserMemoryUsed, nUserMemUsed);
        }

        if( jsonObject != NULL )
        {   // if there is any telemetry to be sent...
            AzureIoT_SendJsonMessage(jsonRoot);
			// Set the send/receive LED2 to blink once immediately to indicate 
			// the message has been queued.
			BlinkLed2Once( RgbLedUtility_Colors_Green );
        }
        
        json_value_free(jsonRoot);

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
	if (json_object_has_value_of_type(desiredProperties, cstrLedBlinkRateProperty, JSONNumber))
	{
        unsigned int desiredVersion = (unsigned int)json_object_get_number(desiredProperties, cstrSysVersionProperty);

        // REMARK IoTC since August 2020 now sends twin as { "blinkRateProperty" : ## , "$version" : ## }  
		size_t desiredBlinkRate = (size_t)json_object_get_number(desiredProperties, cstrLedBlinkRateProperty);

		blinkIntervalIndex = desiredBlinkRate % nBlinkingIntervalsCount; // Clamp value to [0..nBlinkingIntervalsCount) .
        blinkIntervalVersion = desiredVersion;

		Log_Debug("[DeviceTwinUpdate] Received desired value %zu for blinkRateProperty, setting it to %zu.\n",
			desiredBlinkRate, blinkIntervalIndex);

		tsBlinkingLedInterval = atsBlinkingIntervals[blinkIntervalIndex];
		SetLedRate(&atsBlinkingIntervals[blinkIntervalIndex]);

        // REMARK: IoT Central desired property response since August 2020 needs to be message as 
        //"{ "blinkRateProperty" : { "value" : ##, "desiredVersion" : ##, "status" : "completed" } }" 
        JSON_Value* jsonRoot = json_value_init_object();
        
        JSON_Value* jsonPropertyValue = json_value_init_object();
        JSON_Object* jsonPropertyValueObject = json_value_get_object(jsonPropertyValue);
        json_object_set_number(jsonPropertyValueObject, cstrValueProperty, (double)blinkIntervalIndex);
        json_object_set_number(jsonPropertyValueObject, cstrVersionProperty, (double)blinkIntervalVersion);
        json_object_set_number(jsonPropertyValueObject, cstrStatusProperty, 200);
        json_object_set_string(jsonPropertyValueObject, cstrStatusDescriptionProperty, cstrCompleted);

        json_object_set_value(json_object(jsonRoot), cstrLedBlinkRateProperty, jsonPropertyValue);

        // Report accepted device twin change back to IoT Central as message
        AzureIoT_SendJsonMessage(jsonRoot);

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
                colBlinkingLedColor = ledColor;
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

            tsResetDelay.tv_sec = (time_t)tResetInterval;
            // arm count down timer
            SetTimerFdToSingleExpiry(fdResetTimer, &tsResetDelay);
            Log_Debug("[ResetMethod]: set timer to %d seconds.\n", tsResetDelay.tv_sec);

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

static void ReportAllProperties(void)
{
    JSON_Value* jsonRoot = json_value_init_object();
    JSON_Object *jsonObj = json_value_get_object(jsonRoot);

    json_object_set_string(jsonObj, cstrDevInfoManufacturerProperty, cstrDevInfoManufacturerValue);
    json_object_set_string(jsonObj, cstrDevInfoModelProperty, cstrDevInfoModelValue);
    json_object_set_string(jsonObj, cstrDevInfoSWVersionProperty, cstrDevInfoSWVersionValue);
    json_object_set_string(jsonObj, cstrDevInfoOSNameProperty, cstrDevInfoOSNameValue);
    json_object_set_string(jsonObj, cstrDevInfoProcArchProperty, cstrDevInfoProcArchValue);
    json_object_set_string(jsonObj, cstrDevInfoProcMfgrProperty, cstrDevInfoProcMfgrValue);
    json_object_set_number(jsonObj, cstrDevInfoStorageProperty, (double) ciDevInfoStorageValue);
    json_object_set_number(jsonObj, cstrDevInfoMemoryProperty, (double) ciDevInfoMemoryValue);

    json_object_set_number(jsonObj, cstrLedBlinkRateProperty, (double) blinkIntervalIndex);

    AzureIoT_TwinReportStateJson(jsonRoot);

    json_value_free(jsonRoot);
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
        // send a "connect" event telemetry message with the previous disconnect reason
		SendEventMessage(cstrEvtConnected, pstrConnectionStatus);
        pstrConnectionStatus = cstrEvtConnected;

        // report initial Azure IoT PnP-compatible DeviceInformation & BlinkRate
        ReportAllProperties();

        // and at last start the telemetry timer
        SetTimerFdToPeriod(fdTelemetryTimer, &tsTelemetryInterval);
    }
    else {
        Log_Debug("[IoTHubConnectionStatusChanged]: Disconnected.\n");
        // switch off telemetry timer as we are disconnected
        SetTimerFdToPeriod(fdTelemetryTimer, &tsNullInterval);
        // save reason for disconnect event
        pstrConnectionStatus = statusText;
    }
}

/// <summary>
///     Handle the blinking for LED1.
/// </summary>
void Led1UpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdLed1BlinkTimer) != 0) {
        terminationRequired = true;
        return;
    }

    // Trigger LED1 to blink as appropriate.
    bBlinkingLedState = !bBlinkingLedState;
    RgbLedUtility_Colors color = (bBlinkingLedState ? colBlinkingLedColor : RgbLedUtility_Colors_Off);
    RgbLedUtility_SetLed(&rgbLed1, color);
}

/// <summary>
///     Handle the blinking for LED2.
/// </summary>
void Led2UpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdLed2FlashTimer) != 0) {
        terminationRequired = true;
        return;
    }

    // Clear the send/receive LED2.
    RgbLedUtility_SetLed(&rgbLed2, RgbLedUtility_Colors_Off);
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
/// Show network/IoT connectivety status:
///   red   : no network
///   green : conected to WiFi
///   blue : connected to IoT Hub
/// </summary>
void NetworkLedUpdateHandler(void)
{
    // Set network status with LED3 color.
    RgbLedUtility_Colors color = RgbLedUtility_Colors_Red;
    Networking_IsNetworkingReady(&bNetworkReady);
    if (bNetworkReady)
    {
        color = (connectedToIoTHub ? RgbLedUtility_Colors_Blue : RgbLedUtility_Colors_Green);
    }
    RgbLedUtility_SetLed(&rgbNetworkLed, color);
}


/// <summary>
///     Handle button timer event: if the button is pressed, change the LED blink rate.
/// </summary>
void ButtonPollTimerHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdButtonPollTimer) != 0) {
        terminationRequired = true;
        return;
    }

    NetworkLedUpdateHandler();

    // If the button A is pressed, change the LED blink interval, update the Device Twin and send a buttonA event message.
    static GPIO_Value_Type blinkButtonState;
    if (IsButtonPressed(fdBlinkRateButtonGpio, &blinkButtonState)) {
		blinkIntervalIndex = (blinkIntervalIndex + 1) % nBlinkingIntervalsCount;
        SetLedRate(&atsBlinkingIntervals[blinkIntervalIndex]);

        if (connectedToIoTHub) {
            SendEventMessage(cstrEvtButtonA, cstrMsgPressed);
        }
        else {
            Log_Debug("WARNING: Cannot send buttonA event: not connected to the IoT Hub.\n");
        }
    }

    // If the button B is pressed, send a buttonB event message to the IoT Hub.
    static GPIO_Value_Type messageButtonState;
    if (IsButtonPressed(fdSendMessageButtonGpio, &messageButtonState)) {
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
    if (ConsumeTimerFdEvent(fdAzureIoTWorkerTimer) != 0) {
        terminationRequired = true;
        return;
    }

    // if no network available check again after default Polling time
    if (!bNetworkReady)
    {
        azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;
        struct timespec azureTelemetryPeriod = { azureIoTPollPeriodSeconds, 0 };
        SetTimerFdToPeriod(fdAzureIoTWorkerTimer, &azureTelemetryPeriod);
        return;
    }

    // Set up the connection to the IoT Hub client.
    // Notes it is safe to call this function even if the client has already been set up, as in
    //   this case it would have no effect
    if (AzureIoT_SetupClient()) {
        if (azureIoTPollPeriodSeconds != AzureIoTDefaultPollPeriodSeconds) {
            azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;

            struct timespec azureTelemetryPeriod = {azureIoTPollPeriodSeconds, 0};
            SetTimerFdToPeriod(fdAzureIoTWorkerTimer, &azureTelemetryPeriod);
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
        SetTimerFdToPeriod(fdAzureIoTWorkerTimer, &azureTelemetryPeriod);

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
    if (!OpenGpioFdAsInput(MT3620_RDB_BUTTON_A, &fdBlinkRateButtonGpio)) {
        return -1;
    }

    // Open button B
    Log_Debug("INFO: Opening MT3620_RDB_BUTTON_B.\n");
    if (!OpenGpioFdAsInput(MT3620_RDB_BUTTON_B, &fdSendMessageButtonGpio)) {
        return -1;
    }

    Log_Debug("INFO: Opening MT3620_ISU3_I2C.\n");
    if ((fdSensorI2c = I2CMaster_Open(MT3620_ISU3_I2C)) < 0)
    {
        return -1;
    }

    // Open file descriptors for the RGB LEDs and store them in the rgbLeds array (and in turn in
    // the ledBlink, ledMessageEventSentReceived, ledNetworkStatus variables)
    RgbLedUtility_OpenLeds(rgbLeds, nLedCount, gpioLedPins);

#ifdef BME280
    // Initialize I2C sensor(s)
    Log_Debug("INFO: Initializing BME280 I2C sensor on primary address.\n");
    bool bInitSuccessful = BME280_Init(fdSensorI2c, true);
    if (!bInitSuccessful) {
        return -1;
    }
#endif

#ifdef BMP280
    // Initialize I2C sensor(s)
    Log_Debug("INFO: Initializing BMP280 I2C sensor on primary address.\n");
    bool bInitSuccessful = BMP280_Init(fdSensorI2c, true);
    if (!bInitSuccessful) {
        return -1;
    }
#endif

    // Initialize the Azure IoT SDK
    if (!AzureIoT_Initialize()) {
        Log_Debug("ERROR: Cannot initialize Azure IoT Hub SDK.\n");
        return -1;
    }

    // Set the Azure IoT hub related callbacks
    AzureIoT_SetMessageReceivedCallback( &MessageReceived );
    AzureIoT_SetDeviceTwinUpdateCallback( &DeviceTwinUpdate );
    AzureIoT_RegisterDirectMethodHandlers( &clstDirectMethods[0] );
    AzureIoT_SetConnectionStatusCallback( &IoTHubConnectionStatusChanged );

    // Display the currently connected WiFi connection.
    DebugPrintCurrentlyConnectedWiFiNetwork();

    fdEpoll = CreateEpollFd();
    if (fdEpoll < 0) {
        return -1;
    }

    // Set up a timer for LED1 blinking
    fdLed1BlinkTimer =
        CreateTimerFdAndAddToEpoll(fdEpoll, &tsBlinkingLedInterval, &evtdataLed1Update, EPOLLIN);
    if (fdLed1BlinkTimer < 0) {
        return -1;
    }

    // Set up a a dis-armed timer for blinking LED2 once.
    fdLed2FlashTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullInterval, &evtdataLed2Update, EPOLLIN);
    if (fdLed2FlashTimer < 0) {
        return -1;
    }

    // Set up a timer for buttons status check
    static struct timespec buttonsPressCheckPeriod = {0, 1000000};
    fdButtonPollTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &buttonsPressCheckPeriod,
                                                   &evtdataButtonPollTimer, EPOLLIN);
    if (fdButtonPollTimer < 0) {
        return -1;
    }


	// Set up a timer for telemetry intervals
	fdTelemetryTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullInterval,
		&evtdataTelemetryTimer, EPOLLIN);
	if (fdTelemetryTimer < 0) {
		return -1;
	}

    // Set up a dis-armed timer for the reset interval
    fdResetTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullInterval,
        &evtdataResetTimer, EPOLLIN);
    if (fdResetTimer < 0) {
        return -1;
    }

    // Set up a timer for Azure IoT SDK DoWork execution.
    azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;
    struct timespec tsAzureIoTWorkerInterval = {azureIoTPollPeriodSeconds, 0};
    fdAzureIoTWorkerTimer =
        CreateTimerFdAndAddToEpoll(fdEpoll, &tsAzureIoTWorkerInterval, &evtdataAzureIoTWorker, EPOLLIN);
    if (fdAzureIoTWorkerTimer < 0) {
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
    CloseFdAndPrintError(fdResetTimer, "ResetTimer");
    CloseFdAndPrintError(fdTelemetryTimer, "TelemetryTimer");
    CloseFdAndPrintError(fdButtonPollTimer, "ButtonPollTimer");
    CloseFdAndPrintError(fdLed2FlashTimer, "Led2BlinkTimer");
    CloseFdAndPrintError(fdLed1BlinkTimer, "Led1BlinkTimer");
    CloseFdAndPrintError(fdAzureIoTWorkerTimer, "IoTWorkerTimer");
    CloseFdAndPrintError(fdEpoll, "Epoll");

    // Close IO file descriptors
    CloseFdAndPrintError(fdBlinkRateButtonGpio, "LedBlinkRateButtonGpio");
    CloseFdAndPrintError(fdSendMessageButtonGpio, "SendMessageButtonGpio");
    CloseFdAndPrintError(fdSensorI2c, "I2C ISU3");

    // Close the LEDs and leave then off
    RgbLedUtility_CloseLeds(rgbLeds, nLedCount);

    // Destroy the IoT Hub client
    AzureIoT_DestroyClient();
    AzureIoT_Deinitialize();
}

/// <summary>
///     Main entry point for this application.
/// </summary>
int main(int argc, char *argv[])
{
    Log_Debug("INFO: SphereBME280 application starting.\n");

    // app_manifest.json:"CmdArgs" 1st parameter should be DPS Scope ID
    if (argc > 1)
	{
		AzureIoT_SetDPSScopeID(argv[1]);
	}

    int initResult = InitPeripheralsAndHandlers();
    if (initResult != 0) {
        terminationRequired = true;
    }

    while (!terminationRequired) {
        if (WaitForEventAndCallHandler(fdEpoll) != 0) {
            terminationRequired = true;
        }
    }

    ClosePeripheralsAndHandlers();
    Log_Debug("INFO: Application exiting.\n");
    return 0;
}
