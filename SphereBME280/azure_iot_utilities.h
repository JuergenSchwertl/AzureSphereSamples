/// \file azure_iot_utilities.h
/// \brief This header defines a sample interface for performing basic operations with an
/// Azure IoT Hub using the low-level API layer provided by the IoTHubClient library
/// included in the Azure IoT Device SDK for C.
#pragma once

#include <stdbool.h>
#include <azureiot/iothub_client_core_common.h>
//#include <applibs/networking.h>
#include "parson.h"

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

/// <summary>
/// Content-Type system property values for messages (URL encoded, "/" is "%2F")
/// </summary>
extern content_type_t ContentType;


typedef const struct content_encoding_s {
  const char * UTF_8;
  const char * UTF_16;
//   const char * ASCII;
//   const char * UTF_7;
//   const char * UTF_16BE;
//   const char * UTF_32;
//   const char * Unicode;
} content_encoding_t;

/// <summary>
/// Content encoding system property values for messages (URL encoded, "/" is "%2F")
/// </summary>
extern content_encoding_t ContentEncoding;

/// <summary>
///     Sets up the client in order to establish the communication channel to Azure IoT Hub.
///
///     The client is created by using the IoT Hub connection string that is provisioned
///     on the device or hardcoded into the source. The client is setup with the following
///     options:
///     - MQTT procotol 'keepalive' value of 20 seconds; when no PINGRESP is received after
///       20 seconds, the connection is believed to be down;
/// </summary>
/// <returns>'true' if the client has been properly set up. 'false' when a fatal error occurred
/// while setting up the client.</returns>
/// <remarks>This function is a no-op when the client has already been set up, i.e. this
/// function has already completed successfully.</remarks>
bool AzureIoT_SetupClient(void);

/// <summary>
///     Destroys the Azure IoT Hub client.
/// </summary>
void AzureIoT_DestroyClient(void);

/// <summary>
///     Creates and enqueues reported properties state using a prepared json string.
///     The report is not actually sent immediately, but it is sent on the next 
///     invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
///<param name="pszProperties">Reported Properties in json string notation</param>
///<param name="nPropertiesSize">Size of properties string</param>
///<returns>IOTHUB_CLIENT_RESULT_OK if report successfully enqueued</returns>
IOTHUB_CLIENT_RESULT AzureIoT_TwinReportState( const char* pszProperties, size_t nPropertiesSize);

/// <summary>
///     Creates and enqueues IoT Hub Device Twin reported properties. 
///     The report is not actually sent immediately, but it is sent on the
///     next invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
///<param name="jsonState">Reported Properties as JSON_Value</param>
///<returns>IOTHUB_CLIENT_RESULT_OK if report successfully enqueued</returns>
IOTHUB_CLIENT_RESULT AzureIoT_TwinReportStateJson(const JSON_Value* jsonState);

/// <summary>
///     Creates and enqueues a plain text message to be delivered to the IoT Hub. The message is not actually
///     sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
/// <param name="messagePayload">The payload of the message to send.</param>
void AzureIoT_SendMessageWithContentType(const char* messagePayload, const char* contentType, const char* encoding);

/// <summary>
///     Creates and enqueues a plain text message to be delivered to the IoT Hub. The message is not actually
///     sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
/// <param name="messagePayload">The payload of the message to send.</param>
void AzureIoT_SendTextMessage(const char* messagePayload);

/// <summary>
///     Creates and enqueues a json message to be delivered the IoT Hub. The message is not actually
///     sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
/// <param name="jsonPayload">The json payload of the message to send.</param>
void AzureIoT_SendJsonMessage(JSON_Value* jsonPayload);

/// <summary>
///     Keeps IoT Hub Client alive by exchanging data with the Azure IoT Hub.
/// </summary>
/// <remarks>
///     This function must to be invoked periodically so that the Azure IoT Hub
///     SDK can accomplish its work (e.g. sending messages, invokation of callbacks, reconnection
///     attempts, and so forth).
/// </remarks>
void AzureIoT_DoPeriodicTasks(void);

/// <summary>
///     Type of the function callback invoked whenever a message is received from IoT Hub.
/// </summary>
typedef void (*MessageReceivedFnType)(const char *payload);

/// <summary>
///     Sets a callback function invoked whenever a message is received from IoT Hub.
/// </summary>
/// <param name="callback">The callback function invoked when a message is received</param>
void AzureIoT_SetMessageReceivedCallback(MessageReceivedFnType callback);

/// <summary>
///     Type of the function callback invoked whenever a Device Twin update from the IoT Hub is
///     received.
/// </summary>
/// <param name="handle">The JSON object containing the Device Twin desired properties.</param>
typedef void (*TwinUpdateFnType)(const JSON_Object *desiredProperties);

/// <summary>
///     Sets the Azure IoT PnP Model Id.
/// </summary>
/// <param name="cstrID">Model Id string</param>
void AzureIoT_SetModelId(const char* cstrId);

/// <summary>
///     Sets the DPS Scope ID.
/// </summary>
/// <param name="cstrID">The Scope ID string (typically from command line)</param>
void AzureIoT_SetDPSScopeID(const char* cstrID);

/// <summary>
///     Sets the function callback invoked whenever a Device Twin update from the IoT Hub is
///     received.
/// </summary>
/// <param name="callback">The callback function invoked when a Device Twin update is
/// received</param>
void AzureIoT_SetDeviceTwinUpdateCallback(TwinUpdateFnType callback);

/// <summary>
///     Type of the function callback invoked when a Direct Method call from the IoT Hub is
///     received.
/// </summary>
/// <param name="directMethodName">The name of the direct method to invoke</param>
/// <param name="payload">The payload of the direct method call</param>
/// <param name="payloadSize">The payload size of the direct method call</param>
/// <param name="responsePayload">The payload of the response provided by the callee. It must be
/// either NULL or an heap allocated string.</param>
/// <param name="responsePayloadSize">The size of the response payload provided by the
/// callee.</param>
/// <returns>The HTTP status code. e.g. 404 for method not found.</returns>
typedef int (*DirectMethodCallFnType)(const char *directMethodName, 
                                      const unsigned char *payload, size_t payloadSize, 
                                      unsigned char **responsePayload, size_t *responsePayloadSize);

/// <summary>
///     Sets the function to be invoked whenever a Direct Method call from the IoT Hub is received.
/// </summary>
/// <param name="callback">The callback function invoked when a Direct Method call is
/// received</param>
void AzureIoT_SetDirectMethodCallback(DirectMethodCallFnType callback);


/// <summary>
///     Type of the direct method callback invoked.
/// </summary>
/// <param name="jsonParameters">The name of the direct method to invoke</param>
/// <param name="jsonResponseAddress">OUT parameter. Address of method handler jsonResponse</param>
/// <returns>The HTTP status code. e.g. 404 for method not found.</returns>
typedef HTTP_STATUS_CODE(*MethodFnType)(JSON_Value* jsonParameters, JSON_Value** jsonResponseAddress);


/// <summary>
///     Type of the direct method registration with MethodName and MethodHandler.
/// </summary>
typedef struct MethodRegistrationTag {
    const char* MethodName;
    MethodFnType MethodHandler;
} MethodRegistration;

/// <summary>
///     Registers an array of Direct Method handlers. Superseded by <seealso cref="AzureIoT_SetDirectMethodCallback">AzureIoT_SetDirectMethodCallback</seealso>
/// </summary>
/// <param name="methods">list of MethodRegistration entries (ended by NULL,NULL)</param>
void AzureIoT_RegisterDirectMethodHandlers(const MethodRegistration* methods);


/// <summary>
///     Type of the function callback invoked when the IoT Hub connection status changes.
/// </summary>
typedef void (*ConnectionStatusFnType)(bool connected, const char *statusText);

/// <summary>
///     Sets the function to be invoked whenever the connection status to thye IoT Hub changes.
/// </summary>
/// <param name="callback">The callback function invoked when Azure IoT Hub network connection
/// status changes.</param>
void AzureIoT_SetConnectionStatusCallback(ConnectionStatusFnType callback);

/// <summary>
///     Type of the function callback invoked to report whether a message sent to the IoT Hub has
///     been successfully delivered or not.
/// </summary>
/// <param name="delivered">'true' when the message has been successfully delivered.</param>
typedef void (*MessageDeliveryConfirmationFnType)(bool delivered);

/// <summary>
///     Sets the function to be invoked whenever the message to the Iot Hub has been delivered.
/// </summary>
/// <param name="callback">The function pointer to the callback function.</param>
void AzureIoT_SetMessageConfirmationCallback(MessageDeliveryConfirmationFnType callback);

/// <summary>
///     Type of the function callback invoked to report whether the Device Twin properties
///     to the IoT Hub have been successfully delivered.
/// </summary>
/// <param name="httpStatusCode">The HTTP status code returned by the IoT Hub.</param>
typedef void (*DeviceTwinDeliveryConfirmationFnType)(int httpStatusCode);

/// <summary>
///     Sets the function to be invoked whenever the Device Twin properties have been delivered to
///     the IoT Hub.
/// </summary>
/// <param name="callback">The function pointer to the callback function.</param>
void AzureIoT_SetDeviceTwinDeliveryConfirmationCallback(
    DeviceTwinDeliveryConfirmationFnType callback);

/// <summary>
///     Initializes the Azure IoT Hub SDK.
/// </summary>
/// <return>'true' if initialization has been successful.</param>
bool AzureIoT_Initialize(void);

/// <summary>
///     Deinitializes the Azure IoT Hub SDK.
/// </summary>
void AzureIoT_Deinitialize(void);
