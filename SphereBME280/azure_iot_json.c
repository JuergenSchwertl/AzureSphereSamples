
#include <stdlib.h>
#include <applibs/log.h>

#include "parson.h"
#include "azure_iot.h"
#include "azure_iot_json.h"

#define MODULE "[JSON] "

/// @brief    Pointer to array of MethodRegistration records. Last array record needs to have NULL, NULL as end marker
static MethodRegistration* pRegisteredMethods = NULL;

/// @brief Device twin update handler. See @see JsonTwinUpdateFnType
static JsonTwinUpdateFnType fnJsonTwinUpdateHandler = NULL;

/// @brief message received handler. See @see JsonMessageReceivedFnType
static JsonMessageReceivedFnType fnJsonMessageReceivedHandler = NULL;

/**
* @brief    Internal Callback: invoked when a Device Twin update is received from IoT Hub.
*/
static void jsonDeviceTwinUpdateCallback(DEVICE_TWIN_UPDATE_STATE updateState, const unsigned char *payLoad,
                         size_t payLoadSize, void *userContextCallback)
{
    if (fnJsonTwinUpdateHandler == NULL) {
        Log_Debug( MODULE "WARNING: Received device twin update but no handler available.");
        return;
    }

    JSON_Value* jsonRootValue = AzureIoTJson_FromPayload(payLoad, payLoadSize);
    if (jsonRootValue == NULL) {
        return;
    }

    // The root object should have "{ 'desired' : {...}, 'reported' : {...}}"
    JSON_Object *jsonRootObject = json_value_get_object(jsonRootValue);
    JSON_Object *jsonDesiredProperties = json_object_dotget_object(jsonRootObject, "desired");
    if (jsonDesiredProperties == NULL) {
        jsonDesiredProperties = jsonRootObject;
    }
    // Call the provided Twin Device callback
    fnJsonTwinUpdateHandler(jsonDesiredProperties);

    json_value_free(jsonRootValue);
}

/**
* @brief    Internal Callback: Loops through list and calls method handler with json args
*/
static int jsonDirectMethodCallback(const char* methodName, const unsigned char* payload, size_t payloadSize,
    unsigned char** response, size_t* responseSize,
    void* userContextCallback)
{
    Log_Debug(MODULE "Trying to invoke method %s\n", methodName);

    *responseSize = 0;
    *response = NULL;
    int result = HTTP_NOT_FOUND;

 
    MethodRegistration* pMethod = pRegisteredMethods;
    size_t nSize = strlen(methodName);

    while ((pMethod->MethodName != NULL) && (pMethod->MethodHandler != NULL))
    {
        if (strncmp(methodName, pMethod->MethodName, nSize) == 0) {
            JSON_Value* jsonParameters = AzureIoTJson_FromPayload(payload, payloadSize);
            JSON_Value* jsonResponse = NULL;

            result = pMethod->MethodHandler(jsonParameters, &jsonResponse);
            if (jsonParameters != NULL) {
                json_value_free(jsonParameters);
            }
            if (jsonResponse != NULL) {
                AzureIoTJson_ToPayload(jsonResponse, (char**)response, responseSize);
                Log_Debug(MODULE "Command Response HTTP: %d '%s' (%d bytes)\n", result, *response, *responseSize);
                json_value_free(jsonResponse);
            }
            return result;
        }
        pMethod++;
    }

    Log_Debug(MODULE "WARNING: Method '%s' not found\n", methodName);
    static const char methodNotFound[] = "\"No method found\"";
    *responseSize = strlen(methodNotFound);
    *response = (unsigned char*)malloc(*responseSize);
    if (*response != NULL) {
        strncpy((char*)(*response), methodNotFound, *responseSize);
    }
    else {
        Log_Debug(MODULE "ERROR: Cannot create response message for method call.\n");
        abort();
    }

    return result;
}

/**
* @brief    Internal Callback: converts incoming message to json and calls Message Received handler
*/
static IOTHUBMESSAGE_DISPOSITION_RESULT jsonMessageReceivedCallback(IOTHUB_MESSAGE_HANDLE message,
    void* context)
{
    if (NULL == fnJsonMessageReceivedHandler) {
        Log_Debug(MODULE "WARNING: no MessageReceived handler registered'\n");
    }

    const unsigned char* pBuffer = NULL;
    size_t nPayloadSize = 0;
    IOTHUB_MESSAGE_RESULT result;
    if ((result = IoTHubMessage_GetByteArray(message, &pBuffer, &nPayloadSize)) != IOTHUB_MESSAGE_OK) {
        Log_Debug(MODULE "WARNING: failure performing IoTHubMessage_GetByteArray: %d\n", result);
        return result;
    }

    // 'buffer' is not zero terminated.
    JSON_Value *jsonValue = AzureIoTJson_FromPayload(pBuffer, nPayloadSize);

    fnJsonMessageReceivedHandler(jsonValue);

    json_value_free(jsonValue);

    return IOTHUBMESSAGE_ACCEPTED;
}

JSON_Value* AzureIoTJson_FromPayload(const unsigned char* pbPayload, size_t nPayloadSize)
{
    char* pszPayloadString = malloc(nPayloadSize + 1); // +1 to store null char at the end.
    if (pszPayloadString == NULL) {
        Log_Debug( MODULE "ERROR: Not enough memory\n");
        abort();
    }
    memcpy(pszPayloadString, pbPayload, nPayloadSize);
    pszPayloadString[nPayloadSize] = '\0'; // Null terminated string.

    Log_Debug( MODULE "Payload received %s\n",pszPayloadString);

    JSON_Value* jsonRootValue = json_parse_string(pszPayloadString);
    free(pszPayloadString);

    return jsonRootValue;
}

IOTHUB_CLIENT_RESULT AzureIoTJson_ToPayload(const JSON_Value* jsonValue, char** ppbResponse, size_t* pnResponseSize)
{
    if ((ppbResponse == NULL) || (pnResponseSize == NULL)){
        return IOTHUB_CLIENT_INVALID_ARG;
    }

    char* pszPayload = NULL;
    size_t nPayloadSize = 0;

    if ((jsonValue == NULL) || ((nPayloadSize = json_serialization_size(jsonValue)) == 0)) {
        *ppbResponse = NULL;
        *pnResponseSize = 0;
        return IOTHUB_CLIENT_INVALID_ARG; // nothing to report
    }

    if ((pszPayload = (char*)malloc(nPayloadSize)) == NULL) {
        Log_Debug( MODULE "ERROR: not enough memory.\n");
        abort();
    }

    if (json_serialize_to_buffer(jsonValue, pszPayload, nPayloadSize) == JSONFailure) {
        Log_Debug( MODULE "ERROR: Invalid json\n");
        free(pszPayload);
        return IOTHUB_CLIENT_INVALID_ARG;
    }

    //Log_Debug(MODULE "Payload to transmit %s\n", pszPayload);

    // exclude NULL terminator in responseSize as some json de-serializers don't like trailling NULL character
    *pnResponseSize = nPayloadSize-1; 
    *ppbResponse = (unsigned char *)pszPayload;
    return IOTHUB_CLIENT_OK;
}


IOTHUB_CLIENT_RESULT AzureIoTJson_SendMessage(const JSON_Value* jsonPayload)
{
    char* pszPayload = 0;
    size_t nPayloadSize = 0;
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;
    if (IOTHUB_CLIENT_OK == AzureIoTJson_ToPayload(jsonPayload, &pszPayload, &nPayloadSize) ) {
        result = AzureIoT_SendMessageWithContentType(pszPayload, ContentType.Application_JSON, ContentEncoding.UTF_8);
        free(pszPayload);
    }
    return result;
}


IOTHUB_CLIENT_RESULT AzureIoTJson_TwinReportState(const JSON_Value* jsonState)
{
    char* pszPayload = 0;
    size_t nPayloadSize = 0;
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;
    if (IOTHUB_CLIENT_OK == AzureIoTJson_ToPayload(jsonState, &pszPayload, &nPayloadSize)) {
        result = AzureIoT_TwinReportState(pszPayload, nPayloadSize);
        free(pszPayload);
    }
    return result;
}

void AzureIoTJson_SetDeviceTwinUpdateHandler(JsonTwinUpdateFnType handler)
{
    fnJsonTwinUpdateHandler = handler;
    AzureIoT_SetDeviceTwinUpdateCallback( &jsonDeviceTwinUpdateCallback );
}


void AzureIoTJson_RegisterDirectMethodHandlers(const MethodRegistration* methods)
{
    pRegisteredMethods = (MethodRegistration*)methods;
    AzureIoT_SetDirectMethodCallback( &jsonDirectMethodCallback );
}

void AzureIoTJson_SetMessageReceivedHandler(JsonMessageReceivedFnType handler)
{
    fnJsonMessageReceivedHandler = handler;
    AzureIoT_SetMessageReceivedCallback( &jsonMessageReceivedCallback );
}
