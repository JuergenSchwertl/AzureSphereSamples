/*
* @file azure_iot_utilities.h
* @brief This header defines a sample interface for performing basic operations with an
* Azure IoT Hub using the low-level API layer provided by the IoTHubClient library
* included in the Azure IoT Device SDK for C.
*/
#pragma once
#ifndef _AZURE_IOT_JSON_H_
#define _AZURE_IOT_JSON_H_

/*
* @brief    Convert message payload (not NULL terminated) to heap allocated json value
*
* @param    pbPayload       pointer to message pszPayload buffer
* @param    nPayloadSize    size of payload buffer
* @return   The pointer     to the heap allocated json value.
*/
JSON_Value* AzureIoTJson_FromPayload(const unsigned char* pbPayload, size_t nPayloadSize);

/**
* @brief    Convert json value to heap allocated string (including NULL) with responseSize (excluding NULL)
*
* @param    jsonValue           json payload
* @param    ppbPayload          OUT parameter: address of message payload buffer pointer
* @param    pnResponseSize      OUT parameter: address of size variable
* @return   IOTHUB_CLIENT_RESULT IOTHUB_CLIENT_OK on successful serialisation
*/
IOTHUB_CLIENT_RESULT AzureIoTJson_ToPayload(JSON_Value* jsonValue, char** ppbResponse, size_t* pnResponseSize);

/** 
*  @brief   Creates and enqueues a json message to be delivered the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
* 
* @param    jsonPayload     The json payload of the message to send.
* @return   IOTHUB_CLIENT_RESULT IOTHUB_CLIENT_OK on success
*/
IOTHUB_CLIENT_RESULT AzureIoTJson_SendMessage(JSON_Value* jsonPayload);


/**
* @brief    Creates and enqueues IoT Hub Device Twin reported properties. 
* The report is not actually sent immediately, but it is sent on the
* next invocation of AzureIoT_DoPeriodicTasks().
* 
* @param    jsonState   Reported Properties as JSON_Value
* @return   IOTHUB_CLIENT_RESULT_OK if report successfully enqueued
*/
IOTHUB_CLIENT_RESULT AzureIoTJson_TwinReportState(const JSON_Value* jsonState);

/**
* @brief    Type of the function callback invoked whenever a Device Twin update from the IoT Hub is
*           received.
*
* @param desiredProperties The JSON object containing the Device Twin desired properties.
*/
typedef void (*JsonTwinUpdateFnType)(const JSON_Object *desiredProperties);

/**
* @brief    Sets the function callback invoked whenever a Device Twin update from the IoT Hub is
*     received.
* 
* @param    callback    The callback function invoked when a Device Twin update is
*                       received
*/
void AzureIoTJson_SetDeviceTwinUpdateHandler(JsonTwinUpdateFnType handler);


/**
* @brief    Type of the direct method callback invoked.
*
* @param    jsonParameters          The name of the direct method to invoke
* @param    jsonResponseAddress 	OUT parameter. Address of method handler jsonResponse
* @returns      The HTTP status code. e.g. 404 for method not found.
*/
typedef HTTP_STATUS_CODE(*JsonMethodFnType)(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress);


/**
* @brief Type of the direct method registration with MethodName and MethodHandler.
*/
typedef struct MethodRegistrationTag {
    const char* MethodName;
    JsonMethodFnType MethodHandler;
} MethodRegistration;

/**
* @brief    Registers an array of Direct Method handlers. Overwrites @see AzureIoT_SetDirectMethodCallback
*
* @param    methods     List of MethodRegistration entries (ended by NULL,NULL)
*/
void AzureIoTJson_RegisterDirectMethodHandlers(const MethodRegistration* methods);

/**
* @brief    Type of the direct method callback invoked.
*
* @param    jsonParameters          The name of the direct method to invoke
* @param    jsonResponseAddress 	OUT parameter. Address of method handler jsonResponse
* @returns      The HTTP status code. e.g. 404 for method not found.
*/
typedef HTTP_STATUS_CODE(*JsonMessageReceivedFnType)(JSON_Value* jsonValue);

/**
 * @brief sets the Mesage received handler receiving JSON parameters
 * @param handler @seeJsonMessageReceivedFnType handler
 */
void AzureIoTJson_SetMessageReceivedHandler(JsonMessageReceivedFnType handler);


#endif