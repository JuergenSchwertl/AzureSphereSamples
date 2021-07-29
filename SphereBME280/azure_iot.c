/**
* @brief Refer to @link https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-device-sdk-c-intro for more
* information on Azure IoT SDK for C
*/

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <time.h>

// Azure IoT SDK
#include <azureiot/iothub_device_client_ll.h>
#include <azureiot/iothub_client_options.h>
#include <azureiot/iothubtransportmqtt.h>
#include <azureiot/iothub.h>
#include <azureiot/azure_sphere_provisioning.h>
#include <azure_c_shared_utility/shared_util_options.h>
#include <azure_prov_client/prov_device_ll_client.h>
#include <azure_prov_client/iothub_security_factory.h>
#include <azure_prov_client/prov_security_factory.h>
#include <azure_prov_client/prov_transport_mqtt_client.h>

#include <applibs/log.h>
#include <applibs/networking.h>
#include "epoll_timerfd_utilities.h"
#include "azure_iot.h"

#define MODULE "[IOT] "


static int directMethodCallback(
    const char* methodName, 
    const unsigned char* payload, size_t payloadSize,
    unsigned char** response, size_t* responseSize,
    void* userContextCallback);

static void deviceTwinUpdateCallback(
    DEVICE_TWIN_UPDATE_STATE updateState,
    const unsigned char* payLoad, size_t payLoadSize,
    void* userContextCallback);

static void sendMessageCallback(
    IOTHUB_CLIENT_CONFIRMATION_RESULT result, 
    void* context);

static IOTHUBMESSAGE_DISPOSITION_RESULT receiveMessageCallback(
    IOTHUB_MESSAGE_HANDLE message,
    void* context);

static void hubConnectionStatusCallback(
    IOTHUB_CLIENT_CONNECTION_STATUS result,
    IOTHUB_CLIENT_CONNECTION_STATUS_REASON reason,
    void* userContextCallback);



/// @brief   Turn Azure IoT tracing on/off
bool bTraceOn = true;

/// @brief timer file descriptor
static int fdAzureIoTWorkerTimer = -1;

// Azure IoT poll periods
static const int AzureIoTDefaultPollPeriodSeconds = 5;
static const int AzureIoTMinReconnectPeriodSeconds = 10;
static const int AzureIoTMaxReconnectPeriodSeconds = 10 * 60;

static int azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;


/// @brief    Buffer for DPS Scope ID. Filled on app start via command line parameter
static char strDPSSopeId[MAX_SCOPEID_LENGTH] = ""; 

/// @brief    Buffer for  Azure IoT PnP Model Id
char strPnPModelId[MAX_MODELID_LENGTH] = ""; 

static IOTHUB_CLIENT_DEVICE_TWIN_CALLBACK fn_LL_DeviceTwinUpdateHandler = deviceTwinUpdateCallback;

static IOTHUB_CLIENT_MESSAGE_CALLBACK_ASYNC fn_LL_MessageReceivedHandler = receiveMessageCallback;

static IOTHUB_CLIENT_DEVICE_METHOD_CALLBACK_ASYNC fn_LL_DirectMethodHandler = directMethodCallback;

/// @brief    Function invoked to provide the result of the Device Twin reported properties delivery
static DeviceTwinDeliveryConfirmationFnType fnDeviceTwinConfirmationHandler = 0;

/// @brief    Function invoked whenever a Direct Method call is received from the IoT Hub
static DirectMethodCallFnType fnDirectMethodHandler = 0;

/// @brief    Function invoked whenever a Device Twin update is received from the IoT Hub
static TwinUpdateFnType fnTwinUpdateHandler = 0;

/// @brief    Function invoked whenever the connection status to the IoT Hub changes
static ConnectionStatusFnType fnConnectionStatusChangedHandler = 0;

/// @brief    Function invoked whenever a message is received from the IoT Hub
static MessageReceivedFnType fnMessageReceivedHandler = 0;

/// @brief    Function invoked to report the delivery confirmation of a message sent to the IoT Hub
static MessageDeliveryConfirmationFnType fnMessageDeliveryConfirmationHandler = 0;

/// @brief    The handle to the IoT Hub client used for communication with the hub
static IOTHUB_DEVICE_CLIENT_LL_HANDLE hIoTHubClient = NULL;

/// @brief    The status of the authentication to the hub. When 'false' a connection and authentication to the hub will be attempted
static bool bIoTHubAuthenticated = false;

/// @brief    Used to set the keepalive period over MQTT to 20 seconds
static int iKeepalivePeriodSeconds = 20;

/// @brief    Message Id system property
static unsigned int uMessageId = 0;

void doWorkHandler(EventData* eventData);

static EventData evtdataAzureIoTWorker = { .eventHandler = &doWorkHandler };


/// @brief    re-usable error and warning strings
const char cstrErrorOutOfMemory[] = "[IoT] ERROR: out of memory.\n";
const char cstrWarnNotInitialized[] = "[IoT] WARNING: IoT Hub client not initialized\n";


/// @brief   Content encoding strings for message properties
content_encoding_t ContentEncoding = { 
    .UTF_8          = "utf-8",
    .UTF_16         = "utf-16", // == utf-16le, unicodefeff
    // .ASCII          = "ascii",
    // .UTF_7          = "utf-7",
    // .UTF_16BE       = "utf-16be", // unicodefffe
    // .UTF_32         = "utf-32",
    // .Unicode        = "unicode"
};


/// @brief   URL-encoded content types for message properties
content_type_t ContentType = { 
    .Application_OctetStream    = "application%2Foctet-stream",
    .Application_PDF            = "application%2Fpdf",
    .Application_XHTML_XML      = "application%2Fxhtml+xml",
    .Application_JSON           = "application%2Fjson",
    .Application_LD_JSON        = "application%2Fld+json",
    .Application_XML            = "application%2Fxml",
    // .Application_ZIP            = "application%2Fzip",
    // .Application_UrlEncoded     = "application%2Fx-www-form-urlencoded",

    // .Image_GIF                  = "image%2Fgif",
    // .Image_JPEG                 = "image%2Fjpeg",
    // .Image_PNG                  = "image%2Fpng",
    // .Image_TIFF                 = "image%2Ftiff",

    // .Multipart_Mixed            = "multipart%2Fmixed",
    // .Multipart_Alternative      = "multipart%2Falternative",
    .Multipart_FormData         = "multipart%2Fform-data",

    .Text_CSS                    = "text%2Fcss", 
    .Text_CSV                    = "text%2Fcsv", 
    .Text_HTML                   = "text%2Fhtml", 
    .Text_Plain                  = "text%2Fplain", 
    .Text_XML                    = "text%2Fxml"
};

/*
* @brief    Set of bundle of root certificate authorities including the new DigiCert Global Root.
*     @link https://techcommunity.microsoft.com/t5/internet-of-things/azure-iot-tls-critical-changes-are-almost-here-and-why-you/ba-p/2393169
*    These updated certs will be part of an upcoming Azure Sphere OS release automatically in good time before the Cert rotation happens
*    You can also copy the certificates from @link https://github.com/Azure/azure-iot-sdk-c/tree/master/certs 
*    or add your Azure IoT Edge Hub TLS certificate  
*/

#if defined(USE_AZURE_CLOUD_ECC_CERT)
static const char cstrAzureIoTCertificates[] =
/* DigiCert Global Root G3 */
"-----BEGIN CERTIFICATE-----\r\n"
"MIICPzCCAcWgAwIBAgIQBVVWvPJepDU1w6QP1atFcjAKBggqhkjOPQQDAzBhMQsw\r\n"
"CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu\r\n"
"ZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBHMzAe\r\n"
"Fw0xMzA4MDExMjAwMDBaFw0zODAxMTUxMjAwMDBaMGExCzAJBgNVBAYTAlVTMRUw\r\n"
"EwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20x\r\n"
"IDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IEczMHYwEAYHKoZIzj0CAQYF\r\n"
"K4EEACIDYgAE3afZu4q4C/sLfyHS8L6+c/MzXRq8NOrexpu80JX28MzQC7phW1FG\r\n"
"fp4tn+6OYwwX7Adw9c+ELkCDnOg/QW07rdOkFFk2eJ0DQ+4QE2xy3q6Ip6FrtUPO\r\n"
"Z9wj/wMco+I+o0IwQDAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAd\r\n"
"BgNVHQ4EFgQUs9tIpPmhxdiuNkHMEWNpYim8S8YwCgYIKoZIzj0EAwMDaAAwZQIx\r\n"
"AK288mw/EkrRLTnDCgmXc/SINoyIJ7vmiI1Qhadj+Z4y3maTD/HMsQmP3Wyr+mt/\r\n"
"oAIwOWZbwmSNuJ5Q3KjVSaLtx9zRSX8XAbjIho9OjIgrqJqpisXRAL34VOKa5Vt8\r\n"
"sycX\r\n"
"-----END CERTIFICATE-----\r\n"

/*  Microsoft ECC Root Certificate Authority 2017 */
"-----BEGIN CERTIFICATE-----\r\n"
"MIICWTCCAd+gAwIBAgIQZvI9r4fei7FK6gxXMQHC7DAKBggqhkjOPQQDAzBlMQsw\r\n"
"CQYDVQQGEwJVUzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTYwNAYD\r\n"
"VQQDEy1NaWNyb3NvZnQgRUNDIFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIw\r\n"
"MTcwHhcNMTkxMjE4MjMwNjQ1WhcNNDIwNzE4MjMxNjA0WjBlMQswCQYDVQQGEwJV\r\n"
"UzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTYwNAYDVQQDEy1NaWNy\r\n"
"b3NvZnQgRUNDIFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTcwdjAQBgcq\r\n"
"hkjOPQIBBgUrgQQAIgNiAATUvD0CQnVBEyPNgASGAlEvaqiBYgtlzPbKnR5vSmZR\r\n"
"ogPZnZH6thaxjG7efM3beaYvzrvOcS/lpaso7GMEZpn4+vKTEAXhgShC48Zo9OYb\r\n"
"hGBKia/teQ87zvH2RPUBeMCjVDBSMA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8E\r\n"
"BTADAQH/MB0GA1UdDgQWBBTIy5lycFIM+Oa+sgRXKSrPQhDtNTAQBgkrBgEEAYI3\r\n"
"FQEEAwIBADAKBggqhkjOPQQDAwNoADBlAjBY8k3qDPlfXu5gKcs68tvWMoQZP3zV\r\n"
"L8KxzJOuULsJMsbG7X7JNpQS5GiFBqIb0C8CMQCZ6Ra0DvpWSNSkMBaReNtUjGUB\r\n"
"iudQZsIxtzm6uBoiB078a1QWIP8rtedMDE2mT3M=\r\n"
"-----END CERTIFICATE-----\r\n"
;
#endif

MU_DEFINE_ENUM_STRINGS_WITHOUT_INVALID(IOTHUB_CLIENT_RESULT, IOTHUB_CLIENT_RESULT_VALUE);


/**
* @brief Converts the IoT Hub connection status reason to a string.
* 
* @param    reason  Connection change status reason
*
* @return Connection status as string
*/
static const char *getReasonString(IOTHUB_CLIENT_CONNECTION_STATUS_REASON reason)
{
    switch (reason) {
        case IOTHUB_CLIENT_CONNECTION_EXPIRED_SAS_TOKEN:
            return "IOTHUB_CLIENT_CONNECTION_EXPIRED_SAS_TOKEN";
        case IOTHUB_CLIENT_CONNECTION_DEVICE_DISABLED:
            return "IOTHUB_CLIENT_CONNECTION_DEVICE_DISABLED";
        case IOTHUB_CLIENT_CONNECTION_BAD_CREDENTIAL:
            return "IOTHUB_CLIENT_CONNECTION_BAD_CREDENTIAL";
        case IOTHUB_CLIENT_CONNECTION_RETRY_EXPIRED:
            return "IOTHUB_CLIENT_CONNECTION_RETRY_EXPIRED";
        case IOTHUB_CLIENT_CONNECTION_NO_NETWORK:
            return "IOTHUB_CLIENT_CONNECTION_NO_NETWORK";
        case IOTHUB_CLIENT_CONNECTION_COMMUNICATION_ERROR:
            return "IOTHUB_CLIENT_CONNECTION_COMMUNICATION_ERROR";
        case IOTHUB_CLIENT_CONNECTION_OK:
            return "IOTHUB_CLIENT_CONNECTION_OK";
        case IOTHUB_CLIENT_CONNECTION_NO_PING_RESPONSE:
            return "IOTHUB_CLIENT_CONNECTION_NO_PING_RESPONSE";
    }
    return "unknown IOTHUB_CLIENT_CONNECTION_STATUS_REASON";
}

/**
* @brief Converts AZURE_SPHERE_PROV_RETURN_VALUE to a string.
* 
* @param    provisioningResult  result of provisioning phase
* @return   Provisioning result string
*/
static char *getAzureSphereProvisioningResultString(
    AZURE_SPHERE_PROV_RETURN_VALUE provisioningResult)
{
    switch (provisioningResult.result) {
    case AZURE_SPHERE_PROV_RESULT_OK:
        return "AZURE_SPHERE_PROV_RESULT_OK";
    case AZURE_SPHERE_PROV_RESULT_INVALID_PARAM:
        return "AZURE_SPHERE_PROV_RESULT_INVALID_PARAM";
    case AZURE_SPHERE_PROV_RESULT_NETWORK_NOT_READY:
        return "AZURE_SPHERE_PROV_RESULT_NETWORK_NOT_READY";
    case AZURE_SPHERE_PROV_RESULT_DEVICEAUTH_NOT_READY:
        return "AZURE_SPHERE_PROV_RESULT_DEVICEAUTH_NOT_READY";
    case AZURE_SPHERE_PROV_RESULT_PROV_DEVICE_ERROR:
        switch (provisioningResult.prov_device_error) {
            case PROV_DEVICE_RESULT_INVALID_ARG:
                return "PROV_DEVICE_RESULT_INVALID_ARG";
            case PROV_DEVICE_RESULT_SUCCESS:
                return "PROV_DEVICE_RESULT_SUCCESS";
            case PROV_DEVICE_RESULT_MEMORY:
                return "PROV_DEVICE_RESULT_MEMORY";
            case PROV_DEVICE_RESULT_PARSING:
                return "PROV_DEVICE_RESULT_PARSING";
            case PROV_DEVICE_RESULT_TRANSPORT:
                return "PROV_DEVICE_RESULT_TRANSPORT";
            case PROV_DEVICE_RESULT_INVALID_STATE:
                return "PROV_DEVICE_RESULT_INVALID_STATE";
            case PROV_DEVICE_RESULT_DEV_AUTH_ERROR:
                return "PROV_DEVICE_RESULT_DEV_AUTH_ERROR";
            case PROV_DEVICE_RESULT_TIMEOUT:
                return "PROV_DEVICE_RESULT_TIMEOUT";
            case PROV_DEVICE_RESULT_KEY_ERROR:
                return "PROV_DEVICE_RESULT_KEY_ERROR";
            case PROV_DEVICE_RESULT_ERROR:
                return "PROV_DEVICE_RESULT_ERROR";
            case PROV_DEVICE_RESULT_HUB_NOT_SPECIFIED:
                return "PROV_DEVICE_RESULT_HUB_NOT_SPECIFIED";
            case PROV_DEVICE_RESULT_UNAUTHORIZED:
                return "PROV_DEVICE_RESULT_UNAUTHORIZED";
            case PROV_DEVICE_RESULT_DISABLED:
                return "PROV_DEVICE_RESULT_DISABLED";
            case PROV_DEVICE_RESULT_OK:
                break;
        }
        return "AZURE_SPHERE_PROV_RESULT_PROV_DEVICE_ERROR";
    case AZURE_SPHERE_PROV_RESULT_IOTHUB_CLIENT_ERROR:
        switch (provisioningResult.iothub_client_error) {
            case IOTHUB_CLIENT_INVALID_ARG:
                return "IOTHUB_CLIENT_INVALID_ARG";
            case IOTHUB_CLIENT_ERROR:
                return "IOTHUB_CLIENT_ERROR";
            case IOTHUB_CLIENT_INVALID_SIZE:
                return "IOTHUB_CLIENT_INVALID_SIZE";
            case IOTHUB_CLIENT_INDEFINITE_TIME:
                return "IOTHUB_CLIENT_INDEFINITE_TIME";
            case IOTHUB_CLIENT_OK:
                break;
            }
        return "AZURE_SPHERE_PROV_RESULT_IOTHUB_CLIENT_ERROR";
    case AZURE_SPHERE_PROV_RESULT_GENERIC_ERROR:
        return "AZURE_SPHERE_PROV_RESULT_GENERIC_ERROR";
    default:
        return "UNKNOWN_RETURN_VALUE";
    }
}

char * AzureIoT_GetStringFromPayload(const char* cstrPayload, size_t nPayloadSize)
{
    // 'payload' is not zero terminated.
    char* str = (char *) malloc(nPayloadSize + 1);
    if (str == NULL) {
        Log_Debug( cstrErrorOutOfMemory );
        abort();
    }
    memcpy(str, cstrPayload, nPayloadSize);
    str[nPayloadSize] = '\0';

    return str;
}

/**
 * @brief Hand over control periodically to the Azure IoT SDK's DoWork.
 * 
 * @param eventData 
 */
void doWorkHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdAzureIoTWorkerTimer) != 0) {
        return;
    }

    bool bNetworkReady = false;
    Networking_IsNetworkingReady(&bNetworkReady);
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

        Log_Debug( MODULE "ERROR: Failed to connect to IoT Hub; will retry in %i seconds\n",
                  azureIoTPollPeriodSeconds);
    }
}

/*
* @brief    Periodically outputs a provided format string with a variable number of arguments.
* 
* @param    lastInvokedTime">Pointer where to store the 'last time this function has been
* invoked' information
* @param    periodInSeconds">The desired period of the output
* @param    format  The format string
*/
static void periodicLogVarArgs(time_t *lastInvokedTime, time_t periodInSeconds, const char *format,
                               ...)
{
    struct timespec ts;
    int timeOk = timespec_get(&ts, TIME_UTC);
    if (!timeOk) {
        return;
    }

    if (ts.tv_sec > *lastInvokedTime + periodInSeconds) {
        va_list args;
        va_start(args, format);
        Log_DebugVarArgs(format, args);
        va_end(args);
        *lastInvokedTime = ts.tv_sec;
    }
}

/*
* @brief    Keeps IoT Hub Client alive by exchanging data with the Azure IoT Hub.
*
* When using low level samples (iothub_ll_*), the IoTHubDeviceClient_LL_DoWork function must be called regularly 
* (eg. every 100 milliseconds) for the IoT device client to work properly.
* <a href="https://github.com/Azure/azure-iot-sdk-c/blob/1c1b2c1a3a00bc445165dde44eb3e58ca999ec23/iothub_client/samples/readme.md#note" />
*/
void AzureIoT_DoPeriodicTasks(void)
{
    static time_t lastTimeLogged = 0;

    if (bIoTHubAuthenticated) {
        periodicLogVarArgs(&lastTimeLogged, 5,  MODULE "%s calls in progress...\n", __func__);

        // DoWork - send some of the buffered events to the IoT Hub, and receive some of the
        // buffered events from the IoT Hub.
        IoTHubDeviceClient_LL_DoWork(hIoTHubClient);
    }
}


/********************************************
*
*
* Telemetry messages related functions
*
*
*********************************************/


IOTHUB_MESSAGE_HANDLE AzureIoT_CreateIoTHubMessage(const char* cstrMessage, const char *cstrContentType, const char * cstrContentEncoding)
{
    if (hIoTHubClient == NULL) {
        Log_Debug(cstrWarnNotInitialized);
        return NULL;
    }

    IOTHUB_MESSAGE_HANDLE hMessage = IoTHubMessage_CreateFromString(cstrMessage);
    if (NULL == hMessage) {
        Log_Debug(MODULE "WARNING: unable to create a new IoTHubMessage\n");
        return NULL;
    }

    // Set Message properties: for MessageId, use a running message count value.
    char szMessageId[16];
    snprintf(szMessageId, sizeof(szMessageId), "%d", uMessageId++);
    (void)IoTHubMessage_SetMessageId(hMessage, szMessageId);

    if( NULL != cstrContentType ){
        (void)IoTHubMessage_SetContentTypeSystemProperty(hMessage, cstrContentType);
    }
    if( NULL != cstrContentEncoding ){
        (void)IoTHubMessage_SetContentEncodingSystemProperty(hMessage, cstrContentEncoding);
    }

    return hMessage;
}


IOTHUB_CLIENT_RESULT AzureIoT_SendIoTHubMessage(IOTHUB_MESSAGE_HANDLE hMessage)
{
    if ( NULL == hIoTHubClient) {
        Log_Debug(cstrWarnNotInitialized);
        return IOTHUB_CLIENT_INVALID_ARG;
    }
    if ( NULL == hMessage )
    {
        Log_Debug(cstrWarnNotInitialized);
        return IOTHUB_CLIENT_INVALID_ARG;
    }

    IOTHUB_CLIENT_RESULT result = IoTHubDeviceClient_LL_SendEventAsync(hIoTHubClient, hMessage, sendMessageCallback,
        /*&callback_param*/ 0);

    if ( IOTHUB_CLIENT_OK != result) {
        Log_Debug(MODULE "ERROR: _LL_SendEvent returns %s\n",IOTHUB_CLIENT_RESULTStrings(result));
    }
    else {
        Log_Debug(MODULE "IoTHubClient accepted the message for delivery\n");
    }

    IoTHubMessage_Destroy(hMessage);
    return result;
}


IOTHUB_CLIENT_RESULT AzureIoT_SendMessageWithContentType(const char* cstrMessage, const char *cstrContentType, const char * cstrContentEncoding)
{
    IOTHUB_MESSAGE_HANDLE hMessage = AzureIoT_CreateIoTHubMessage( cstrMessage, cstrContentType, cstrContentEncoding);
    if (NULL == hMessage) {
        return IOTHUB_CLIENT_ERROR;
    }

    //// Add custom properties to message, i.e. for IoT Hub Message Routing
    //(void)IoTHubMessage_SetProperty(hMessage, "MyProperty", "MyValue");

    return AzureIoT_SendIoTHubMessage( hMessage );
}


IOTHUB_CLIENT_RESULT AzureIoT_SendPlainTextMessage(const char *cstrMessage)
{
    return AzureIoT_SendMessageWithContentType(cstrMessage, ContentType.Text_Plain, ContentEncoding.UTF_8);
}

/**
* @brief    Function invoked when the message delivery confirmation is being reported.
*
* @param    result      Message delivery status
* @param    context     User specified context
*/
static void sendMessageCallback(IOTHUB_CLIENT_CONFIRMATION_RESULT result, void* context)
{
    Log_Debug(MODULE "Message received by IoT Hub. Result is: %d\n", result);
    if (fnMessageDeliveryConfirmationHandler) {
        fnMessageDeliveryConfirmationHandler(result == IOTHUB_CLIENT_CONFIRMATION_OK);
    }
}


/**
 * @brief Internal message received handler extracting string from payload and calling external message handler
 * @param message   handle of received IoT Hub message 
 * @param context   additional context provided by low level IoT Hub client
 * @return  IOTHUBMESSAGE_ACCEPTED to acknowledge message
 */
static IOTHUBMESSAGE_DISPOSITION_RESULT receiveMessageCallback(IOTHUB_MESSAGE_HANDLE message,
    void* context)
{
    const unsigned char* pBuffer = NULL;
    size_t nPayloadSize = 0;
    IOTHUB_MESSAGE_RESULT result;
    if ((result = IoTHubMessage_GetByteArray(message, &pBuffer, &nPayloadSize)) != IOTHUB_MESSAGE_OK) {
        Log_Debug("[IoT] WARNING: failure performing IoTHubMessage_GetByteArray: %d\n", result);
        return result;
    }

    // 'buffer' is not zero terminated.
    char* strMessage = AzureIoT_GetStringFromPayload( (const char *)pBuffer, nPayloadSize);

    Log_Debug("[IoT] Received message '%s' from IoT Hub\n", strMessage);

    if (fnMessageReceivedHandler != 0) {
        fnMessageReceivedHandler( strMessage );
    }
    else {
        Log_Debug( MODULE "WARNING: no MessageReceived handler registered'\n");
    }
    
    free(strMessage);
    
    return IOTHUBMESSAGE_ACCEPTED;
}

void AzureIoT_SetMessageReceivedCallback(IOTHUB_CLIENT_MESSAGE_CALLBACK_ASYNC callback)
{
    fn_LL_MessageReceivedHandler = callback;
    if (NULL != hIoTHubClient)
    {
        IoTHubDeviceClient_LL_SetMessageCallback(hIoTHubClient, fn_LL_MessageReceivedHandler, NULL);
    }
}

void AzureIoT_SetMessageReceivedHandler(MessageReceivedFnType handler)
{
    fnMessageReceivedHandler = handler;
    AzureIoT_SetMessageReceivedCallback(&receiveMessageCallback);
}


void AzureIoT_SetMessageConfirmationCallback(MessageDeliveryConfirmationFnType callback)
{
    fnMessageDeliveryConfirmationHandler = callback;
}


/********************************************
*
*
* Device Twin Update related functions
*
*
*********************************************/

/**
* @brief Callback invoked when the Device Twin reported properties are accepted by IoT Hub.
*
* @param    iStatus             HTTP status code
* @param    pContextCallback    context specific pointer
*/
static void reportStatusCallback(int iStatus, void* pContextCallback)
{
    Log_Debug(MODULE "Device Twin reported properties update result: HTTP status code %d\n",
        iStatus);
    if (fnDeviceTwinConfirmationHandler)
        fnDeviceTwinConfirmationHandler(iStatus);
}


IOTHUB_CLIENT_RESULT AzureIoT_TwinReportState(
    const char* pszProperties,
    size_t nPropertiesSize)
{
    if (hIoTHubClient == NULL) {
        Log_Debug(cstrWarnNotInitialized);
        return IOTHUB_CLIENT_ERROR;
    }

    if (pszProperties == NULL || nPropertiesSize == 0)
    {   // nothing to report
        return IOTHUB_CLIENT_OK;
    }

    IOTHUB_CLIENT_RESULT result = IoTHubDeviceClient_LL_SendReportedState(hIoTHubClient, 
            pszProperties, nPropertiesSize, reportStatusCallback, 0);
    
    if (result != IOTHUB_CLIENT_OK) {
        Log_Debug("[IoT] ERROR: IOTHUB_CLIENT_RESULT %d with properties %s\n", result, pszProperties);
    }
    else {
        Log_Debug("[IoT] reported properties %s\n", pszProperties);
    }

    return result;
}

/**
* @brief    Internal Callback invoked when a Device Twin update is received from IoT Hub.
*/
static void deviceTwinUpdateCallback(DEVICE_TWIN_UPDATE_STATE updateState, const unsigned char *payLoad,
                         size_t payLoadSize, void *userContextCallback)
{
    if (fnTwinUpdateHandler == NULL) {
        Log_Debug( MODULE "WARNING: Received device twin update but no handler available.");
        return;
    }

    char* strProperties = AzureIoT_GetStringFromPayload(payLoad, payLoadSize);

    // Call the provided string based Twin Device Update handler
    fnTwinUpdateHandler(strProperties);

    free(strProperties);
}

/*
* @brief    Sets the raw callback invoked whenever a Device Twin Update is received.
*
* @param    handler    The handler invoked when a Device Twin update is received
*/
void AzureIoT_SetDeviceTwinUpdateCallback(IOTHUB_CLIENT_DEVICE_TWIN_CALLBACK callback)
{
    fn_LL_DeviceTwinUpdateHandler = callback;
    if (NULL != hIoTHubClient) {
        IoTHubDeviceClient_LL_SetDeviceTwinCallback(hIoTHubClient, fn_LL_DeviceTwinUpdateHandler, NULL);
    }
}

/*
* @brief    Sets a string based handler invoked whenever a Device Twin Update is received.
*
* @param    handler    The handler invoked when a Device Twin update is received
*/
void AzureIoT_SetDeviceTwinUpdateHandler(TwinUpdateFnType handler)
{
    AzureIoT_SetDeviceTwinUpdateCallback(&deviceTwinUpdateCallback);
    fnTwinUpdateHandler = handler;
}

/*
* @brief    Sets the callback invoked when the IoT Hub confirms Device Twin Update.
*
* @param    handler    The handler invoked when a Device Twin update is confirmed
*/
void AzureIoT_SetDeviceTwinDeliveryConfirmationCallback(
    DeviceTwinDeliveryConfirmationFnType callback)
{
    fnDeviceTwinConfirmationHandler = callback;
}


/********************************************
*
*
* Direct Method related functions
*
*
*********************************************/

/**
* @brief    Internal Callback when direct method is called.
*/
static int directMethodCallback(const char* methodName, const unsigned char* payload, size_t payloadSize,
    unsigned char** response, size_t* responseSize,
    void* userContextCallback)
{
    if (NULL == fnDirectMethodHandler) {
        Log_Debug(MODULE "Received direct method %s but no handler found\n", methodName);
        return HTTP_NOT_FOUND;
    }

    const char* strPayload = AzureIoT_GetStringFromPayload(payload, payloadSize);
    char* strResponse = NULL;
    int result = fnDirectMethodHandler(methodName, strPayload, &strResponse);
    if (NULL != strResponse) {
        *response = (unsigned char*) strResponse;
        *responseSize = strlen(strResponse) - 1;
    }
    return result;
}


/*
* @brief    Sets a raw low-level function to be invoked whenever a Direct Method call from the IoT Hub is
*     received.
*
* @param    callback    The callback function invoked when a Direct Method call is received
*/
void AzureIoT_SetDirectMethodCallback(IOTHUB_CLIENT_DEVICE_METHOD_CALLBACK_ASYNC callback)
{
    fn_LL_DirectMethodHandler = callback;
    if (NULL != hIoTHubClient) {
        IoTHubDeviceClient_LL_SetDeviceMethodCallback(hIoTHubClient, fn_LL_DirectMethodHandler, NULL);
    }
}

/*
* @brief    Sets a raw low-level function to be invoked whenever a Direct Method call from the IoT Hub is
*     received.
*
* @param    callback    The callback function invoked when a Direct Method call is received
*/
void AzureIoT_SetDirectMethodHandler(DirectMethodCallFnType handler)
{
    fnDirectMethodHandler = handler;
    AzureIoT_SetDirectMethodCallback(&directMethodCallback);
}



/********************************************
*
*
* IoT Hub Connection related functions
*
*
*********************************************/

/*
* @brief    Internal Callback function invoked whenever the connection status to IoT Hub changes.
* 
* @param    result              Current authentication status
* @param    reason              result's specific reason
* @param    userContextCallback User specified context
*/
static void hubConnectionStatusCallback(IOTHUB_CLIENT_CONNECTION_STATUS result,
                                        IOTHUB_CLIENT_CONNECTION_STATUS_REASON reason,
                                        void *userContextCallback)
{
    bIoTHubAuthenticated = (result == IOTHUB_CLIENT_CONNECTION_AUTHENTICATED);
    const char* reasonString = getReasonString(reason);
    if (fnConnectionStatusChangedHandler) {
        fnConnectionStatusChangedHandler(bIoTHubAuthenticated, reasonString);
    }
    if (!bIoTHubAuthenticated) {
        Log_Debug("[IoT] IoT Hub connection is down (%s), retrying connection...\n", reasonString);
    } else {
        Log_Debug("[IoT] connection to the IoT Hub has been established (%s).\n", reasonString);
    }
}

/*
* @brief    Sets the function to be invoked whenever the connection status to the IoT Hub changes.
*
* @param    callback    The callback function invoked when Azure IoT Hub network connection
*                       status changes.
*/
void AzureIoT_SetConnectionStatusCallback(ConnectionStatusFnType callback)
{
    fnConnectionStatusChangedHandler = callback;
}



/********************************************
*
*
* Setup/cleanup/configuration functions
*
*
*********************************************/

bool AzureIoT_SetupClient(void)
{
    if (bIoTHubAuthenticated && (hIoTHubClient != NULL))
        return true;

    if (hIoTHubClient != NULL)
        IoTHubDeviceClient_LL_Destroy(hIoTHubClient);

    AZURE_SPHERE_PROV_RETURN_VALUE provResult =
        IoTHubDeviceClient_LL_CreateWithAzureSphereDeviceAuthProvisioning(strDPSSopeId, 10000,
            &hIoTHubClient);
    Log_Debug(MODULE "...AzureSphereDeviceAuthProvisioning returned '%s'.\n",
        getAzureSphereProvisioningResultString(provResult));

    if ((hIoTHubClient == NULL) || (provResult.result != AZURE_SPHERE_PROV_RESULT_OK)) {
        return false;
    }

    // Provisioning and authentication succeeded.
    bIoTHubAuthenticated = true;

#if defined(USE_AZURE_CLOUD_ECC_CERT)
    if (IOTHUB_CLIENT_OK !=
        IoTHubDeviceClient_LL_SetOption(hIoTHubClient, "TrustedCerts", cstrAzureIoTCertificates))
    {
        Log_Debug("[IoT] ERROR: failure to set option \"TrustedCerts\"\n");
        return false;
    }
#endif

    if (IOTHUB_CLIENT_OK !=
        IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_LOG_TRACE, &bTraceOn))
    {
        Log_Debug(MODULE "ERROR: failure setting option \"%s\"\n", OPTION_LOG_TRACE);
        return false;
    }

    static bool bUrlAutoEncodeDecode = true;
    if (IOTHUB_CLIENT_OK !=
        IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_AUTO_URL_ENCODE_DECODE, &bUrlAutoEncodeDecode))
    {
        Log_Debug(MODULE "ERROR: failure setting option \"%s\"\n", OPTION_AUTO_URL_ENCODE_DECODE);
        return false;
    }

    // Sets Azure IoT PnP Model ID on IoT Hub Client
    if (IOTHUB_CLIENT_OK !=
        IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_MODEL_ID, strPnPModelId))
    {
        Log_Debug(MODULE "ERROR: failure setting option \"%s\"\n", OPTION_MODEL_ID);
        return false;
    }

    if (IOTHUB_CLIENT_OK !=
        IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_KEEP_ALIVE, &iKeepalivePeriodSeconds))
    {
        Log_Debug(MODULE "ERROR: failure setting option \"%s\"\n", OPTION_KEEP_ALIVE);
        return false;
    }

    if (IOTHUB_CLIENT_OK !=
        IoTHubDeviceClient_LL_SetRetryPolicy(hIoTHubClient, IOTHUB_CLIENT_RETRY_EXPONENTIAL_BACKOFF_WITH_JITTER, 240))
    {
        Log_Debug(MODULE "ERROR: failure setting retry option: ...CLIENT_RETRY_EXPONENTIAL_BACKOFF_WITH_JITTER \n");
        return false;
    }


    // Set callbacks for Message, MethodCall and Device Twin features.
    IoTHubDeviceClient_LL_SetMessageCallback(hIoTHubClient, fn_LL_MessageReceivedHandler, NULL);
    IoTHubDeviceClient_LL_SetDeviceMethodCallback(hIoTHubClient, fn_LL_DirectMethodHandler, NULL);
    IoTHubDeviceClient_LL_SetDeviceTwinCallback(hIoTHubClient, fn_LL_DeviceTwinUpdateHandler, NULL);

    // Set callbacks for connection status related events.
    if (IoTHubDeviceClient_LL_SetConnectionStatusCallback(
        hIoTHubClient, hubConnectionStatusCallback, NULL) != IOTHUB_CLIENT_OK) {
        Log_Debug(MODULE "ERROR: failure setting callback\n");
        return false;
    }

    return true;
}


int AzureIoT_SetupDoWorkHandler(int fdEpoll)
{
    // Set up a timer for Azure IoT SDK DoWork execution.
    azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;
    struct timespec tsAzureIoTWorkerInterval = { azureIoTPollPeriodSeconds, 0 };
    fdAzureIoTWorkerTimer =
        CreateTimerFdAndAddToEpoll(fdEpoll, &tsAzureIoTWorkerInterval, &evtdataAzureIoTWorker, EPOLLIN);
    if (fdAzureIoTWorkerTimer < 0) {
        return -1;
    }

    return 0;
}

/*
* @brief    Initializes the Azure IoT Hub SDK.
* 
* @return 'true' if initialization has been successful.
*/
bool AzureIoT_Initialize(void)
{
    if (IoTHub_Init() != 0) {
        Log_Debug(MODULE "ERROR: failed initializing platform.\n");
        return false;
    }

    return true;
}

/*
* @brief    Deinitializes the Azure IoT Hub SDK.
*/
void AzureIoT_Deinitialize(void)
{
    CloseFdAndPrintError(fdAzureIoTWorkerTimer, "IoTWorkerTimer");
    IoTHub_Deinit();
}

/*
* @brief    Destroys the Azure IoT Hub client.
*/
void AzureIoT_DestroyClient(void)
{
    if (hIoTHubClient != NULL) {
        IoTHubDeviceClient_LL_Destroy(hIoTHubClient);
        hIoTHubClient = NULL;
    }
}

/*
* @brief    Sets the DPS Scope ID.
*
* @param    cstrID      The Scope ID string (typically from command line)
*/
void AzureIoT_SetDPSScopeID(const char* cstrId)
{
    if (NULL != cstrId) {
        strncpy(strDPSSopeId, cstrId, sizeof(strDPSSopeId));
        Log_Debug(MODULE "Initializing with DPS Scope Id %s.\n", cstrId);
    }
    else {
        strDPSSopeId[0] = '\0';
        Log_Debug(MODULE "WARNING: DPS Scope Id is missing.\n");
    }
}



