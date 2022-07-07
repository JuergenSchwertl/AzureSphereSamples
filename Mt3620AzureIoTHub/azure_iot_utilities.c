#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <time.h>
#include <azureiot/iothub_device_client_ll.h>
#include <azureiot/iothub_client_options.h>
#include <azureiot/iothubtransportmqtt.h>
#include <azureiot/iothub.h>
#include <azureiot/azure_sphere_provisioning.h>
#include <applibs/log.h>
#include <azure_prov_client/prov_device_ll_client.h>
#include "azure_iot_utilities.h"

// Refer to https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-device-sdk-c-intro for more
// information on Azure IoT SDK for C

//
// String containing the scope id of the Device Provisioning Service
// used to provision the app with the IoT hub hostname and the device id.
//
static char scopeId[16] = ""; // Your DPS Scope ID is filled on app start";

/// <summary>
///     Function invoked to provide the result of the Device Twin reported properties
///     delivery.
/// </summary>
static DeviceTwinDeliveryConfirmationFnType fnDeviceTwinConfirmationHandler = 0;

/// <summary>
///     Pointer to array of MethodRegistration records.
///     Last array record needs to have NULL, NULL as end marker;
/// </summary>
static MethodRegistration* pRegisteredMethods = NULL;

/// <summary>
///     Function invoked whenever a Direct Method call is received from the IoT Hub.
/// </summary>
static DirectMethodCallFnType fnDirectMethodHandler = 0;

/// <summary>
///     Function invoked whenever a Device Twin update is received from the IoT Hub.
/// </summary>
static TwinUpdateFnType fnTwinUpdateHandler = 0;

/// <summary>
///     Function invoked whenever the connection status to the IoT Hub changes.
/// </summary>
static ConnectionStatusFnType fnConnectionStatusChangedHandler = 0;

/// <summary>
///     Function invoked whenever a message is received from the IoT Hub.
/// </summary>
static MessageReceivedFnType fnMessageReceivedHandler = 0;

/// <summary>
///     Function invoked to report the delivery confirmation of a message sent to the IoT
///     Hub.
/// </summary>
static MessageDeliveryConfirmationFnType fnMessageDeliveryConfirmationHandler = 0;

/// <summary>
///     The handle to the IoT Hub client used for communication with the hub.
/// </summary>
static IOTHUB_DEVICE_CLIENT_LL_HANDLE hIoTHubClient = NULL;

/// <summary>
///     The status of the authentication to the hub. When 'false' a
///     connection and authentication to the hub will be attempted.
/// </summary>
static bool bIoTHubAuthenticated = false;

/// <summary>
///     Used to set the keepalive period over MQTT to 20 seconds.
/// </summary>
static int iKeepalivePeriodSeconds = 20;

/// <summary>
///     Message Id system property.
/// </summary>
static unsigned int uMessageId = 0;

/// <summary>
///     Content-Type and Content-Encoding system property values
/// </summary>
const char cstrJsonContentType[] = "application%2Fjson";
const char cstrPlainTextContentType[] = "text%2Fplain";
const char cstrUtf8Encoding[] = "utf-8";

const char cstrErrorOutOfMemory[] = "ERROR: out of memory.\n";
const char cstrWarnNotInitialized[] = "WARNING: IoT Hub client not initialized\n";

//#define BRING_YOUR_OWN_CERTIFICATES

#ifdef BRING_YOUR_OWN_CERTIFICATES
/// <summary>
///     Set of bundle of root certificate authorities.
/// See https://github.com/Azure/azure-iot-sdk-c/blob/main/certs/certs.c for more details
/// </summary>
static const char cstrAzureIoTCertificates[] =
    // DigiCert Global Root G2 
    //     ATTENTION: Azure IoT infrastructure will be starting to use TLS certificates 
    //     rooted in DigiCert Global Root G2 "not earlier than Feb. 15th 2023"
    //     See https://techcommunity.microsoft.com/t5/internet-of-things-blog/azure-iot-tls-critical-changes-are-almost-here-and-why-you/ba-p/2393169
    // 
    "-----BEGIN CERTIFICATE-----\r\n"
    "MIIDjjCCAnagAwIBAgIQAzrx5qcRqaC7KGSxHQn65TANBgkqhkiG9w0BAQsFADBh\r\n"
    "MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3\r\n"
    "d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBH\r\n"
    "MjAeFw0xMzA4MDExMjAwMDBaFw0zODAxMTUxMjAwMDBaMGExCzAJBgNVBAYTAlVT\r\n"
    "MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j\r\n"
    "b20xIDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IEcyMIIBIjANBgkqhkiG\r\n"
    "9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuzfNNNx7a8myaJCtSnX/RrohCgiN9RlUyfuI\r\n"
    "2/Ou8jqJkTx65qsGGmvPrC3oXgkkRLpimn7Wo6h+4FR1IAWsULecYxpsMNzaHxmx\r\n"
    "1x7e/dfgy5SDN67sH0NO3Xss0r0upS/kqbitOtSZpLYl6ZtrAGCSYP9PIUkY92eQ\r\n"
    "q2EGnI/yuum06ZIya7XzV+hdG82MHauVBJVJ8zUtluNJbd134/tJS7SsVQepj5Wz\r\n"
    "tCO7TG1F8PapspUwtP1MVYwnSlcUfIKdzXOS0xZKBgyMUNGPHgm+F6HmIcr9g+UQ\r\n"
    "vIOlCsRnKPZzFBQ9RnbDhxSJITRNrw9FDKZJobq7nMWxM4MphQIDAQABo0IwQDAP\r\n"
    "BgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAdBgNVHQ4EFgQUTiJUIBiV\r\n"
    "5uNu5g/6+rkS7QYXjzkwDQYJKoZIhvcNAQELBQADggEBAGBnKJRvDkhj6zHd6mcY\r\n"
    "1Yl9PMWLSn/pvtsrF9+wX3N3KjITOYFnQoQj8kVnNeyIv/iPsGEMNKSuIEyExtv4\r\n"
    "NeF22d+mQrvHRAiGfzZ0JFrabA0UWTW98kndth/Jsw1HKj2ZL7tcu7XUIOGZX1NG\r\n"
    "Fdtom/DzMNU+MeKNhJ7jitralj41E6Vf8PlwUHBHQRFXGU7Aj64GxJUTFy8bJZ91\r\n"
    "8rGOmaFvE7FBcf6IKshPECBV1/MUReXgRPTqh5Uykw7+U0b6LJ3/iyK5S9kJRaTe\r\n"
    "pLiaWN0bfVKfjllDiIGknibVb63dDcY3fe0Dkhvld1927jyNxF1WW6LZZm6zNTfl\r\n"
    "MrY=\r\n"
    "-----END CERTIFICATE-----\r\n"
    /* Baltimore CyberTrust Root : 
        ATTENTION: will no longer be used by Azure IoT Hub TLS frontends some time after Feb 15th 2023.
        See also: https://docs.microsoft.com/en-us/azure/security/fundamentals/tls-certificate-changes 
    */
    "-----BEGIN CERTIFICATE-----\r\n"
    "MIIDdzCCAl+gAwIBAgIEAgAAuTANBgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJJ\r\n"
    "RTESMBAGA1UEChMJQmFsdGltb3JlMRMwEQYDVQQLEwpDeWJlclRydXN0MSIwIAYD\r\n"
    "VQQDExlCYWx0aW1vcmUgQ3liZXJUcnVzdCBSb290MB4XDTAwMDUxMjE4NDYwMFoX\r\n"
    "DTI1MDUxMjIzNTkwMFowWjELMAkGA1UEBhMCSUUxEjAQBgNVBAoTCUJhbHRpbW9y\r\n"
    "ZTETMBEGA1UECxMKQ3liZXJUcnVzdDEiMCAGA1UEAxMZQmFsdGltb3JlIEN5YmVy\r\n"
    "VHJ1c3QgUm9vdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKMEuyKr\r\n"
    "mD1X6CZymrV51Cni4eiVgLGw41uOKymaZN+hXe2wCQVt2yguzmKiYv60iNoS6zjr\r\n"
    "IZ3AQSsBUnuId9Mcj8e6uYi1agnnc+gRQKfRzMpijS3ljwumUNKoUMMo6vWrJYeK\r\n"
    "mpYcqWe4PwzV9/lSEy/CG9VwcPCPwBLKBsua4dnKM3p31vjsufFoREJIE9LAwqSu\r\n"
    "XmD+tqYF/LTdB1kC1FkYmGP1pWPgkAx9XbIGevOF6uvUA65ehD5f/xXtabz5OTZy\r\n"
    "dc93Uk3zyZAsuT3lySNTPx8kmCFcB5kpvcY67Oduhjprl3RjM71oGDHweI12v/ye\r\n"
    "jl0qhqdNkNwnGjkCAwEAAaNFMEMwHQYDVR0OBBYEFOWdWTCCR1jMrPoIVDaGezq1\r\n"
    "BE3wMBIGA1UdEwEB/wQIMAYBAf8CAQMwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3\r\n"
    "DQEBBQUAA4IBAQCFDF2O5G9RaEIFoN27TyclhAO992T9Ldcw46QQF+vaKSm2eT92\r\n"
    "9hkTI7gQCvlYpNRhcL0EYWoSihfVCr3FvDB81ukMJY2GQE/szKN+OMY3EU/t3Wgx\r\n"
    "jkzSswF07r51XgdIGn9w/xZchMB5hbgF/X++ZRGjD8ACtPhSNzkE1akxehi/oCr0\r\n"
    "Epn3o0WC4zxe9Z2etciefC7IpJ5OCBRLbf1wbWsaY71k5h+3zvDyny67G7fyUIhz\r\n"
    "ksLi4xaNmjICq44Y3ekQEe5+NauQrz4wlHrQMz2nZQ/1/I6eYs9HRCwBXbsdtTLS\r\n"
    "R9I4LtD+gdwyah617jzV/OeBHRnDJELqYzmp\r\n"
    "-----END CERTIFICATE-----\r\n"

    /* Microsoft RSA Root Certificate Authority 2017 */
    "-----BEGIN CERTIFICATE-----\r\n"
    "MIIFqDCCA5CgAwIBAgIQHtOXCV/YtLNHcB6qvn9FszANBgkqhkiG9w0BAQwFADBl\r\n"
    "MQswCQYDVQQGEwJVUzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTYw\r\n"
    "NAYDVQQDEy1NaWNyb3NvZnQgUlNBIFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5\r\n"
    "IDIwMTcwHhcNMTkxMjE4MjI1MTIyWhcNNDIwNzE4MjMwMDIzWjBlMQswCQYDVQQG\r\n"
    "EwJVUzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTYwNAYDVQQDEy1N\r\n"
    "aWNyb3NvZnQgUlNBIFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTcwggIi\r\n"
    "MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDKW76UM4wplZEWCpW9R2LBifOZ\r\n"
    "Nt9GkMml7Xhqb0eRaPgnZ1AzHaGm++DlQ6OEAlcBXZxIQIJTELy/xztokLaCLeX0\r\n"
    "ZdDMbRnMlfl7rEqUrQ7eS0MdhweSE5CAg2Q1OQT85elss7YfUJQ4ZVBcF0a5toW1\r\n"
    "HLUX6NZFndiyJrDKxHBKrmCk3bPZ7Pw71VdyvD/IybLeS2v4I2wDwAW9lcfNcztm\r\n"
    "gGTjGqwu+UcF8ga2m3P1eDNbx6H7JyqhtJqRjJHTOoI+dkC0zVJhUXAoP8XFWvLJ\r\n"
    "jEm7FFtNyP9nTUwSlq31/niol4fX/V4ggNyhSyL71Imtus5Hl0dVe49FyGcohJUc\r\n"
    "aDDv70ngNXtk55iwlNpNhTs+VcQor1fznhPbRiefHqJeRIOkpcrVE7NLP8TjwuaG\r\n"
    "YaRSMLl6IE9vDzhTyzMMEyuP1pq9KsgtsRx9S1HKR9FIJ3Jdh+vVReZIZZ2vUpC6\r\n"
    "W6IYZVcSn2i51BVrlMRpIpj0M+Dt+VGOQVDJNE92kKz8OMHY4Xu54+OU4UZpyw4K\r\n"
    "UGsTuqwPN1q3ErWQgR5WrlcihtnJ0tHXUeOrO8ZV/R4O03QK0dqq6mm4lyiPSMQH\r\n"
    "+FJDOvTKVTUssKZqwJz58oHhEmrARdlns87/I6KJClTUFLkqqNfs+avNJVgyeY+Q\r\n"
    "W5g5xAgGwax/Dj0ApQIDAQABo1QwUjAOBgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/\r\n"
    "BAUwAwEB/zAdBgNVHQ4EFgQUCctZf4aycI8awznjwNnpv7tNsiMwEAYJKwYBBAGC\r\n"
    "NxUBBAMCAQAwDQYJKoZIhvcNAQEMBQADggIBAKyvPl3CEZaJjqPnktaXFbgToqZC\r\n"
    "LgLNFgVZJ8og6Lq46BrsTaiXVq5lQ7GPAJtSzVXNUzltYkyLDVt8LkS/gxCP81OC\r\n"
    "gMNPOsduET/m4xaRhPtthH80dK2Jp86519efhGSSvpWhrQlTM93uCupKUY5vVau6\r\n"
    "tZRGrox/2KJQJWVggEbbMwSubLWYdFQl3JPk+ONVFT24bcMKpBLBaYVu32TxU5nh\r\n"
    "SnUgnZUP5NbcA/FZGOhHibJXWpS2qdgXKxdJ5XbLwVaZOjex/2kskZGT4d9Mozd2\r\n"
    "TaGf+G0eHdP67Pv0RR0Tbc/3WeUiJ3IrhvNXuzDtJE3cfVa7o7P4NHmJweDyAmH3\r\n"
    "pvwPuxwXC65B2Xy9J6P9LjrRk5Sxcx0ki69bIImtt2dmefU6xqaWM/5TkshGsRGR\r\n"
    "xpl/j8nWZjEgQRCHLQzWwa80mMpkg/sTV9HB8Dx6jKXB/ZUhoHHBk2dxEuqPiApp\r\n"
    "GWSZI1b7rCoucL5mxAyE7+WL85MB+GqQk2dLsmijtWKP6T+MejteD+eMuMZ87zf9\r\n"
    "dOLITzNy4ZQ5bb0Sr74MTnB8G2+NszKTc0QWbej09+CVgI+WXTik9KveCjCHk9hN\r\n"
    "AHFiRSdLOkKEW39lt2c0Ui2cFmuqqNh7o0JMcccMyj6D5KbvtwEwXlGjefVwaaZB\r\n"
    "RA+GsCyRxj3qrg+E\r\n"
    "-----END CERTIFICATE-----\r\n";
#endif


// Forward declarations.
static void sendMessageCallback(IOTHUB_CLIENT_CONFIRMATION_RESULT result, void *context);
static IOTHUBMESSAGE_DISPOSITION_RESULT receiveMessageCallback(IOTHUB_MESSAGE_HANDLE message,
                                                               void *context);
static void twinCallback(DEVICE_TWIN_UPDATE_STATE updateState, const unsigned char *payLoad,
                         size_t size, void *userContextCallback);
static int directMethodCallback(const char *methodName, const unsigned char *payload, size_t size,
                                unsigned char **response, size_t *response_size,
                                void *userContextCallback);
static void hubConnectionStatusCallback(IOTHUB_CLIENT_CONNECTION_STATUS result,
                                        IOTHUB_CLIENT_CONNECTION_STATUS_REASON reason,
                                        void *userContextCallback);

/// <summary>
///     Log a message related to the Azure IoT Hub client with
///     prefix [Azure IoT]:"
/// </summary>
/// <param name="message">The format string containing the error to output along with placeholders</param>
/// <param name="...">The list of arguments to populate the format string placeholders</param>
void LogMessage(const char* message, ...)
{
    va_list args;
    va_start(args, message);
    Log_Debug("[Azure IoT] ");
    Log_DebugVarArgs(message, args);
    va_end(args);
}

/// <summary>
///     Converts the IoT Hub connection status reason to a string.
/// </summary>
/// <param name="reason">connection change status reason</param>
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

/// <summary>
///     Converts AZURE_SPHERE_PROV_RETURN_VALUE to a string.
/// </summary>
/// <param name="provisioningResult">result of provisioning phase</param>
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

///<summary>
/// Convert message payload (not NULL terminated) to heap allocated json value
///</summary>
/// <param name="pbPayload">pointer to message pszPayload buffer</param>
/// <param name="nPayloadSize">size of payload buffer</param>
/// <returns>The pointer to the heap allocated json value.</returns>
static JSON_Value* getJsonFromPayload(const unsigned char* pbPayload, size_t nPayloadSize)
{
    char* pszPayloadString = malloc(nPayloadSize + 1); // +1 to store null char at the end.
    if (pszPayloadString == NULL) {
        LogMessage("ERROR: Not enough memory");
        abort();
    }
    memcpy(pszPayloadString, pbPayload, nPayloadSize);
    pszPayloadString[nPayloadSize] = '\0'; // Null terminated string.

    Log_Debug("Payload received %s\n",pszPayloadString);

    JSON_Value* jsonRootValue = json_parse_string(pszPayloadString);
    free(pszPayloadString);

    return jsonRootValue;
}

///<summary>
/// Convert json value to heap allocated string (including NULL) with responseSize (excluding NULL)
///</summary>
/// <param name="jsonValue">json payload</param>
/// <param name="ppbPayload">OUT parameter: address of message payload buffer pointer</param>
/// <param name="pnResponseSize">OUT parameter: address of size variable</param>
/// <returns>IOTHUB_CLIENT_OK on successful serialisation</returns>
static IOTHUB_CLIENT_RESULT setPayloadFromJson(JSON_Value* jsonValue, char** ppbResponse, size_t* pnResponseSize)
{
    if ((ppbResponse == NULL) || (pnResponseSize == NULL)){
        return IOTHUB_CLIENT_INVALID_ARG;
    }

    char* pszPayload = NULL;
    size_t nPayloadSize = 0;

    if ((jsonValue == NULL) || ((nPayloadSize = json_serialization_size(jsonValue)) == 0)) {
        *ppbResponse = NULL;
        *pnResponseSize = 0;
        return IOTHUB_CLIENT_OK; // nothing to report
    }

    if ((pszPayload = (char*)malloc(nPayloadSize)) == NULL) {
        LogMessage("ERROR: not enough memory.\n");
        abort();
    }

    if (json_serialize_to_buffer(jsonValue, pszPayload, nPayloadSize) == JSONFailure) {
        LogMessage("ERROR: Invalid json\n");
        return IOTHUB_CLIENT_INVALID_ARG;
    }

    // exclude NULL terminator in responseSize as some json de-serializers don't like trailling NULL character
    *pnResponseSize = nPayloadSize-1; 
    *ppbResponse = (unsigned char *)pszPayload;
    return IOTHUB_CLIENT_OK;
}

/// <summary>
///     Sets up the client in order to establish the communication channel to Azure IoT Hub.
///
///     The client is created by using the scope id of the Device Provisioning System which
///     registers the device with an existing IoT hub and returns the information for
///     establishing the connection to that hub.
///     The client is setup with the following options:
///     - MQTT procotol 'keepalive' value of 20 seconds; when no PINGRESP is received after
///       20 seconds, the connection is believed to be down;
/// </summary>
/// <returns>'true' if the client has been properly set up. 'false' when a fatal error occurred
/// while setting up the client.</returns>
/// <remarks>This function is a no-op when the client has already been set up, i.e. this
/// function has already completed successfully.</remarks>
bool AzureIoT_SetupClient(void)
{
    if (bIoTHubAuthenticated && (hIoTHubClient != NULL))
        return true;

    if (hIoTHubClient != NULL)
        IoTHubDeviceClient_LL_Destroy(hIoTHubClient);

    AZURE_SPHERE_PROV_RETURN_VALUE provResult =
        IoTHubDeviceClient_LL_CreateWithAzureSphereDeviceAuthProvisioning(scopeId, 10000,
                                                                          &hIoTHubClient);
    LogMessage("IoTHubDeviceClient_CreateWithAzureSphereDeviceAuthProvisioning returned '%s'.\n",
               getAzureSphereProvisioningResultString(provResult));

    if (provResult.result != AZURE_SPHERE_PROV_RESULT_OK) {
        return false;
    }

    // Provisioning and authentication succeeded.
    bIoTHubAuthenticated = true;

    if (hIoTHubClient == NULL) {
        return false;
    }

#ifdef BRING_YOUR_OWN_CERTIFICATES
    if (IoTHubDeviceClient_LL_SetOption(hIoTHubClient, "TrustedCerts",
                                        cstrAzureIoTCertificates) != IOTHUB_CLIENT_OK) {
        LogMessage("ERROR: failure to set option \"TrustedCerts\"\n");
        return false;
    }
#endif

    if (IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_KEEP_ALIVE,
                                        &iKeepalivePeriodSeconds) != IOTHUB_CLIENT_OK) {
        LogMessage("ERROR: failure setting option \"%s\"\n", OPTION_KEEP_ALIVE);
        return false;
    }

     // Set callbacks for Message, MethodCall and Device Twin features.
    IoTHubDeviceClient_LL_SetMessageCallback(hIoTHubClient, receiveMessageCallback, NULL);
    IoTHubDeviceClient_LL_SetDeviceMethodCallback(hIoTHubClient, directMethodCallback, NULL);
    IoTHubDeviceClient_LL_SetDeviceTwinCallback(hIoTHubClient, twinCallback, NULL);

    // Set callbacks for connection status related events.
    if (IoTHubDeviceClient_LL_SetConnectionStatusCallback(
            hIoTHubClient, hubConnectionStatusCallback, NULL) != IOTHUB_CLIENT_OK) {
        LogMessage("ERROR: failure setting callback\n");
        return false;
    }

    return true;
}


/// <summary>
///     Sets the DPS Scope ID.
/// </summary>
/// <param name="cstrID">The Scope ID string (typically from command line)</param>
void AzureIoT_SetDPSScopeID(const char* cstrID)
{
	strncpy(scopeId, cstrID, sizeof(scopeId));
}


/// <summary>
///     Destroys the Azure IoT Hub client.
/// </summary>
void AzureIoT_DestroyClient(void)
{
    if (hIoTHubClient != NULL) {
        IoTHubDeviceClient_LL_Destroy(hIoTHubClient);
        hIoTHubClient = NULL;
    }
}

/// <summary>
///     Periodically outputs a provided format string with a variable number of arguments.
/// </summary>
/// <param name="lastInvokedTime">Pointer where to store the 'last time this function has been
/// invoked' information</param>
/// <param name="periodInSeconds">The desired period of the output</param>
/// <param name="format">The format string</param>
static void PeriodicLogVarArgs(time_t *lastInvokedTime, time_t periodInSeconds, const char *format,
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
        Log_Debug("[Azure IoT] ");
        Log_DebugVarArgs(format, args);
        va_end(args);
        *lastInvokedTime = ts.tv_sec;
    }
}

/// <summary>
///     Keeps IoT Hub Client alive by exchanging data with the Azure IoT Hub.
/// </summary>
/// <remarks>
///     This function must to be invoked periodically so that the Azure IoT Hub
///     SDK can accomplish its work (e.g. sending messages, invocation of callbacks, reconnection
///     attempts, and so forth).
/// </remarks>
void AzureIoT_DoPeriodicTasks(void)
{
    static time_t lastTimeLogged = 0;

    if (bIoTHubAuthenticated) {
        PeriodicLogVarArgs(&lastTimeLogged, 5, "INFO: %s calls in progress...\n", __func__);

        // DoWork - send some of the buffered events to the IoT Hub, and receive some of the
        // buffered events from the IoT Hub.
        IoTHubDeviceClient_LL_DoWork(hIoTHubClient);
    }
}

/// <summary>
///     Creates and enqueues a plain text message to be delivered to the IoT Hub. The message is not actually
///     sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
/// <param name="messagePayload">The payload of the message to send.</param>
void AzureIoT_SendMessageWithContentType(const char* messagePayload, const char *contentType, const char * encoding)
{
    if (hIoTHubClient == NULL) {
        LogMessage(cstrWarnNotInitialized);
        return;
    }

    IOTHUB_MESSAGE_HANDLE messageHandle = IoTHubMessage_CreateFromString(messagePayload);
    if (messageHandle == 0) {
        LogMessage("WARNING: unable to create a new IoTHubMessage\n");
        return;
    }

    //// Set Message properties: for MessageId, use a running message count value.
    char szMessageId[16];
    snprintf(szMessageId, sizeof(szMessageId), "%d", uMessageId++);
    (void)IoTHubMessage_SetMessageId(messageHandle, szMessageId);

    //(void)IoTHubMessage_SetCorrelationId(messageHandle, "CORE_ID");


    (void)IoTHubMessage_SetContentTypeSystemProperty(messageHandle, contentType);
    (void)IoTHubMessage_SetContentEncodingSystemProperty(messageHandle, encoding);

    //// Add custom properties to message, i.e. for IoT Hub Message Routing
    //(void)IoTHubMessage_SetProperty(messageHandle, "property_key", "property_value");


    if (IoTHubDeviceClient_LL_SendEventAsync(hIoTHubClient, messageHandle, sendMessageCallback,
        /*&callback_param*/ 0) != IOTHUB_CLIENT_OK) {
        LogMessage("WARNING: failed to hand over the message to IoTHubClient\n");
    }
    else {
        LogMessage("INFO: IoTHubClient accepted the message for delivery\n");
    }

    IoTHubMessage_Destroy(messageHandle);
}


/// <summary>
///     Creates and enqueues a plain text message to be delivered to the IoT Hub. The message is not actually
///     sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
/// <param name="messagePayload">The payload of the message to send.</param>
void AzureIoT_SendTextMessage(const char *messagePayload)
{
    AzureIoT_SendMessageWithContentType(messagePayload, cstrPlainTextContentType, cstrUtf8Encoding);
}


/// <summary>
///     Creates and enqueues a json message to be delivered the IoT Hub. The message is not actually
///     sent immediately, but it is sent on the next invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
/// <param name="jsonPayload">The json payload of the message to send.</param>
void AzureIoT_SendJsonMessage(JSON_Value* jsonPayload)
{
    char* pszMessagePayload = 0;
    size_t nMessageSize = 0;

    if (setPayloadFromJson(jsonPayload, &pszMessagePayload, &nMessageSize) == IOTHUB_CLIENT_OK) {
        if (pszMessagePayload != NULL) {
            AzureIoT_SendMessageWithContentType(pszMessagePayload, cstrJsonContentType, cstrUtf8Encoding);
            free(pszMessagePayload);
        }
    }
}


/// <summary>
///     Sets the function to be invoked whenever the Device Twin properties have been delivered
///     to the IoT Hub.
/// </summary>
/// <param name="callback">The function pointer to the callback function.</param>
void AzureIoT_SetDeviceTwinDeliveryConfirmationCallback(
    DeviceTwinDeliveryConfirmationFnType callback)
{
    fnDeviceTwinConfirmationHandler = callback;
}

/// <summary>
///     Callback invoked when the Device Twin reported properties are accepted by IoT Hub.
/// </summary>
static void reportStatusCallback(int result, void *context)
{
    LogMessage("INFO: Device Twin reported properties update result: HTTP status code %d\n",
               result);
    if (fnDeviceTwinConfirmationHandler)
        fnDeviceTwinConfirmationHandler(result);
}

/// <summary>
///     Creates and enqueues reported properties state using a prepared json string.
///     The report is not actually sent immediately, but it is sent on the next 
///     invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
///<param name="pszProperties">Reported Properties in json string notation</param>
///<param name="nPropertiesSize">Size of properties string</param>
///<returns>IOTHUB_CLIENT_RESULT_OK if report successfully enqueued</returns>
IOTHUB_CLIENT_RESULT AzureIoT_TwinReportState(
    const char* pszProperties,
    size_t nPropertiesSize)
{
    if (hIoTHubClient == NULL) {
        LogMessage("ERROR: client not initialized\n");
        return IOTHUB_CLIENT_ERROR;
    }

    if (pszProperties == NULL || nPropertiesSize == 0)
    {   // nothing to report
        return IOTHUB_CLIENT_OK;
    }

    IOTHUB_CLIENT_RESULT result = IoTHubDeviceClient_LL_SendReportedState(hIoTHubClient, 
            pszProperties, nPropertiesSize, reportStatusCallback, 0);
    
    if (result != IOTHUB_CLIENT_OK) {
        LogMessage("ERROR: IOTHUB_CLIENT_RESULT %d with properties %s\n", result, pszProperties);
    }
    else {
        LogMessage("INFO: reported properties %s\n", pszProperties);
    }

    return result;
}


/// <summary>
///     Creates and enqueues IoT Hub Device Twin reported properties. 
///     The report is not actually sent immediately, but it is sent on the
///     next invocation of AzureIoT_DoPeriodicTasks().
/// </summary>
///<param name="jsonState">Reported Properties as JSON_Value</param>
///<returns>IOTHUB_CLIENT_RESULT_OK if report successfully enqueued</returns>
IOTHUB_CLIENT_RESULT AzureIoT_TwinReportStateJson(const JSON_Value* jsonState)
{
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;
    size_t nBufSize = 0;
    unsigned char* pBuf = NULL;

    if (hIoTHubClient == NULL) {
        LogMessage("ERROR: client not initialized\n");
        return IOTHUB_CLIENT_ERROR;
    }

    if ((jsonState == NULL) || ((nBufSize = json_serialization_size(jsonState)) == 0)) {
        return IOTHUB_CLIENT_OK; // nothing to report
    }

    if ((pBuf = (char*)malloc(nBufSize)) == NULL) {
        LogMessage("ERROR: not enough memory.\n");
        abort();
    }

    if (json_serialize_to_buffer(jsonState, pBuf, nBufSize) == JSONFailure) {
        LogMessage("ERROR: Invalid json\n");
        result = IOTHUB_CLIENT_INVALID_ARG;
    } else {
        result = AzureIoT_TwinReportState(pBuf, nBufSize);
    }
    free( pBuf );
    return result;
}


/// <summary>
///     Sets a callback function invoked whenever a message is received from IoT Hub.
/// </summary>
/// <param name="callback">The callback function invoked when a message is received</param>
void AzureIoT_SetMessageReceivedCallback(MessageReceivedFnType callback)
{
    fnMessageReceivedHandler = callback;
}

/// <summary>
///     Sets the function to be invoked whenever the message to the Iot Hub has been delivered.
/// </summary>
/// <param name="callback">The function pointer to the callback function.</param>
void AzureIoT_SetMessageConfirmationCallback(MessageDeliveryConfirmationFnType callback)
{
    fnMessageDeliveryConfirmationHandler = callback;
}

/// <summary>
///     Function invoked when the message delivery confirmation is being reported.
/// </summary>
/// <param name="result">Message delivery status</param>
/// <param name="context">User specified context</param>
static void sendMessageCallback(IOTHUB_CLIENT_CONFIRMATION_RESULT result, void *context)
{
    
    LogMessage("INFO: Message received by IoT Hub. Result is: %d\n", result);
    if (fnMessageDeliveryConfirmationHandler)
        fnMessageDeliveryConfirmationHandler(result == IOTHUB_CLIENT_CONFIRMATION_OK);
}

/// <summary>
///     Callback function invoked when a message is received from IoT Hub.
/// </summary>
/// <param name="message">The handle of the received message</param>
/// <param name="context">The user context specified at
/// IoTHubDeviceClient_LL_SetMessageCallback() invocation time</param>
/// <returns>Return value to indicates the message procession status (i.e. accepted, rejected,
/// abandoned)</returns>
static IOTHUBMESSAGE_DISPOSITION_RESULT receiveMessageCallback(IOTHUB_MESSAGE_HANDLE message,
                                                               void *context)
{
    const unsigned char *buffer = NULL;
    size_t size = 0;
    IOTHUB_MESSAGE_RESULT result;
    if ((result = IoTHubMessage_GetByteArray(message, &buffer, &size)) != IOTHUB_MESSAGE_OK) {
        LogMessage("WARNING: failure performing IoTHubMessage_GetByteArray: %d\n", result);
        return result;
    }

    // 'buffer' is not zero terminated.
    unsigned char *str_msg = (unsigned char *)malloc(size + 1);
    if (str_msg == NULL) {
        LogMessage("ERROR: could not allocate buffer for incoming message\n");
        abort();
    }
    memcpy(str_msg, buffer, size);
    str_msg[size] = '\0';

    if (fnMessageReceivedHandler != 0) {
        fnMessageReceivedHandler(str_msg);
    } else {
        LogMessage("WARNING: no user callback set up for event 'message received from IoT Hub'\n");
    }

    LogMessage("INFO: Received message '%s' from IoT Hub\n", str_msg);
    free(str_msg);

    return IOTHUBMESSAGE_ACCEPTED;
}

/// <summary>
///     Sets a raw low-level function to be invoked whenever a Direct Method call from the IoT Hub is
///     received.
/// </summary>
/// <param name="callback">The callback function invoked when a Direct Method call is received</param>
void AzureIoT_SetDirectMethodCallback(DirectMethodCallFnType callback)
{
    fnDirectMethodHandler = callback;
}


/// <summary>
///     Registers an array of Direct Method handlers. Superseded by <seealso cref="AzureIoT_SetDirectMethodCallback">AzureIoT_SetDirectMethodCallback</seealso>
/// </summary>
/// <param name="methods">list of MethodRegistration entries (ended by NULL,NULL)</param>
void AzureIoT_RegisterDirectMethodHandlers(const MethodRegistration * methods)
{
    pRegisteredMethods = (MethodRegistration*) methods;
}


/// <summary>
///     Sets the function callback invoked whenever a Device Twin update from the IoT Hub is
///     received.
/// </summary>
/// <param name="callback">The callback function invoked when a Device Twin update is
/// received</param>
void AzureIoT_SetDeviceTwinUpdateCallback(TwinUpdateFnType callback)
{
    fnTwinUpdateHandler = callback;
}

/// <summary>
///     Callback when direct method is called.
/// </summary>
static int directMethodCallback(const char *methodName, const unsigned char *payload, size_t payloadSize,
                                unsigned char **response, size_t *responseSize,
                                void *userContextCallback)
{
    LogMessage("INFO: Trying to invoke method %s\n", methodName);

    *responseSize = 0;
    *response = NULL;
    int result = HTTP_NOT_FOUND;

    // if raw directMethodCallback is registered, use this
    if (fnDirectMethodHandler != NULL) {
        return fnDirectMethodHandler(methodName, payload, payloadSize, response, responseSize);
    } 
    
    // if method handlers are registered, loop through list of registered methods
    if ((pRegisteredMethods != NULL))
    {
        MethodRegistration* pMethod = pRegisteredMethods;
        size_t nSize = strlen(methodName);

        while ((pMethod->MethodName != NULL) && (pMethod->MethodHandler != NULL))
        {
            if (strncmp(methodName, pMethod->MethodName, nSize) == 0) {
                JSON_Value* jsonParameters = getJsonFromPayload(payload, payloadSize);
                JSON_Value* jsonResponse = NULL;

                result = pMethod->MethodHandler(jsonParameters, &jsonResponse);
                if (jsonParameters != NULL) {
                    json_value_free(jsonParameters);
                }
                if (jsonResponse != NULL) {
                    setPayloadFromJson(jsonResponse, (char **)response, responseSize);
                    LogMessage("Command Response HTTP: %d '%s' (%d bytes)\n", result, *response, *responseSize);
                    json_value_free(jsonResponse);
                }
                return result;
            }
            pMethod++;
        }
    }

    LogMessage("INFO: Method '%s' not found\n", methodName);
    static const char methodNotFound[] = "\"No method found\"";
    *responseSize = strlen(methodNotFound);
    *response = (unsigned char *)malloc(*responseSize);
    if (*response != NULL) {
        strncpy((char *)(*response), methodNotFound, *responseSize);
    } else {
        LogMessage("ERROR: Cannot create response message for method call.\n");
        abort();
    }

    return result;
}

/// <summary>
///     Callback invoked when a Device Twin update is received from IoT Hub.
/// </summary>
static void twinCallback(DEVICE_TWIN_UPDATE_STATE updateState, const unsigned char *payLoad,
                         size_t payLoadSize, void *userContextCallback)
{
    if (fnTwinUpdateHandler == NULL) {
        LogMessage("WARNING: Received device twin update but no handler available.");
        return;
    }

    JSON_Value* rootProperties = getJsonFromPayload(payLoad, payLoadSize);
    if (rootProperties == NULL) {
        return;
    }

    JSON_Object *rootObject = json_value_get_object(rootProperties);
    JSON_Object *desiredProperties = json_object_dotget_object(rootObject, "desired");
    if (desiredProperties == NULL) {
        desiredProperties = rootObject;
    }
    // Call the provided Twin Device callback
    fnTwinUpdateHandler(desiredProperties);

    json_value_free(rootProperties);
}

/// <summary>
///     Sets the function to be invoked whenever the connection status to the IoT Hub changes.
/// </summary>
/// <param name="callback">The callback function invoked when Azure IoT Hub network connection
/// status changes.</param>
void AzureIoT_SetConnectionStatusCallback(ConnectionStatusFnType callback)
{
    fnConnectionStatusChangedHandler = callback;
}

/// <summary>
///     Callback function invoked whenever the connection status to IoT Hub changes.
/// </summary>
/// <param name="result">Current authentication status</param>
/// <param name="reason">result's specific reason</param>
/// <param name="userContextCallback">User specified context</param>
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
        LogMessage("INFO: IoT Hub connection is down (%s), retrying connection...\n", reasonString);
    } else {
        LogMessage("INFO: connection to the IoT Hub has been established (%s).\n", reasonString);
    }
}

/// <summary>
///     Initializes the Azure IoT Hub SDK.
/// </summary>
/// <return>'true' if initialization has been successful.</param>
bool AzureIoT_Initialize(void)
{
    if (IoTHub_Init() != 0) {
        LogMessage("ERROR: failed initializing platform.\n");
        return false;
    }
    return true;
}

/// <summary>
///     Deinitializes the Azure IoT Hub SDK.
/// </summary>
void AzureIoT_Deinitialize(void)
{
    IoTHub_Deinit();
}
