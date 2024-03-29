﻿/**
 * @file main.c
 * @author Juergen Schwertl (jschwert@microsoft.com)
 * @brief This sample C application for a AVNET Starter Kit Rev.2 (Azure Sphere) demonstrates how to
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
 * - UserLed blinks constantly.
 * - Pressing button A toggles the rate at which LED 1 blinks between three values.
 * - Pressing button B triggers reading sensor data and sending a message to the IoT Hub.
 * - AppStatusLed flashes red when a message is sent and flashes yellow when a message is received.
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

// include the appropriate AVNET Starter Kit revision header file. 
// The #defines have the same names on both but content differes on some (i.e. GPIO port settings for named LEDs)
#ifdef AVNETSK_REV1
#include <hw/avnet_mt3620_sk.h>
#endif
#ifdef AVNETSK_REV2
#include <hw/avnet_mt3620_sk_rev2.h>
#endif


#include <sensors.h>

#include "rgbled_utility.h"
#include "epoll_timerfd_utilities.h"
#include "azure_iot.h"
#include "azure_iot_dps.h"
#include "azure_iot_json.h"
#include "azure_iot_pnp.h"
#include "azure_iot_central.h"




// An array defining the RGB GPIOs for each LED on the device
static const GPIO_Id gpioLedPins[1][3] = {
    {AVNET_MT3620_SK_USER_LED_RED, AVNET_MT3620_SK_USER_LED_GREEN, AVNET_MT3620_SK_USER_LED_BLUE}
};

static RgbLedUtility_Colors colBlinkingLedColor = RgbLedUtility_Colors_Blue;

static const struct timespec atsBlinkingIntervals[] = {{0, 125000000}, {0, 250000000}, {0, 500000000}};
static const size_t nBlinkingIntervalsCount = sizeof(atsBlinkingIntervals) / sizeof(*atsBlinkingIntervals);

/// @brief store last orientation to only report changes.
static char *strLastOrientation = NULL;

/// @brief File descriptors - initialized to invalid value
static int fdEpoll = -1;
static int fdBlinkRateButtonGpio = -1;
static int fdSendMessageButtonGpio = -1;
static int fdAppStatusLedGpio = -1;
static int fdWifiStatusLedGpio = -1;
static int fdButtonPollTimer = -1;
static int fdUserLedBlinkTimer = -1;
static int fdAppStatusLedFlashTimer = -1;
static int fdTelemetryTimer = -1;
static int fdResetTimer = -1;
static int fdSensorI2c = -1;

/// @brief tsTelemetryInterval is set to send teleletry every 30 seconds
static const struct timespec tsTelemetryInterval = {30, 0};

/// @brief default tsResetDelay is set to reboot after 5 second (overridden by resetTimer property)
static struct timespec tsResetDelay = { 5, 0 };


static const char cstrErrorOutOfMemory[] = "ERROR: Out of memory.\n";

// Set parson library json float serialisation format to 2 digits by default
static const char cstrJsonFloatFormat[] = "%.2f";

// telemetry event messages
static const char cstrMsgPressed[] = "pressed";
static const char cstrMsgApplicationStarted[] = "Application started";

static char strWiFiStatus[128];

/// @brief The Azure IoT PnP Model Id and component property
static const char cstrPnPModelId[] = "dtmi:azsphere:SphereTTT:AVNETSK;1"; 

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

/// @brief Azure IoT PnP component "dtmi:azsphere:SphereTTT:lps22hh;1"  
static const char cstrLPS22HHComponent[] = "lps22hh";

static const char cstrSuccessProperty[] = "success";
static const char cstrMessageProperty[] = "message";
static const char cstrTemperatureProperty[] = "temperature";
static const char cstrPressureProperty[] = "pressure";

/// @brief Azure IoT PnP component "dtmi:azsphere:SphereTTT:lsm6dso;1"  
static const char cstrLSM6DSOComponent[] = "lsm6dso";

static const char cstrOrientationProperty[] = "orientation";

static const char cstrGyroObject[] = "gyro";
static const char cstrAccelerationObject[] = "acceleration";
static const char cstrXProperty[] = "x";
static const char cstrYProperty[] = "y";
static const char cstrZProperty[] = "z";

/// @brief Azure IoT PnP component "dtmi:azure:DeviceManagement:DeviceInformation;1"  
static const char cstrDevInfoComponent[] = "deviceInformation";

static const char cstrDevInfoManufacturerProperty[] = "manufacturer";
static const char cstrDevInfoModelProperty[] = "model";
static const char cstrDevInfoSWVersionProperty[] = "swVersion";
static const char cstrDevInfoOSNameProperty[] = "osName";
static const char cstrDevInfoProcArchProperty[] = "processorArchitecture";
static const char cstrDevInfoProcMfgrProperty[] = "processorManufacturer";
static const char cstrDevInfoStorageProperty[] = "totalStorage";
static const char cstrDevInfoMemoryProperty[] = "totalMemory";

static const char cstrDevInfoManufacturerValue[] = "AVNET";
static const char cstrDevInfoModelValue[] = "AVNET Starter Kit Rev1/2";
static const char cstrDevInfoSWVersionValue[] = "v" APPVERSION; // APPVERSION is build timestamp in CMakeLists.txt
static const char cstrDevInfoOSNameValue[] = "Azure Sphere IoT OS";
static const char cstrDevInfoProcArchValue[] = "ARM Core A7,M4";
static const char cstrDevInfoProcMfgrValue[] = "MediaTek";
static const int ciDevInfoStorageValue = 16384;
static const int ciDevInfoMemoryValue = 4096;

/// @brief Azure IoT PnP component "dtmi:azsphere:SphereTTT:DeviceHealth;1"
static const char cstrDevHealthComponent[] ="deviceHealth";
static const char cstrEvtConnected[] = "connect";
static const char cstrDevHealthTotalMemoryUsed[] ="totalMemoryUsed";
static const char cstrDevHealthUserMemoryUsed[] ="userMemoryUsed";
static const char cstrResetTimerProperty[] = "resetTimer";
static const char cstrResetMethodName[] = "deviceHealth*resetMethod";
static const char cstrResetResponseMsg[] = "Reset in %d seconds";

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
static RgbLed rgbUserLed = RGBLED_INIT_VALUE;
static RgbLed *rgbLeds[] = {&rgbUserLed };
static const size_t nLedCount = sizeof(rgbLeds) / sizeof(*rgbLeds);

// Default blinking rate of UserLed
static struct timespec tsBlinkingLedInterval = {0, 125000000};
static bool bBlinkingLedState;

// A null interval to not start the timer when it is created with CreateTimerFdAndAddToEpoll.
static const struct timespec tsNullInterval = {0, 0};

// AppStatusLed flashes for 300ms 
static const struct timespec tsAppStatusLedBlinkTime = {0, 300 * 1000 * 1000};

// forward declarations for timer handler
static void ButtonPollTimerHandler(EventData* eventData);
static void UserLedUpdateHandler(EventData* eventData);
static void AppStatusLedUpdateHandler(EventData* eventData);
static void TelemetryTimerHandler(EventData* eventData);
static void ResetTimerHandler(EventData* eventData);

// event handler data structures. Only the event handler field needs to be populated.
static EventData evtdataButtonPollTimer = { .eventHandler = &ButtonPollTimerHandler };
static EventData evtdataUserLedUpdate = { .eventHandler = &UserLedUpdateHandler };
static EventData evtdataAppStatusLedUpdate = { .eventHandler = &AppStatusLedUpdateHandler };
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
    char szBuffer[128];
    int nPos=0, nChar = 0;
    WifiConfig_ConnectedNetwork network;
    szBuffer[0] = '\0';

    int result = WifiConfig_GetCurrentNetwork(&network);
    if (result < 0) {
        if( (nChar=snprintf(&szBuffer[nPos], sizeof(szBuffer)-nPos, 
                            "WiFi Disconnected. ")) >= 0){
            nPos+=nChar;
        }
    } else {
        if( (nChar=snprintf(&szBuffer[nPos], sizeof(szBuffer)-nPos, 
                            "SSID \"%.*s\", Freq:%dMHz, Sig:%d. ", 
                            network.ssidLength, network.ssid, network.frequencyMHz, network.signalRssi)) >= 0){
            nPos+=nChar;
        }
    }
    Networking_Interface_HardwareAddress hwAddress;
    result = Networking_GetHardwareAddress( "wlan0", &hwAddress);
    if( result < 0){
        if( (nChar=snprintf(&szBuffer[nPos], sizeof(szBuffer)-nPos, 
                            "[ERR] No MAC. ")) >= 0){
            nPos+=nChar;
        }
    } else {
        if( (nChar=snprintf(&szBuffer[nPos], sizeof(szBuffer)-nPos, 
                            "MAC %02x:%02x:%02x:%02x:%02x:%02x. ",
                            hwAddress.address[0], hwAddress.address[1],
                            hwAddress.address[2], hwAddress.address[3],
                            hwAddress.address[4], hwAddress.address[5])) >= 0){
            nPos+=nChar;
        }
    }
    Log_Debug("[INFO] %s\n", szBuffer);
    strncpy( strWiFiStatus, szBuffer, sizeof(strWiFiStatus));
}

///  @brief 
///     Helper function to blink AppStatusLed once.
/// 
static void BlinkAppStatusLedOnce( RgbLedUtility_Colors color )
{
    GPIO_SetValue( fdAppStatusLedGpio, GPIO_Value_Low );
    SetTimerFdToSingleExpiry(fdAppStatusLedFlashTimer, ((color == RgbLedUtility_Colors_Red) ? &tsAppStatusLedBlinkTime : &tsAppStatusLedBlinkTime));
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

    if (SetTimerFdToPeriod(fdUserLedBlinkTimer, pBlinkRate) != 0) {
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

		// Set the send/receive AppStatusLed to blink once immediately to indicate 
		// the message has been queued.
		BlinkAppStatusLedOnce(RgbLedUtility_Colors_Green);
	}
	else {
		Log_Debug("[Send] not connected to IoT Central: no event sent.\n");
		BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
	}
}

/// @brief Sends a telemetry message to Azure IoT Central.
/// 
static void SendTelemetryMessage(void)
{
    JSON_Value * jsonRootValue;
    JSON_Object * jsonRootObject;

    if (connectedToIoTHub) {
        jsonRootValue = json_value_init_object();
        jsonRootObject = json_value_get_object( jsonRootValue );
        vector3d_t vector;
        bool bHasData = false;

        if( Sensors_GetAcceleration( &vector ) )
        {
            JSON_Value *jsonObjValue = NULL;
            JSON_Object *jsonObj = NULL;
            const char *cstrOrientation = Sensors_GetOrientation(&vector);

            if( (cstrOrientation != strLastOrientation) || 
                true
            )
            {
                // update "orientation" property
                jsonObjValue = json_value_init_object();
                jsonObj = json_value_get_object( jsonObjValue );
                
                json_object_set_string( jsonObj, cstrOrientationProperty, cstrOrientation); 
                AzureIoT_PnP_ReportComponentProperty( cstrLSM6DSOComponent, jsonObjValue );

                strLastOrientation = cstrOrientation;
            }

            // create payload for "acceleration" telemetry
            jsonObjValue = json_value_init_object();
            jsonObj = json_value_get_object( jsonObjValue );

            json_object_set_number(jsonObj, cstrXProperty, vector.x);
            json_object_set_number(jsonObj, cstrYProperty, vector.y);
            json_object_set_number(jsonObj, cstrZProperty, vector.z);
            json_object_set_value( jsonRootObject, cstrAccelerationObject, jsonObjValue );
            bHasData = true;
        }


        if( Sensors_GetGyro( &vector ) )
        {
            //[TODO] omit Gyro data until we calibrate the gyro first. lsm6dso sends strange values...
            // JSON_Value *jsonObjValue = json_value_init_object();
            // JSON_Object *jsonObj = json_value_get_object( jsonObjValue );

            // json_object_set_number(jsonObj, cstrXProperty, vector.x);
            // json_object_set_number(jsonObj, cstrYProperty, vector.y);
            // json_object_set_number(jsonObj, cstrZProperty, vector.z);

            // json_object_set_value( jsonRootObject, cstrGyroObject, jsonObjValue );
            // bHasData = true;
        }

        if( bHasData )
        {
            AzureIoT_PnP_SendJsonMessage(jsonRootValue, cstrLSM6DSOComponent);
        }
        json_value_free( jsonRootValue );

        // reading lps22hh resets the lsm6dso accelerometer! Reading temperature after acceleration.
        envdata_t dataset;
        if( Sensors_GetEnvironmentData( &dataset ) ){
            jsonRootValue = json_value_init_object();
            jsonRootObject = json_value_get_object( jsonRootValue );

            Log_Debug( "[Send] Temperature: %.2f °C, Pressure: %.2f hPa\n", dataset.fTemperature, dataset.fPressure_hPa);

            json_object_set_number(jsonRootObject, cstrTemperatureProperty, dataset.fTemperature);
            json_object_set_number(jsonRootObject, cstrPressureProperty, dataset.fPressure_hPa);
            
            AzureIoT_PnP_SendJsonMessage(jsonRootValue, cstrLPS22HHComponent);

            json_value_free( jsonRootValue );
        }

#ifdef BME280		
        jsonRootValue = json_value_init_object();
        jsonRootObject = json_value_get_object( jsonRootValue );

		bme280_data_t bmeData;
		if (BME280_GetSensorData(&bmeData) == 0)
		{
			Log_Debug("[Send] Component '%s': Temperature: %.2f, Pressure: %.2f, Humidity: %.2f\n", cstrBME280Component, bmeData.temperature, bmeData.pressure, bmeData.humidity);

            json_object_set_number(jsonRootObject, cstrTemperatureProperty, bmeData.temperature);
            json_object_set_number(jsonRootObject, cstrPressureProperty, bmeData.pressure);
            json_object_set_number(jsonRootObject, cstrHumidityProperty, bmeData.humidity);
            
		}
        json_value_free( jsonRootValue );
#endif

#ifdef BMP280		
        jsonRootValue = json_value_init_object();
        jsonRootObject = json_value_get_object( jsonRootValue );
		bmp280_data_t bmpData;

		if (BMP280_GetSensorData(&bmpData) == 0)
		{
			Log_Debug("[Send] Component '%s' Temperature: %.2f, Pressure: %.2f\n", cstrBMP280Component, bmpData.temperature, bmpData.pressure);

            json_object_set_number(jsonRootObject, cstrTemperatureProperty, bmpData.temperature);
            json_object_set_number(jsonRootObject, cstrPressureProperty, bmpData.pressure);
            
            AzureIoT_PnP_SendJsonMessage(jsonRootValue, cstrBMP280Component);
        }
        json_value_free( jsonRootValue );
#endif


        size_t nTotalMemUsed = Applications_GetTotalMemoryUsageInKB();
        size_t nUserMemUsed = Applications_GetUserModeMemoryUsageInKB();
        if( (nLastTotalMemoryUsed != nTotalMemUsed) || (nLastUserMemoryUsed != nUserMemUsed) ){
			Log_Debug("[Send] Component:'%s' TotalMemoryUsed: %d, UserMemoryUsed: %d\n", cstrDevHealthComponent, nTotalMemUsed, nUserMemUsed);
            
            nLastTotalMemoryUsed = nTotalMemUsed;
            nLastUserMemoryUsed = nUserMemUsed;

            jsonRootValue = json_value_init_object();
            jsonRootObject = json_value_get_object( jsonRootValue );

            json_object_set_number(jsonRootObject, cstrDevHealthTotalMemoryUsed, nTotalMemUsed);
            json_object_set_number(jsonRootObject, cstrDevHealthUserMemoryUsed, nUserMemUsed);
    
            AzureIoT_PnP_SendJsonMessage(jsonRootValue, cstrDevHealthComponent);
            json_value_free(jsonRootValue);
        }

	    BlinkAppStatusLedOnce( RgbLedUtility_Colors_Green );

    } else {
		Log_Debug("[Send] not connected to IoT Central: no telemtry sent.\n");
		BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
	}
}

/// @brief MessageReceived callback function, called when a message is received from the Azure IoT Hub.
/// @param payloadThe payload of the received message.
static void MessageReceived(const char *payload)
{
    // Set the send/receive AppStatusLed to blink once immediately to indicate a message has been received.
	BlinkAppStatusLedOnce(RgbLedUtility_Colors_Blue);
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

		BlinkAppStatusLedOnce(RgbLedUtility_Colors_Blue);
	} else {
		Log_Debug( "[DeviceTwinUpdate] received update with incorrect data:\n");
		BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
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
    JSON_Value* jsonRoot = json_value_init_object();
    JSON_Value* jsonValue = NULL;
    JSON_Value* jsonComponentValue = NULL;
    JSON_Object *jsonObject = NULL;

    jsonValue = json_value_init_object();
    jsonObject = json_value_get_object( jsonValue );
    json_object_set_string(jsonObject, cstrDevInfoManufacturerProperty, cstrDevInfoManufacturerValue);
    json_object_set_string(jsonObject, cstrDevInfoModelProperty, cstrDevInfoModelValue);
    json_object_set_string(jsonObject, cstrDevInfoSWVersionProperty, cstrDevInfoSWVersionValue);
    json_object_set_string(jsonObject, cstrDevInfoOSNameProperty, cstrDevInfoOSNameValue);
    json_object_set_string(jsonObject, cstrDevInfoProcArchProperty, cstrDevInfoProcArchValue);
    json_object_set_string(jsonObject, cstrDevInfoProcMfgrProperty, cstrDevInfoProcMfgrValue);
    json_object_set_number(jsonObject, cstrDevInfoStorageProperty, (double) ciDevInfoStorageValue);
    json_object_set_number(jsonObject, cstrDevInfoMemoryProperty, (double) ciDevInfoMemoryValue);
    
    AzureIoT_PnP_CreateComponentPropertyJson( jsonRoot, cstrDevInfoComponent, jsonValue);


    jsonValue = json_value_init_object();
    jsonObject = json_value_get_object( jsonComponentValue );
    json_object_set_number(jsonObject, cstrBlinkRateProperty, (double) nBlinkRateValue);

    AzureIoT_PnP_CreateComponentPropertyJson( jsonRoot, cstrRgbledComponent, jsonValue);

    jsonValue = json_value_init_object();
    jsonObject = json_value_get_object( jsonComponentValue );
    json_object_set_string(jsonObject, cstrOrientationProperty, strLastOrientation);

    AzureIoT_PnP_CreateComponentPropertyJson( jsonRoot, cstrLSM6DSOComponent, jsonValue);

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

        // send a "connect" event telemetry message with the WiFi status
        DebugPrintCurrentlyConnectedWiFiNetwork();
		SendEventMessage(cstrDevHealthComponent, cstrEvtConnected, strWiFiStatus);

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
///     Handle the blinking for UserLed.
/// 
static void UserLedUpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdUserLedBlinkTimer) != 0) {
        terminationRequired = true;
        return;
    }

    // Trigger UserLed to blink as appropriate.
    bBlinkingLedState = !bBlinkingLedState;
    RgbLedUtility_Colors color = (bBlinkingLedState ? colBlinkingLedColor : RgbLedUtility_Colors_Off);
    RgbLedUtility_SetLed(&rgbUserLed, color);
}

///  @brief 
///     Handle the blinking for the AppStatus LED.
/// 
static void AppStatusLedUpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdAppStatusLedFlashTimer) != 0) {
        terminationRequired = true;
        return;
    }

    // Clear the send/receive AppStatusLed.
    GPIO_SetValue( fdAppStatusLedGpio, GPIO_Value_High);
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
///  on MT35620 RDB use WiFi Status RGB-LED
///   red   : no network
///   green : conected to WiFi
///   blue : connected to IoT Hub
/// on AVNET Starter Kit
///   off : not connected to IoT Hub
///   on : connected to IoT Hub
/// [TODO] implement flashing schedule; ___I___I : connected to Network, _---_--- connecting, on : connected to IoT Hub
void NetworkLedUpdateHandler(void)
{
    // Set network status with LED3 color.
    // RgbLedUtility_Colors color = RgbLedUtility_Colors_Red;
    // Networking_IsNetworkingReady(&bIsNetworkReady);
    // if (bIsNetworkReady)
    // {
    //     color = (connectedToIoTHub ? RgbLedUtility_Colors_Blue : RgbLedUtility_Colors_Green);
    // }
    // RgbLedUtility_SetLed(&rgbNetworkLed, color);
    Networking_IsNetworkingReady(&bIsNetworkReady);
    GPIO_SetValue( fdWifiStatusLedGpio, (bIsNetworkReady && connectedToIoTHub) ? GPIO_Value_Low : GPIO_Value_High);
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


    // Set parson library json float serialisation format
    json_set_float_serialization_format( cstrJsonFloatFormat );

    // Open button A
    Log_Debug("INFO: Opening AVNET_MT3620_SK_USER_BUTTON_A.\n");
    if (!OpenGpioFdAsInput(AVNET_MT3620_SK_USER_BUTTON_A, &fdBlinkRateButtonGpio)) {
        return -1;
    }

    // Open button B
    Log_Debug("INFO: Opening AVNET_MT3620_SK_USER_BUTTON_B.\n");
    if (!OpenGpioFdAsInput(AVNET_MT3620_SK_USER_BUTTON_B, &fdSendMessageButtonGpio)) {
        return -1;
    }

    // Open Wifi status LED
    Log_Debug("INFO: Opening AVNET_MT3620_SK_WLAN_STATUS_LED_YELLOW.\n");
    fdWifiStatusLedGpio = GPIO_OpenAsOutput(AVNET_MT3620_SK_WLAN_STATUS_LED_YELLOW, GPIO_OutputMode_PushPull, GPIO_Value_High );
    if (fdWifiStatusLedGpio < 0) {
        Log_Debug( "ERROR: cannot open AVNET_MT3620_SK_WLAN_STATUS_LED_YELLOW as output.");
        return -1;
    }

    // Open Wifi status LED
    Log_Debug("INFO: Opening AVNET_MT3620_SK_APP_STATUS_LED_YELLOW.\n");
    fdAppStatusLedGpio = GPIO_OpenAsOutput(AVNET_MT3620_SK_APP_STATUS_LED_YELLOW, GPIO_OutputMode_PushPull, GPIO_Value_High );
    if (fdAppStatusLedGpio < 0) {
        Log_Debug( "ERROR: cannot open AVNET_MT3620_SK_APP_STATUS_LED_YELLOW as output.");
        return -1;
    }

    Log_Debug("INFO: Opening AVNET_MT3620_SK_ISU2_I2C.\n");
    if ((fdSensorI2c = I2CMaster_Open(AVNET_MT3620_SK_ISU2_I2C)) < 0)
    {
        return -1;
    }
    Sensors_Init( fdSensorI2c );
    strLastOrientation = Sensors_GetOrientation( NULL );

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


    // Set up a timer for UserLed blinking
    fdUserLedBlinkTimer =
        CreateTimerFdAndAddToEpoll(fdEpoll, &tsBlinkingLedInterval, &evtdataUserLedUpdate, EPOLLIN);
    if (fdUserLedBlinkTimer < 0) {
        return -1;
    }

    // Set up a a dis-armed timer for blinking AppStatusLed once.
    fdAppStatusLedFlashTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullInterval, &evtdataAppStatusLedUpdate, EPOLLIN);
    if (fdAppStatusLedFlashTimer < 0) {
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
    CloseFdAndPrintError(fdAppStatusLedFlashTimer, "AppStatusLedBlinkTimer");
    CloseFdAndPrintError(fdUserLedBlinkTimer, "UserLedBlinkTimer");
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
