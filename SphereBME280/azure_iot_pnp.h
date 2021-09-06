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

/* 
* @brief    Creates and enqueues a JSON formatted message string to be delivered to the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
* @note		ContentType not needed as Azure IoT PnP is based on JSON.
* @param    cstrMessage         The payload of the message to send.
* @param    cstrPnPComponent    The component name in the DTDL schema
*/
IOTHUB_CLIENT_RESULT AzureIoT_PnP_SendMessage(const char* cstrMessage, const char * cstrPnPComponent);

/* 
*  @brief   Creates and enqueues a json message to be delivered the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
* 
* @param    jsonPayload     The json payload of the message to send.
* @param    cstrPnPComponent    The component name in the DTDL schema
*/
IOTHUB_CLIENT_RESULT AzureIoT_PnP_SendJsonMessage(JSON_Value* jsonPayload, const char * cstrPnPComponent);


/*
* @brief    Sets the Azure IoT PnP Model Id.
*
* @param    cstrModelID  Model Id string
*/
void AzureIoT_PnP_SetModelId(const char* cstrModelId);


#endif // __AZURE_IOT_PNP_H__