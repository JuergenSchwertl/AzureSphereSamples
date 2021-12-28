#pragma once
#ifndef __AZURE_IOT_PNP_H__
#define __AZURE_IOT_PNP_H__

/** 
 * @brief
 * Azure IoT PnP specific functions
 * 
 * 
 * 
 */ 

#include "parson.h"

const char cstrPnpComponentProperty[4];
const char cstrPnPComponentValue[2];

/** 
* @brief    Creates and enqueues a JSON formatted message string to be delivered to the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
* @note		ContentType not needed as Azure IoT PnP is based on JSON.
* @param    cstrMessage         The payload of the message to send.
* @param    cstrPnPComponent    The component name in the DTDL schema
*/
IOTHUB_CLIENT_RESULT AzureIoT_PnP_SendMessage(const char* cstrMessage, const char * cstrPnPComponent);

/** 
*  @brief   Creates and enqueues a json message to be delivered the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
* 
* @param    jsonPayload     The json payload of the message to send.
* @param    cstrPnPComponent    The component name in the DTDL schema
*/
IOTHUB_CLIENT_RESULT AzureIoT_PnP_SendJsonMessage(JSON_Value* jsonPayload, const char * cstrPnPComponent);

/**
*  @brief   With Azure IoT PnP, components need to be published alike
* "componentname" : { 
*    "__t" : "c", 
*    #component properties 
* }
* @param    jsonRoot            NULL to create new root, JSON_Value to attach new component 
* @param    cstrPnPComponent    The component name in the DTDL schema
* @param    jsonProperties         The json payload of the reported properties
* @returns JSON_Value in componentized form
*/
JSON_Value * AzureIoT_PnP_CreateComponentPropertyJson(JSON_Value* jsonRoot, const char * cstrPnPComponent, JSON_Value* jsonProperties);


/**
*  @brief   With Azure IoT PnP, components need to be published alike
* "componentname" : { 
*    "__t" : "c", 
*    #component properties 
* }
*
* @param    cstrPnPComponent    The component name in the DTDL schema
* @param    jsonProperties         The json payload of the reported properties
*/
IOTHUB_CLIENT_RESULT AzureIoT_PnP_ReportComponentProperty(const char * cstrPnPComponent, JSON_Value* jsonProperties);

/**
* @brief    Sets the Azure IoT PnP Model Id.
*
* @param    cstrModelID  Model Id string
*/
void AzureIoT_PnP_SetModelId(const char* cstrModelId);


#endif // __AZURE_IOT_PNP_H__