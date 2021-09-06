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
#include <azure_prov_client/iothub_security_factory.h>


#include <applibs/log.h>
#include "epoll_timerfd_utilities.h"
#include "azure_iot.h"
#include "azure_iot_dps.h"

#define MODULE "[IOT] "
#define MSEC_TO_NSEC(ms) (ms*1000*1000)

static int directMethodCallback(
    const char* methodName, 
    const unsigned char* payload, size_t payloadSize,
    unsigned char** response, size_t* responseSize,
    void* userContextCallback);

static void deviceTwinUpdateCallback(
    DEVICE_TWIN_UPDATE_STATE updateState,
    const unsigned char* payLoad, size_t payLoadSize,
    void* userContextCallback);

static void sendMessageConfirmationCallback(
    IOTHUB_CLIENT_CONFIRMATION_RESULT result, 
    void* context);

static IOTHUBMESSAGE_DISPOSITION_RESULT receiveMessageCallback(
    IOTHUB_MESSAGE_HANDLE message,
    void* context);

static void hubConnectionStatusChangedHandler(
    IOTHUB_CLIENT_CONNECTION_STATUS result,
    IOTHUB_CLIENT_CONNECTION_STATUS_REASON reason,
    void* userContextCallback);

/// @brief    List of low level IoT Hub callbacks
iothub_LL_callbacks_t lstIotHubCallbacks = {
    .DeviceTwinUpdateHandler = deviceTwinUpdateCallback,
    .MessageReceivedHandler = receiveMessageCallback,
    .DirectMethodHandler = directMethodCallback,
    .ConnectionStatusChangedHandler = hubConnectionStatusChangedHandler
};

/// @brief    Message Id counter (for system property)
static unsigned int uMessageId = 0;

/// @brief IoT Hub Client Handle is kept in azure_iot_dps.c/_hub.c/_edge.c 
IOTHUB_DEVICE_CLIENT_LL_HANDLE hIoTHubClient = NULL;

/// @brief    List of high level IoT Client callbacks
static iotclient_callbacks_t lstIoTClientCallbacks = {};

/// @brief    re-usable error and warning strings
const char cstrErrorOutOfMemory[] = MODULE  "ERROR: out of memory.\n";
const char cstrWarnNotInitialized[] = MODULE  "WARNING: IoT Hub client not initialized\n";

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

MU_DEFINE_ENUM_STRINGS_WITHOUT_INVALID(IOTHUB_CLIENT_RESULT, IOTHUB_CLIENT_RESULT_VALUES);
MU_DEFINE_ENUM_STRINGS_WITHOUT_INVALID(IOTHUB_CLIENT_CONFIRMATION_RESULT, IOTHUB_CLIENT_CONFIRMATION_RESULT_VALUES);
MU_DEFINE_ENUM_STRINGS_WITHOUT_INVALID(IOTHUB_CLIENT_CONNECTION_STATUS_REASON, IOTHUB_CLIENT_CONNECTION_STATUS_REASON_VALUES);


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
* @brief    Internal Callback function invoked whenever the connection status to IoT Hub changes.
* 
* @param    result              Current authentication status
* @param    reason              result's specific reason
* @param    userContextCallback User specified context
*/
static void hubConnectionStatusChangedHandler(IOTHUB_CLIENT_CONNECTION_STATUS result,
                                        IOTHUB_CLIENT_CONNECTION_STATUS_REASON reason,
                                        void *userContextCallback)
{
    bool bIoTHubAuthenticated = (result == IOTHUB_CLIENT_CONNECTION_AUTHENTICATED);
    const char* reasonString = IOTHUB_CLIENT_CONNECTION_STATUS_REASONStrings(reason);

    if (!bIoTHubAuthenticated) {
        Log_Debug("[IoT] IoT Hub disconnected with %s\n", reasonString);
    } else {
        Log_Debug("[IoT] IoT Hub authenticated (%s).\n", reasonString);
    }

    if (lstIoTClientCallbacks.ConnectionStatusHandler) {
        lstIoTClientCallbacks.ConnectionStatusHandler(bIoTHubAuthenticated, reasonString);
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

    // Set MessageId as running message count value. Keep heap allocated buffer until confirmation!
    #define MESSAGE_ID_SIZE  16
    char *pszMessageId = (char *)malloc(MESSAGE_ID_SIZE);
    snprintf(pszMessageId, MESSAGE_ID_SIZE, "%d", uMessageId++);
    (void)IoTHubMessage_SetMessageId(hMessage, pszMessageId);
    
    IOTHUB_CLIENT_RESULT result = IoTHubDeviceClient_LL_SendEventAsync(hIoTHubClient, hMessage, 
        sendMessageConfirmationCallback, /*&callback_param*/ pszMessageId);

    if ( IOTHUB_CLIENT_OK != result) {
        Log_Debug(MODULE "ERROR: _LL_SendEvent returns %s\n",IOTHUB_CLIENT_RESULTStrings(result));
    }
    else {
        Log_Debug(MODULE "IoTHubClient accepted message id '%s' with payload '%s'\n", 
            IoTHubMessage_GetMessageId(hMessage), IoTHubMessage_GetString(hMessage));
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
static void sendMessageConfirmationCallback(IOTHUB_CLIENT_CONFIRMATION_RESULT result, void* context)
{
    Log_Debug(MODULE "IoTHub confirmed message id '%s' with: %s\n", 
        (char *) context, IOTHUB_CLIENT_CONFIRMATION_RESULTStrings(result));

    if (lstIoTClientCallbacks.MessageDeliveryConfirmationHandler) {
        lstIoTClientCallbacks.MessageDeliveryConfirmationHandler(result == IOTHUB_CLIENT_CONFIRMATION_OK);
    }
    //cleanup heap memory for context
    if (NULL != context){
        free(context);
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

    if (lstIoTClientCallbacks.MessageReceivedHandler != 0) {
        lstIoTClientCallbacks.MessageReceivedHandler( strMessage );
    }
    else {
        Log_Debug( MODULE "WARNING: no MessageReceived handler registered'\n");
    }
    
    free(strMessage);
    
    return IOTHUBMESSAGE_ACCEPTED;
}

void AzureIoT_SetMessageReceivedCallback(IOTHUB_CLIENT_MESSAGE_CALLBACK_ASYNC callback)
{
    lstIotHubCallbacks.MessageReceivedHandler = callback;
    if (NULL != hIoTHubClient)
    {
        IoTHubDeviceClient_LL_SetMessageCallback(hIoTHubClient, lstIotHubCallbacks.MessageReceivedHandler, NULL);
    }
}

void AzureIoT_SetMessageReceivedHandler(MessageReceivedFnType handler)
{
    lstIoTClientCallbacks.MessageReceivedHandler = handler;
    AzureIoT_SetMessageReceivedCallback(&receiveMessageCallback);
}


void AzureIoT_SetMessageConfirmationCallback(MessageDeliveryConfirmationFnType callback)
{
    lstIoTClientCallbacks.MessageDeliveryConfirmationHandler = callback;
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
    if (lstIoTClientCallbacks.DeviceTwinDeliveryConfirmationHandler)
        lstIoTClientCallbacks.DeviceTwinDeliveryConfirmationHandler(iStatus);
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
    if (lstIoTClientCallbacks.DeviceTwinUpdateHandler == NULL) {
        Log_Debug( MODULE "WARNING: Received device twin update but no handler available.");
        return;
    }

    char* strProperties = AzureIoT_GetStringFromPayload(payLoad, payLoadSize);

    // Call the provided string based Twin Device Update handler
    lstIoTClientCallbacks.DeviceTwinUpdateHandler(strProperties);

    free(strProperties);
}

/*
* @brief    Sets the raw callback invoked whenever a Device Twin Update is received.
*
* @param    handler    The handler invoked when a Device Twin update is received
*/
void AzureIoT_SetDeviceTwinUpdateCallback(IOTHUB_CLIENT_DEVICE_TWIN_CALLBACK callback)
{
    lstIotHubCallbacks.DeviceTwinUpdateHandler = callback;
    if (NULL != hIoTHubClient) {
        IoTHubDeviceClient_LL_SetDeviceTwinCallback(hIoTHubClient, lstIotHubCallbacks.DeviceTwinUpdateHandler, NULL);
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
    lstIoTClientCallbacks.DeviceTwinUpdateHandler = handler;
}

/*
* @brief    Sets the callback invoked when the IoT Hub confirms Device Twin Update.
*
* @param    handler    The handler invoked when a Device Twin update is confirmed
*/
void AzureIoT_SetDeviceTwinDeliveryConfirmationCallback(
    DeviceTwinDeliveryConfirmationFnType callback)
{
    lstIoTClientCallbacks.DeviceTwinDeliveryConfirmationHandler = callback;
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
    if (NULL == lstIoTClientCallbacks.DirectMethodHandler) {
        Log_Debug(MODULE "Received direct method %s but no handler found\n", methodName);
        return HTTP_NOT_FOUND;
    }

    const char* strPayload = AzureIoT_GetStringFromPayload(payload, payloadSize);
    char* strResponse = NULL;
    int result = lstIoTClientCallbacks.DirectMethodHandler(methodName, strPayload, &strResponse);
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
    lstIotHubCallbacks.DirectMethodHandler = callback;
    if (NULL != hIoTHubClient) {
        IoTHubDeviceClient_LL_SetDeviceMethodCallback(hIoTHubClient, lstIotHubCallbacks.DirectMethodHandler, NULL);
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
    lstIoTClientCallbacks.DirectMethodHandler = handler;
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
* @brief    Sets the function to be invoked whenever the connection status to the IoT Hub changes.
*
* @param    callback    The callback function invoked when Azure IoT Hub network connection
*                       status changes.
*/
void AzureIoT_SetConnectionStatusCallback(ConnectionStatusFnType callback)
{
    lstIoTClientCallbacks.ConnectionStatusHandler = callback;
}

