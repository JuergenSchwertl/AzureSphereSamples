/**
 * @file main.c
 * @author Juergen Schwertl (jschwert@microsoft.com)
 * @brief This sample C application for a MT3620 Reference Development Board (Azure Sphere) demonstrates how to
 * connect an Azure Sphere device to Azure IoT Central. To use this sample, you must first
 * run the ShowIoTCentralConfig.exe from <see href="https://github.com/Azure/azure-sphere-samples/tree/master/Samples/AzureIoT/Tools" />
 * which outputs the required "CmdArgs" with the DPS scope id and "AllowedConnections" properties 
 * for the Manifest (app_manifest.json) .
 * You will also need to update the "DeviceAuthentication" property in the manifest 
 * with your Azure Sphere TenantID. To find your TenantId, i.e. run the Azure Sphere Command line
 *		azsphere tenant show-selected
 *
 * The sample leverages these functionalities of the Azure IoT SDK C together with Azure IoT Central:
 * - Device to cloud messages;
 * - Cloud to device messages;
 * - Direct Method invocation;
 * - Device Twin management;
 *
 * A description of the sample follows:
 * - LED 1 blinks constantly.
 * - Pressing button A toggles the rate at which LED 1 blinks between three values.
 * - Pressing button B triggers reading sensor data and sending a message to the IoT Hub.
 * - LED 2 flashes red when a message is sent and flashes yellow when a message is received.
 * - NETWORK LED indicates whether network connection to the Azure IoT Hub has been
 *   established (Red:No Network, Green:WiFi, Blue:IoT Hub connected).
 *
 * Direct Method related notes:
 * - Invoking the method named "RgbLed*setColorMethod" with a payload containing '{"color":"red"}'
 *   will set the color of blinking LED 1 to red.
 * - Invoking the method named "DeviceHealth*resetMethod" with a payload containing '{"resetTimer":5}'
 *   will arm a reset-timer to reboot the device after # seconds.
 *
 * Device Twin related notes:
 * - Setting blinkRateProperty in the Device Twin to a value from 0 to 2 causes the sample to
 *   update the blink rate of LED 1 accordingly, e.g '{"blinkRateProperty": 2 }';
 * - Upon receipt of the blinkRateProperty desired value from the IoT hub, the sample updates
 *   the device twin on the IoT hub with the new value for blinkRateProperty.
 * - Pressing button A causes the sample to report the blink rate to the device
 *   twin on the IoT Hub.
 *
 * This sample uses the API for the following Azure Sphere application libraries:
 * - i2c (serial port for BME280 sensor);
 * - gpio (digital input for button);
 * - log (messages shown in Visual Studio's Device Output window during debugging);
 * - wificonfig (configure WiFi settings);
 * - azureiot (interaction with Azure IoT services)
 * @version 21.10
 * @date 2021-12-27
 * 
 * @copyright Copyright (c) 2021
 * 
 */

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
#include "azure_iot.h"
#include "azure_iot_dps.h"
#include "azure_iot_json.h"
#include "azure_iot_pnp.h"
#include "azure_iot_central.h"




// An array defining the RGB GPIOs for each LED on the device
static const GPIO_Id gpioLedPins[3][3] = {
    {MT3620_RDB_LED1_RED, MT3620_RDB_LED1_GREEN, MT3620_RDB_LED1_BLUE}, 
	{MT3620_RDB_LED2_RED, MT3620_RDB_LED2_GREEN, MT3620_RDB_LED2_BLUE}, 
	{MT3620_RDB_NETWORKING_LED_RED, MT3620_RDB_NETWORKING_LED_GREEN, MT3620_RDB_NETWORKING_LED_BLUE}
};

static RgbLedUtility_Colors colBlinkingLedColor = RgbLedUtility_Colors_Blue;

static const struct timespec atsBlinkingIntervals[] = {{0, 125000000}, {0, 250000000}, {0, 500000000}};
static const size_t nBlinkingIntervalsCount = sizeof(atsBlinkingIntervals) / sizeof(*atsBlinkingIntervals);

/// @brief File descriptors - initialized to invalid value
static int fdEpoll = -1;
static int fdBlinkRateButtonGpio = -1;
static int fdSendMessageButtonGpio = -1;
static int fdButtonPollTimer = -1;
static int fdLed1BlinkTimer = -1;
static int fdLed2FlashTimer = -1;
static int fdTelemetryTimer = -1;
static int fdResetTimer = -1;
static int fdSensorI2c = -1;

#ifdef DEBUG
/// @brief tsTelemetryInterval is set to send teleletry every 20 seconds
static const struct timespec tsTelemetryInterval = {20, 0};
#else
/// @brief tsTelemetryInterval is set to send teleletry every 60 seconds
static const struct timespec tsTelemetryInterval = {60, 0};
#endif

/// @brief default tsResetDelay is set to reboot after 5 second (overridden by resetTimer property)
static struct timespec tsResetDelay = { 5, 0 };


static const char cstrErrorOutOfMemory[] = "ERROR: Out of memory.\n";

// telemetry event messages
static const char cstrMsgPressed[] = "pressed";
static const char cstrMsgApplicationStarted[] = "Application started";

/// @brief The Azure IoT PnP Model Id and component property
#ifdef BME280
static const char cstrPnPModelId[] = "dtmi:azsphere:SphereTTT:SphereBME280;1"; 
#endif

#ifdef BMP280
static const char cstrPnPModelId[] = "dtmi:azsphere:SphereTTT:SphereBMP280;1"; 
#endif


/// @brief Azure IoT PnP component "dtmi:azsphere:SphereTTT:buttons;1"  
static const char cstrButtonsComponent[] = "buttons";
static const char cstrEvtButtonB[] = "buttonB";
static const char cstrEvtButtonA[] = "buttonA";

/// @brief Azure IoT PnP component "dtmi:azsphere:SphereTTT:rgbLed;1"  
static const char cstrRgbledComponent[] = "rgbLed";

static const char cstrSetColorMethodName[] = "rgbLed*setColorMethod";
static const char cstrColorResponseMsg[] = "LED color set to %s";
static const char cstrColorProperty[] = "color";
static const char cstrBlinkRateProperty[] = "blinkRateProperty";
static const char cstrBlinkRatePropertyPath[] = "rgbLed.blinkRateProperty";

static const char cstrSysVersionProperty[] = "$version";
//static const char cstrStatusComplete[] = "complete";

#ifdef BME280
/// @brief Azure IoT PnP component "dtmi:azsphere:SphereTTT:bme280;1"  
static const char cstrBME280Component[] = "bme280";

static const char cstrSuccessProperty[] = "success";
static const char cstrMessageProperty[] = "message";
static const char cstrTemperatureProperty[] = "temperature";
static const char cstrPressureProperty[] = "pressure";
    static const char cstrHumidityProperty[] = "humidity";
#endif

#ifdef BMP280
/// @brief Azure IoT PnP component "dtmi:azsphere:SphereTTT:bmp280;1"  
static const char cstrBMP280Component[] = "bmp280";

static const char cstrSuccessProperty[] = "success";
static const char cstrMessageProperty[] = "message";
static const char cstrTemperatureProperty[] = "temperature";
static const char cstrPressureProperty[] = "pressure";
#endif

/// @brief Azure IoT PnP component "dtmi:azure:DeviceManagement:DeviceInformation;1"  
static const char   cstrDevInfoComponent[]              = "deviceInformation";

static const char   cstrDevInfoManufacturerProperty[]   = "manufacturer";
static const char   cstrDevInfoModelProperty[]          = "model";
static const char   cstrDevInfoSWVersionProperty[]      = "swVersion";
static const char   cstrDevInfoOSNameProperty[]         = "osName";
static const char   cstrDevInfoProcArchProperty[]       = "processorArchitecture";
static const char   cstrDevInfoProcMfgrProperty[]       = "processorManufacturer";
static const char   cstrDevInfoStorageProperty[]        = "totalStorage";
static const char   cstrDevInfoMemoryProperty[]         = "totalMemory";

static const char   cstrDevInfoManufacturerValue[]      = "Seeed";
static const char   cstrDevInfoModelValue[]             = "MT3620 Developer Kit";
static const char   cstrDevInfoSWVersionValue[]         = "SphereBME280-" __DATE__;
static const char   cstrDevInfoOSNameValue[]            = "Sphere OS-";
static const char   cstrDevInfoProcArchValue[]          = "ARM Core A7,M4";
static const char   cstrDevInfoProcMfgrValue[]          = "MediaTek";
static const double cdDevInfoStorageValue               = 16000000.0;
static const double cdDevInfoMemoryValue                = 4000000.0;

/// @brief Azure IoT PnP component "dtmi:azsphere:SphereTTT:DeviceHealth;1"
static const char   cstrDevHealthComponent[]            = "deviceHealth";
static const char   cstrEvtConnected[]                  = "connect";
static const char   cstrDevHealthTotalMemoryUsed[]      = "totalMemoryUsed";
static const char   cstrDevHealthUserMemoryUsed[]       = "userMemoryUsed";
static const char   cstrResetTimerProperty[]            = "resetTimer";
static const char   cstrResetMethodName[]               = "deviceHealth*resetMethod";
static const char   cstrResetResponseMsg[]              = "Reset in %d seconds";

static size_t nLastTotalMemoryUsed = 0;
static size_t nLastUserMemoryUsed = 0;

// method response messages
static const char cstrBadDataResponseMsg[] = "Request does not contain identifiable data.";


// forward declarations for method handlers
static HTTP_STATUS_CODE SetColorMethod(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress);
static HTTP_STATUS_CODE ResetMethod(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress);

// list of method registrations
static const MethodRegistration clstDirectMethods[] = {
    {.MethodName = cstrSetColorMethodName, .MethodHandler = &SetColorMethod},
    {.MethodName = cstrResetMethodName, .MethodHandler = &ResetMethod},
    {.MethodName = NULL, .MethodHandler = NULL}
};


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
static void ButtonPollTimerHandler(EventData* eventData);
static void Led1UpdateHandler(EventData* eventData);
static void Led2UpdateHandler(EventData* eventData);
static void TelemetryTimerHandler(EventData* eventData);
static void ResetTimerHandler(EventData* eventData);

// event handler data structures. Only the event handler field needs to be populated.
static EventData evtdataButtonPollTimer = { .eventHandler = &ButtonPollTimerHandler };
static EventData evtdataLed1Update = { .eventHandler = &Led1UpdateHandler };
static EventData evtdataLed2Update = { .eventHandler = &Led2UpdateHandler };
static EventData evtdataTelemetryTimer = { .eventHandler = &TelemetryTimerHandler };
static EventData evtdataResetTimer = { .eventHandler = &ResetTimerHandler };


// forward declarations for close handlers
void ClosePeripheralsAndHandlers(void);

///  @brief 
/// network connectivety status. Frequently updated in ButtonPollTimerHandler
/// 
static bool bIsNetworkReady = false;
///  @brief 
/// IoT hub client status
/// 
static bool connectedToIoTHub = false;
///  @brief 
/// Reason for last disconnect
/// 
static const char* pstrConnectionStatus = cstrMsgApplicationStarted;

///  @brief 
/// desired property blinkRateProperty 
/// 
static size_t nBlinkRateValue = 0;
static size_t nBlinkrateVersion = 0;

///  @brief 
/// Termination state
/// 
static volatile sig_atomic_t terminationRequired = false;


///  @brief 
///     Signal handler for termination requests. This handler must be async-signal-safe.
/// 
static void TerminationHandler(int signalNumber)
{
    // Don't use Log_Debug here, as it is not guaranteed to be async-signal-safe.
    terminationRequired = true;
}


///  @brief 
///     Allocates and formats a string message on the heap.
/// 
/// @param messageFormatThe format of the message
/// @param maxLengthThe maximum length of the formatted message string
/// @returns The pointer to the heap allocated memory.

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



///  @brief 
///     Show details of the currently connected WiFi network.
/// 
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

///  @brief 
///     Helper function to blink LED2 once.
/// 
static void BlinkLed2Once( RgbLedUtility_Colors color )
{
    RgbLedUtility_SetLed(&rgbLed2,color);
    SetTimerFdToSingleExpiry(fdLed2FlashTimer, ((color == RgbLedUtility_Colors_Red) ? &tsLed2BlinkTime : &tsLed2BlinkTime));
}

///  @brief 
///     Helper function to open a file descriptor for the given GPIO as input mode.
/// 
/// @param  gpioId      The GPIO to open.
/// @param  outGpioFd   File descriptor of the opened GPIO.
/// @returns    
///     True    if successful
///     false   if an error occurred.
static bool OpenGpioFdAsInput(GPIO_Id gpioId, int *outGpioFd)
{
    *outGpioFd = GPIO_OpenAsInput(gpioId);
    if (*outGpioFd < 0) {
        Log_Debug("ERROR: Could not open GPIO '%d': %d (%s).\n", gpioId, errno, strerror(errno));
        return false;
    }

    return true;
}




/// @brief Toggles the blink speed of the blink LED between 3 values.
/// @param nValue       new Blink rate (index into timespec table)
/// @returns actual blink rate set (in bounds)
static size_t SetLedRate(size_t nValue)
{
    nBlinkRateValue = (nValue >= nBlinkingIntervalsCount) ? 0 : nValue; //clamp to array size 
    const struct timespec * pBlinkRate = &atsBlinkingIntervals[nBlinkRateValue];

    if (SetTimerFdToPeriod(fdLed1BlinkTimer, pBlinkRate) != 0) {
        Log_Debug("ERROR: could not set the period of the LED.\n");
        terminationRequired = true;
        return 0;
    }

    return nBlinkRateValue;
}


///  @brief Sends an event to Azure IoT Central
/// 
/// @param cstrEventevent name
/// @param pstrMessageevent message
static void SendEventMessage(const char * cstrComponent, const char * cstrEvent, const char * cstrMessage)
{
	if (connectedToIoTHub) {
		Log_Debug("[Send] Component '%s' event '%s' is '%s'\n", cstrComponent, cstrEvent, cstrMessage);

        JSON_Value  *jsonRootValue = json_value_init_object();
        JSON_Object *jsonRootObject = json_value_get_object( jsonRootValue );

        json_object_set_string(jsonRootObject, cstrEvent, cstrMessage);

		// Send a message
		AzureIoT_PnP_SendJsonMessage(jsonRootValue, cstrComponent);

        json_value_free(jsonRootValue);

		// Set the send/receive LED2 to blink once immediately to indicate 
		// the message has been queued.
		BlinkLed2Once(RgbLedUtility_Colors_Green);
	}
	else {
		Log_Debug("[Send] not connected to IoT Central: no event sent.\n");
		BlinkLed2Once(RgbLedUtility_Colors_Red);
	}
}

/// @brief Sends a telemetry message to Azure IoT Central.
/// 
static void SendTelemetryMessage(void)
{
    if (connectedToIoTHub) {
        // initialize root object
        JSON_Value * jsonRootValue = json_value_init_object();
        JSON_Object * jsonRootObject = json_value_get_object( jsonRootValue );

#ifdef BME280		
		bme280_data_t bmeData;
		if (BME280_GetSensorData(&bmeData) == 0)
		{
			Log_Debug("[Send] Component '%s': Temperature: %.2f, Pressure: %.2f, Humidity: %.2f\n", cstrBME280Component, bmeData.temperature, bmeData.pressure, bmeData.humidity);

            json_object_set_number(jsonRootObject, cstrTemperatureProperty, bmeData.temperature);
            json_object_set_number(jsonRootObject, cstrPressureProperty, bmeData.pressure);
            json_object_set_number(jsonRootObject, cstrHumidityProperty, bmeData.humidity);
            
            AzureIoT_PnP_SendJsonMessage(jsonRootValue, cstrBME280Component);
		}
#endif

#ifdef BMP280		
		bmp280_data_t bmpData;

		if (BMP280_GetSensorData(&bmpData) == 0)
		{
			Log_Debug("[Send] Component '%s' Temperature: %.2f, Pressure: %.2f\n", cstrBMP280Component, bmpData.temperature, bmpData.pressure);

            json_object_set_number(jsonRootObject, cstrTemperatureProperty, bmpData.temperature);
            json_object_set_number(jsonRootObject, cstrPressureProperty, bmpData.pressure);
            
            AzureIoT_PnP_SendJsonMessage(jsonRootValue, cstrBMP280Component);
        }
#endif
        json_value_free( jsonRootValue );


        size_t nTotalMemUsed = Applications_GetTotalMemoryUsageInKB();
        size_t nUserMemUsed = Applications_GetUserModeMemoryUsageInKB();
        if( (nLastTotalMemoryUsed != nTotalMemUsed) || (nLastUserMemoryUsed != nUserMemUsed) ){
			Log_Debug("[Send] Component:'%s' TotalMemoryUsed: %d, UserMemoryUsed: %d\n", cstrDevHealthComponent, nTotalMemUsed, nUserMemUsed);
            
            nLastTotalMemoryUsed = nTotalMemUsed;
            nLastUserMemoryUsed = nUserMemUsed;

            jsonRootValue = json_value_init_object();
            jsonRootObject = json_value_get_object( jsonRootValue );

            json_object_set_number(jsonRootObject, cstrDevHealthTotalMemoryUsed, (double)( nTotalMemUsed * 1024 ));
            json_object_set_number(jsonRootObject, cstrDevHealthUserMemoryUsed, (double) (nUserMemUsed * 1024));
    
            AzureIoT_PnP_SendJsonMessage(jsonRootValue, cstrDevHealthComponent);
            json_value_free(jsonRootValue);
        }

	    BlinkLed2Once( RgbLedUtility_Colors_Green );

    } else {
		Log_Debug("[Send] not connected to IoT Central: no telemtry sent.\n");
		BlinkLed2Once(RgbLedUtility_Colors_Red);
	}
}

/// @brief MessageReceived callback function, called when a message is received from the Azure IoT Hub.
/// @param payloadThe payload of the received message.
static void MessageReceived(const char *payload)
{
    // Set the send/receive LED2 to blink once immediately to indicate a message has been received.
	BlinkLed2Once(RgbLedUtility_Colors_Blue);
}

///  @brief 
///     Device Twin update callback function, called when an update is received from the Azure IoT
///     Hub.
/// 
/// @param desiredPropertiesThe JSON root object containing the desired Device Twin
/// properties received from the Azure IoT Hub.
static void DeviceTwinUpdate(const JSON_Object *desiredProperties)
{
	if (json_object_dothas_value_of_type(desiredProperties, cstrBlinkRatePropertyPath, JSONNumber))
	{
		double fDesiredBlinkRate = json_object_dotget_number(desiredProperties, cstrBlinkRatePropertyPath);
        nBlinkrateVersion = (unsigned int)json_object_get_number(desiredProperties, cstrSysVersionProperty);

		Log_Debug("[DeviceTwinUpdate] Received desired value %f for blinkRateProperty.\n", fDesiredBlinkRate);

		double fActualBlinkRate = (double) SetLedRate( (size_t) fDesiredBlinkRate );
        
        unsigned int nStatus = (fActualBlinkRate == fDesiredBlinkRate) ? HTTP_OK : HTTP_BAD_REQUEST;

        // Acknowlede receipt of property back to Azure IoT Central 
        AzureIoTCentral_AckComponentPropertyChange( cstrRgbledComponent, cstrBlinkRateProperty, &fActualBlinkRate, JSONNumber, nBlinkrateVersion, nStatus);

		BlinkLed2Once(RgbLedUtility_Colors_Blue);
	} else {
		Log_Debug( "[DeviceTwinUpdate] received update with incorrect data:\n");
		BlinkLed2Once(RgbLedUtility_Colors_Red);
	}
}


/// @brief 
/// setColor-Method takes payload in form of { "color": "red" } to set LED blink color
///
/// @param jsonParametersjson message payload
/// @param jsonResponseAddressaddress of response message payload
/// @returns HTTP status return value.
static HTTP_STATUS_CODE SetColorMethod(JSON_Value * jsonParameters, JSON_Value** jsonResponseAddress)
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

/// @brief 
/// reset-Method arms the reset counter 
///
/// @param jsonParametersjson message payload
/// @param jsonResponseAddressaddress of response message payload
/// @returns HTTP status return value.
static HTTP_STATUS_CODE ResetMethod(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress)
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
    JSON_Value* jsonRoot = NULL;
    JSON_Value* jsonValue = NULL;
    JSON_Object *jsonObject = NULL;
    Applications_OsVersion osversion;
    char strDevInfoOsVersion[32];

    jsonRoot = json_value_init_object();

    jsonValue = json_value_init_object();
    jsonObject = json_value_get_object( jsonValue );

    // get the currently running OS version
    Applications_GetOsVersion( &osversion );
    strncpy( strDevInfoOsVersion, cstrDevInfoOSNameValue, sizeof(strDevInfoOsVersion) );
    strncat( strDevInfoOsVersion, (const char *) osversion.version,  sizeof(strDevInfoOsVersion));

    json_object_set_string(jsonObject, cstrDevInfoManufacturerProperty, cstrDevInfoManufacturerValue);
    json_object_set_string(jsonObject, cstrDevInfoModelProperty, cstrDevInfoModelValue);
    json_object_set_string(jsonObject, cstrDevInfoSWVersionProperty, cstrDevInfoSWVersionValue);
    json_object_set_string(jsonObject, cstrDevInfoOSNameProperty, strDevInfoOsVersion );
    json_object_set_string(jsonObject, cstrDevInfoProcArchProperty, cstrDevInfoProcArchValue);
    json_object_set_string(jsonObject, cstrDevInfoProcMfgrProperty, cstrDevInfoProcMfgrValue);
    json_object_set_number(jsonObject, cstrDevInfoStorageProperty, cdDevInfoStorageValue);
    json_object_set_number(jsonObject, cstrDevInfoMemoryProperty, cdDevInfoMemoryValue);

    AzureIoT_PnP_CreateComponentPropertyJson( jsonRoot, cstrDevInfoComponent, jsonValue);

    jsonValue = json_value_init_object();
    jsonObject = json_value_get_object( jsonValue );
    json_object_set_number(jsonObject, cstrBlinkRateProperty, (double) nBlinkRateValue);

    AzureIoT_PnP_CreateComponentPropertyJson( jsonRoot, cstrRgbledComponent, jsonValue);

    AzureIoTJson_TwinReportState(jsonRoot);

    json_value_free(jsonRoot);
}

///  @brief 
///     IoT Hub connection status callback function.
/// 
/// @param connected'true' when the connection to the IoT Hub is established.
/// @param statusTextconnect/disconnect reason
static void IoTHubConnectionStatusChanged(bool connected, const char *statusText)
{
    connectedToIoTHub = connected;
	if (connectedToIoTHub)
	{
        Log_Debug("[IoTHubConnectionStatusChanged]: Connected.\n");
        // send a "connect" event telemetry message with the previous disconnect reason
		SendEventMessage(cstrDevHealthComponent, cstrEvtConnected, pstrConnectionStatus);
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

///  @brief 
///     Handle the blinking for LED1.
/// 
static void Led1UpdateHandler(EventData *eventData)
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

///  @brief 
///     Handle the blinking for LED2.
/// 
static void Led2UpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdLed2FlashTimer) != 0) {
        terminationRequired = true;
        return;
    }

    // Clear the send/receive LED2.
    RgbLedUtility_SetLed(&rgbLed2, RgbLedUtility_Colors_Off);
}

///  @brief 
///     Check whether a given button has just been pressed.
/// 
/// @param fdThe button file descriptor
/// @param oldStateOld state of the button (pressed or released)
/// @returns true if pressed, false otherwise
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


///  @brief 
/// Show network/IoT connectivety status:
///   red   : no network
///   green : conected to WiFi
///   blue : connected to IoT Hub
/// 
void NetworkLedUpdateHandler(void)
{
    // Set network status with LED3 color.
    RgbLedUtility_Colors color = RgbLedUtility_Colors_Red;
    Networking_IsNetworkingReady(&bIsNetworkReady);
    if (bIsNetworkReady)
    {
        color = (connectedToIoTHub ? RgbLedUtility_Colors_Blue : RgbLedUtility_Colors_Green);
    }
    RgbLedUtility_SetLed(&rgbNetworkLed, color);
}


///  @brief 
///     Handle button timer event: if the button is pressed, change the LED blink rate.
/// 
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
        SetLedRate( nBlinkRateValue + 1 );

        if (connectedToIoTHub) {
            JSON_Value * jsonValue = json_value_init_object();
            JSON_Object * jsonObject = json_value_get_object( jsonValue );
            json_object_set_number(jsonObject, cstrBlinkRateProperty, (double) nBlinkRateValue);

            AzureIoT_PnP_ReportComponentProperty( cstrRgbledComponent, jsonValue);

            SendEventMessage(cstrButtonsComponent, cstrEvtButtonA, cstrMsgPressed);
        }
        else {
            Log_Debug("WARNING: Cannot send buttonA event: not connected to the IoT Hub.\n");
        }
    }

    // If the button B is pressed, send a buttonB event message to the IoT Hub.
    static GPIO_Value_Type messageButtonState;
    if (IsButtonPressed(fdSendMessageButtonGpio, &messageButtonState)) {
        if (connectedToIoTHub) {
		    SendEventMessage(cstrButtonsComponent, cstrEvtButtonB, cstrMsgPressed);
		    SendTelemetryMessage();
        }
        else {
            Log_Debug("WARNING: Cannot send buttonB event: not connected to the IoT Hub.\n");
        }
    }
}


///  @brief 
///     Handle telemetry timer event.
/// 
void TelemetryTimerHandler(EventData *eventData)
{
	if (ConsumeTimerFdEvent(eventData->fd) != 0) {
		terminationRequired = true;
		return;
	}

	SendTelemetryMessage();
}

// forward declaration to allow reset function to gracefuly close all connections
void ClosePeripheralsAndHandlers(void);
int InitPeripheralsAndHandlers(void);

///  @brief 
///     Handle reset timer event.
/// 
void ResetTimerHandler(EventData* eventData)
{
    if (ConsumeTimerFdEvent(eventData->fd) != 0) {
        terminationRequired = true;
        return;
    }

    Log_Debug("[ResetTimerHandler] Gracefully closing and forcing system reboot.\n");
    ClosePeripheralsAndHandlers();

    if( -1 == PowerManagement_ForceSystemReboot())
    {
        Log_Debug("[ResetTimerHandler] Reboot failed %d (%s).\n", errno, strerror(errno));
        InitPeripheralsAndHandlers();
    }
}

///  @brief  Initialize peripherals, termination handler, and Azure IoT
/// @param  argc command line argument count
/// @param  argv command line argument vector
/// @returns 0 on success, or -1 on failure
int InitPeripheralsAndHandlers()
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

    // Display the currently connected WiFi connection.
    DebugPrintCurrentlyConnectedWiFiNetwork();

    fdEpoll = CreateEpollFd();
    if (fdEpoll < 0) {
        return -1;
    }

    // Initialize the Azure IoT SDK
    if (AzureIoT_DPS_Initialize(fdEpoll, cstrPnPModelId) < 0) {
        Log_Debug("ERROR: Cannot initialize Azure IoT Hub SDK.\n");
        return -1;
    }

    // Set Azure IoT client related callbacks
    AzureIoT_SetMessageReceivedHandler( &MessageReceived );
    AzureIoTJson_SetDeviceTwinUpdateHandler( &DeviceTwinUpdate );
    AzureIoTJson_RegisterDirectMethodHandlers( &clstDirectMethods[0] );
    AzureIoT_SetConnectionStatusCallback( &IoTHubConnectionStatusChanged );

    // this sets up IoT Client and starts the do-work timer loop
    AzureIoT_DPS_StartConnection();


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

    

    return 0;
}

///  @brief 
///     Close peripherals and Azure IoT
/// 
void ClosePeripheralsAndHandlers(void)
{
    Log_Debug("INFO: Closing GPIOs and Azure IoT client.\n");

    // Close timer file descriptors
    CloseFdAndPrintError(fdResetTimer, "ResetTimer");
    CloseFdAndPrintError(fdTelemetryTimer, "TelemetryTimer");
    CloseFdAndPrintError(fdButtonPollTimer, "ButtonPollTimer");
    CloseFdAndPrintError(fdLed2FlashTimer, "Led2BlinkTimer");
    CloseFdAndPrintError(fdLed1BlinkTimer, "Led1BlinkTimer");
    CloseFdAndPrintError(fdEpoll, "Epoll");

    // Close IO file descriptors
    CloseFdAndPrintError(fdBlinkRateButtonGpio, "LedBlinkRateButtonGpio");
    CloseFdAndPrintError(fdSendMessageButtonGpio, "SendMessageButtonGpio");
    CloseFdAndPrintError(fdSensorI2c, "I2C ISU3");

    // Close the LEDs and leave then off
    RgbLedUtility_CloseLeds(rgbLeds, nLedCount);

    // Destroy the IoT Hub client
    AzureIoT_DPS_DeInitialize();
}

///  @brief 
///     Main entry point for this application.
/// 
int main(int argc, char *argv[])
{
    Log_Debug("INFO: SphereBME280 application starting.\n");

	AzureIoT_DPS_Options(argc, argv);
 
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
