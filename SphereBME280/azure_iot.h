/*
* @file azure_iot.h
* @brief This header defines a sample interface for performing basic operations with an
* Azure IoT Hub using the low-level API layer provided by the IoTHubClient library
* included in the Azure IoT Device SDK for C.
*/
#pragma once
#ifndef __AZURE_IOT_H__
#define __AZURE_IOT_H__

#define MAX_HUB_URI_LENGTH (512)
#define MAX_SCOPEID_LENGTH (32)
#define MAX_MODELID_LENGTH (512)

#include <stdbool.h>
#include <azureiot/iothub_client_core_common.h>
//#include <applibs/networking.h>
#include "parson.h"

/// @brief HTTP_STATUS_CODE enumeration
typedef enum  {
    HTTP_OK = 200,
    HTTP_CREATED,
    HTTP_ACCEPTED,
    HTTP_NON_AUTHORATIVE_INFORMATION,
    HTTP_NO_CONTENT,
    HTTP_RESET_CONTENT,
    HTTP_PARTIAL_CONTENT,
    HTTP_MULTI_STATUS,
    HTTP_BAD_REQUEST = 400,
    HTTP_UNAUTHORIZED,
    HTTP_PAYMENT_REQUIRED,
    HTTP_FORBIDDEN,
    HTTP_NOT_FOUND,
    HTTP_METHOD_NOT_ALLOWED,
    HTTP_NOT_ACCEPTABLE,
    HTTP_PROXY_AUTHORIZATION_REQUIRED,
    HTTP_REQUEST_TIMEOUT,
    HTTP_CONFLICT,
    HTTP_GONE,
    HTTP_LENGTH_REQUIRED,
    HTTP_PRECONDITION_FAILED,
    HTTP_PAYLOAD_TOO_LARGE,
    HTTP_REQUEST_URI_TOO_LONG,
    HTTP_UNSUPPORTED_MEDIA_TYPE,
    HTTP_INTERNAL_SERVER_ERROR = 500,
    HTTP_NOT_IMPLEMENTED,
    HTTP_BAD_GATEWAY,
    HTTP_SERVICE_UNAVAILABLE,
    HTTP_GATEWAY_TIMEOUT
} HTTP_STATUS_CODE ;

/* @brief   Content encoding strings for message properties. Comment/Uncomment as needed. */
typedef const struct content_type_s {
    const char * Application_OctetStream;
    const char * Application_PDF;
    const char * Application_XHTML_XML;
    const char * Application_JSON;
    const char * Application_LD_JSON;
    const char * Application_XML;
    // const char * Application_ZIP;
    // const char * Application_UrlEncoded;

    // const char * Image_GIF;
    // const char * Image_JPEG;
    // const char * Image_PNG;
    // const char * Image_TIFF;

    // const char * Multipart_Mixed;
    // const char * Multipart_Alternative;
    const char * Multipart_FormData;
 
    const char * Text_CSS;
    const char * Text_CSV;
    const char * Text_HTML;
    const char * Text_Plain;
    const char * Text_XML;
} content_type_t;

/// @brief ContentType system property values for messages (URL encoded, "/" is "%2F")
extern content_type_t ContentType;


/* @brief   Content encoding strings for message properties. Comment/Uncomment as needed. */
typedef const struct content_encoding_s {
  const char * UTF_8;
  const char * UTF_16;
//   const char * ASCII;
//   const char * UTF_7;
//   const char * UTF_16BE;
//   const char * UTF_32;
//   const char * Unicode;
} content_encoding_t;

/* @brief   URL-encoded content types for message properties. */
extern content_encoding_t ContentEncoding;

/**
* @brief    Azure IoT Hub payload works on buffers. Strings transmitted are **not**
*           zero terminated.
* @param    cstrPayload     pointer to payload buffer
* @param    nPayloadSize    number of bytes in buffer
* @return                   pointer to heap allocated (zero terminated) string
*/
char * AzureIoT_GetStringFromPayload(const char* cstrPayload, size_t nPayloadSize);


/********************************************
*
*
* Telemetry messages related functions
*
*
*********************************************/

/**
 * @brief creates an IoT Hub message, sets content-type and encoding properties and assigns a message Id.
 *        call @see AzureIoT_SendIoTHubMessage on how to send the message
 * 
 * @param cstrMessage           Message payload text (zero terminated)
 * @param cstrContentType       URL-encoded content type. E.g. "application/json" as "application%2Fjson" 
 * @param cstrContentEncoding   Content encoding header. @link ContentType
 * @return IOTHUB_MESSAGE_HANDLE 
 */
IOTHUB_MESSAGE_HANDLE AzureIoT_CreateIoTHubMessage(const char* cstrMessage, const char *cstrContentType, const char * cstrContentEncoding);

/**
 * @brief Enqueues the IoT Hub message (will be sent to IoT Hub on next DoWork event)
 * The message will be assigned a running number as message id string that needs to
 * be confirmed by IoT Hub @see sendMessageConfirmationCallback()
 * 
 * @param hMessage Message handle
 */
IOTHUB_CLIENT_RESULT AzureIoT_SendIoTHubMessage(IOTHUB_MESSAGE_HANDLE hMessage);


/** 
* @brief    Creates and enqueues a plain text message to be delivered to the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
*
* @param    cstrMessage         The payload of the message to send.
* @param    cstrContentType     The URLEncoded content type (e.g. "application/json" as "application%2fjson")
* @param    cstrContentEncoding The content character encoding
*/
IOTHUB_CLIENT_RESULT AzureIoT_SendMessageWithContentType(const char* cstrMessage, const char *cstrContentType, const char * cstrContentEncoding);


/**
* @brief    Creates and enqueues a plain text message to be delivered to the IoT Hub. The message is not actually
*           sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
* 
* @param    messagePayload  The payload of the message to send.
*/
IOTHUB_CLIENT_RESULT AzureIoT_SendPlainTextMessage(const char *cstrMessage);

/**
* @brief     Type of the function callback invoked whenever a message is received from IoT Hub.
*/
typedef void (*MessageReceivedFnType)(const char *payload);

/**
 * @brief Sets a callback function invoked whenever a message is received from IoT Hub.
 *
 * @param callback The callback function invoked when a message is received
 */
void AzureIoT_SetMessageReceivedCallback(IOTHUB_CLIENT_MESSAGE_CALLBACK_ASYNC callback);

/**
 * @brief Sets a string handler handler invoked whenever a message is received from IoT Hub.
 * 
 * @param callback The callback function invoked when a message is received
 */
void AzureIoT_SetMessageReceivedHandler(MessageReceivedFnType handler);


/**
* @brief    Type of the function callback invoked to report whether a message sent to the IoT Hub has
*           been successfully delivered or not.
*
* @param delivered  'true' when the message has been successfully delivered.
*/
typedef void (*MessageDeliveryConfirmationFnType)(bool delivered);

/**
* @brief    Sets the function to be invoked whenever the message to the Iot Hub has been delivered.
*
* @param    callback    The function pointer to the callback function.
*/
void AzureIoT_SetMessageConfirmationCallback(MessageDeliveryConfirmationFnType callback);



/********************************************
*
*
* Device Twin Update related functions
*
*
*********************************************/

/**
* @brief    Creates and enqueues reported properties state using a (json formatted) string.
*     The report is not actually sent immediately, but it is sent on the next
*     invocation of AzureIoT_DoPeriodicTasks().
*
* @param    pszProperties   Reported Properties as (json formatted) string
* @param    nPropertiesSize Size of properties string
* @return   IOTHUB_CLIENT_RESULT_OK if report successfully enqueued
*/
IOTHUB_CLIENT_RESULT AzureIoT_TwinReportState(const char* pszProperties, size_t nPropertiesSize);

/**
* @brief    Type of the function callback invoked whenever a Device Twin update from the IoT Hub is
*           received.
*
* @param cstrProperties The JSON object containing the Device Twin desired properties.
*/
typedef void (*TwinUpdateFnType)(const char *cstrProperties);

/*
* @brief    Sets the raw callback invoked whenever a Device Twin Update is received.
*
* @param    handler    The handler invoked when a Device Twin update is received
*/
void AzureIoT_SetDeviceTwinUpdateCallback(IOTHUB_CLIENT_DEVICE_TWIN_CALLBACK callback);

/*
* @brief    Sets a string based handler invoked whenever a Device Twin Update is received.
*
* @param    handler    The handler invoked when a Device Twin update is received
*/
void AzureIoT_SetDeviceTwinUpdateHandler(TwinUpdateFnType handler);

/**
* @brief    Type of the function callback invoked to report whether the Device Twin properties
*           to the IoT Hub have been successfully delivered.
*
* @param    httpStatusCode  The HTTP status code returned by the IoT Hub.
*/
typedef void (*DeviceTwinDeliveryConfirmationFnType)(int httpStatusCode);

/**
* @brief    Sets the function to be invoked whenever the Device Twin properties have been delivered
*     to the IoT Hub.
*
*     @param    callback    The function pointer to the callback function.
*/
void AzureIoT_SetDeviceTwinDeliveryConfirmationCallback(
    DeviceTwinDeliveryConfirmationFnType callback);



/********************************************
*
*
* Direct Method related functions
*
*
*********************************************/

/**
* @brief Type of the function callback invoked when a Direct Method call from the IoT Hub is
*    received.
*
* @param  cstrMethodName  The name of the direct method to invoke</param>
* @param  cstrPayload           The payload of the direct method call</param>
* @param  strResponse   The payload of the response provided by the callee. It must be
*                           either NULL or an heap allocated string.
* @return                   The HTTP status code. e.g. 404 for method not found.
*/
typedef int (*DirectMethodCallFnType)(const char *cstrMethodName, 
                                      const char *cstrPayload,
                                      char **strResponse);

/**
* @brief    Sets a raw low-level function to be invoked whenever a Direct Method call from the IoT Hub is
*     received.
* 
* @param    callback    The callback function invoked when a Direct Method call is received.
*           @see DirectMethodCallFnType for more info.
*/
void AzureIoT_SetDirectMethodCallback(IOTHUB_CLIENT_DEVICE_METHOD_CALLBACK_ASYNC callback);

/**
* @brief    Sets a raw low-level function to be invoked whenever a Direct Method call from the IoT Hub is
*     received.
*
* @param    callback    The callback function invoked when a Direct Method call is received.
*           @see DirectMethodCallFnType for more info.
*/
void AzureIoT_SetDirectMethodHandler(DirectMethodCallFnType handler);


/********************************************
*
*
* IoT Hub Connection related functions
*
*
*********************************************/

/**
* @brief    Type of the function callback invoked when the IoT Hub connection status changes.
*/
typedef void (*ConnectionStatusFnType)(bool connected, const char *statusText);

/**
* @brief    Sets the function to be invoked whenever the connection status to the IoT Hub changes.
* 
* @param    callback    The callback function invoked when Azure IoT Hub network connection
*                       status changes.
*/
void AzureIoT_SetConnectionStatusCallback(ConnectionStatusFnType callback);


/**
* @brief    Keeps IoT Hub Client alive by exchanging data with the Azure IoT Hub.
*
* When using low level samples (iothub_ll_*), the IoTHubDeviceClient_LL_DoWork function must be called regularly
* (eg. every 100 milliseconds) for the IoT device client to work properly.
* <a href="https://github.com/Azure/azure-iot-sdk-c/blob/1c1b2c1a3a00bc445165dde44eb3e58ca999ec23/iothub_client/samples/readme.md#note" />
*/
void AzureIoT_DoPeriodicTasks(void);



/********************************************
*
*
* Setup/cleanup/configuration functions
*
*
*********************************************/

/**
* @brief    Sets up the client in order to establish the communication channel to Azure IoT Hub.
*
* The client is created by using the scope id of the Device Provisioning System which
* registers the device with an existing IoT hub and returns the information for
* establishing the connection to that hub.
* The client is setup with the following options:
* - MQTT procotol 'keepalive' value of 20 seconds; when no PINGRESP is received after
* 20 seconds, the connection is believed to be down;
* This function is a no-op when the client has already been set up, i.e. this
* function has already completed successfully.
*
* @return 'true' if the client has been properly set up. 'false' when a fatal error occurred
* while setting up the client.
*/
bool AzureIoT_SetupClient(void);

/**
 * @brief Adds the Azure IoT Do-Work handler
 *
 * @param fdEpoll epoll file descriptor
 * @return 0 on success, <0 for error
 */
int AzureIoT_SetupDoWorkHandler(int fdEpoll);

/**
* @brief    Initializes the Azure IoT Hub SDK.
*
* @return 'true' if initialization has been successful.
*/
bool AzureIoT_Initialize(void);

/**
* @brief    Deinitializes the Azure IoT Hub SDK.
*/
void AzureIoT_Deinitialize(void);

/**
* @brief    Destroys the Azure IoT Hub client.
*/
void AzureIoT_DestroyClient(void);

/**
* @brief    Sets the DPS Scope ID.
*
* @param    cstrID      The Scope ID string (typically from command line)
*/
void AzureIoT_SetDPSScopeID(const char* cstrID);

#endif // __AZURE_IOT_H__