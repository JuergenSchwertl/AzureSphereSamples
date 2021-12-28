#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <time.h>

// Azure IoT SDK
#include <azureiot/iothub_device_client_ll.h>
#include <azureiot/iothub_client_options.h>
#include <azureiot/iothubtransportmqtt.h>
#include <azureiot/iothub.h>
#include <azureiot/iothub_device_client_ll.h>
#include <azureiot/azure_sphere_provisioning.h>
//#include <azure_c_shared_utility/shared_util_options.h>
//#include <azure_prov_client/prov_device_ll_client.h>
//#include <azure_prov_client/iothub_security_factory.h>
//#include <azure_prov_client/prov_security_factory.h>
//#include <azure_prov_client/prov_transport_mqtt_client.h>


#include <applibs/log.h>
#include "azure_iot.h"
#include "azure_iot_json.h"
#include "azure_iot_pnp.h"

#define MODULE "[PnP] "

const char cstrPnpComponentProperty[4] = "__t";
const char cstrPnPComponentValue[2] = "c";


/**
 * @brief hIoTHubClient is defined in azure_iot.c
 * 
 */
extern IOTHUB_DEVICE_CLIENT_LL_HANDLE hIoTHubClient; 
extern char strPnPModelId[MAX_MODELID_LENGTH];

/** 
* @brief    Creates and enqueues a plain text message to be delivered to the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
*           Since standard C doesn't allow lambda functions and Azure IoT PnP requires the "$.sub" property, 
*           message creation and sending is handled here. 
*
* @param    cstrMessage         The payload of the message to send.
* @param    cstrPnPComponent    The component name in the DTDL schema
*/
IOTHUB_CLIENT_RESULT AzureIoT_PnP_SendMessage(const char* cstrMessage, const char * cstrPnPComponent)
{
    IOTHUB_MESSAGE_HANDLE hIoTHubMessage = NULL;
    hIoTHubMessage = AzureIoT_CreateIoTHubMessage(cstrMessage, ContentType.Application_JSON, ContentEncoding.UTF_8);
    if (NULL == hIoTHubMessage)
    {
        return IOTHUB_CLIENT_ERROR;
    }

    //// Add custom properties to message, i.e. for IoT Hub Message Routing
    //(void)IoTHubMessage_SetProperty(messageHandle, "MyProperty", "MyValue");

    if( NULL != cstrPnPComponent ){
        // Add the "$.sub" property that will surface as "dt-subject" on IoT Hub
        // @link https://docs.microsoft.com/en-us/azure/iot-develop/concepts-convention#telemetry
        IoTHubMessage_SetProperty(hIoTHubMessage, "$.sub", cstrPnPComponent);
    }

    return AzureIoT_SendIoTHubMessage(hIoTHubMessage);
}


/** 
*  @brief   Creates and enqueues a json message to be delivered to the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
* 
* @param    jsonPayload         The json payload of the message to sent
* @param    cstrPnPComponent    The component name in the DTDL schema
*/
IOTHUB_CLIENT_RESULT AzureIoT_PnP_SendJsonMessage(JSON_Value* jsonPayload, const char * cstrPnPComponent)
{
    char* pszMessagePayload = 0;
    size_t nMessageSize = 0;
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;
    if (AzureIoTJson_ToPayload(jsonPayload, &pszMessagePayload, &nMessageSize) == IOTHUB_CLIENT_OK) {
        if (pszMessagePayload != NULL) {
            result = AzureIoT_PnP_SendMessage(pszMessagePayload, cstrPnPComponent);
            free(pszMessagePayload);
        }
    }
    return result;
}


/**
*  @brief   With Azure IoT PnP, components need to be published alike
* "componentname" : { 
*    "__t" : "c", 
*    #component properties 
* }
* @param    jsonRoot            NULL to create new root, JSON_Value to attach new component 
* @param    cstrPnPComponent    The component name in the DTDL schema
* @param    jsonPayload         The json payload of the reported properties
* @returns JSON_Value in componentized form
*/
JSON_Value * AzureIoT_PnP_CreateComponentPropertyJson(JSON_Value* jsonRoot, const char * cstrPnPComponent, JSON_Value* jsonProperties)
{
    if( jsonProperties == NULL )
    {
        return NULL;
    }
    JSON_Object *jsonPropertyObject = json_value_get_object( jsonProperties );
    json_object_set_string(jsonPropertyObject, cstrPnpComponentProperty, cstrPnPComponentValue);      // add "__t" : "c",

    if( jsonRoot == NULL )
    {
        jsonRoot = json_value_init_object();
    }
    JSON_Object *jsonComponentObject = json_value_get_object( jsonRoot );
    json_object_set_value( jsonComponentObject, cstrPnPComponent, jsonProperties);

    return jsonRoot;
}

/**
*  @brief   With Azure IoT PnP, components need to be published alike
* "componentname" : { 
*    "__t" : "c", 
*    #component properties 
* }
*
* @param    cstrPnPComponent    The component name in the DTDL schema
* @param    jsonProperties      The json payload of the reported properties
*/
IOTHUB_CLIENT_RESULT AzureIoT_PnP_ReportComponentProperty(const char * cstrPnPComponent, JSON_Value* jsonProperties)
{
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;

    JSON_Value  *jsonRootValue = AzureIoT_PnP_CreateComponentPropertyJson( NULL, cstrPnPComponent, jsonProperties);
    result = AzureIoTJson_TwinReportState( jsonRootValue );
    json_value_free( jsonRootValue );
    return result;
}

/*
* @brief    Sets the Azure IoT PnP Model Id.
*
* @param    cstrModelID  Model Id string
*/
void AzureIoT_PnP_SetModelId(const char* cstrModelId)
{
    if (NULL != cstrModelId) {
        strncpy(strPnPModelId, cstrModelId, sizeof(strPnPModelId));
    }
    else {
        strPnPModelId[0] = '\0';
    }
}

