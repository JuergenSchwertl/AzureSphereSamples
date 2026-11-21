#include "mqtt_client.h"

#include "mqtt.h"

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>

#include <applibs/log.h>
#include "get_device_id.h"


#define MQTT_MODULE "[MQTT] "
#define MQTT_HOST_MAX 128
#define MQTT_USERNAME_MAX 128
#define MQTT_PASSWORD_MAX 128
#define MQTT_CLIENT_ID_MAX DEVICE_ID_BUFFER_SIZE
#define MQTT_TX_BUFFER_SIZE 2048
#define MQTT_RX_BUFFER_SIZE 2048
#define MQTT_KEEPALIVE_SECONDS 30

typedef struct MqttClient {
    int epollFd;
    int socketFd;
    EventData socketEvent;
    char host[MQTT_HOST_MAX];
    char username[MQTT_USERNAME_MAX];
    char password[MQTT_PASSWORD_MAX];
    char clientId[MQTT_CLIENT_ID_MAX];
    uint16_t port;
    bool connected;
    bool closeRequested;
    MqttMessageHandler messageHandler;
    MqttConnectionHandler connectionHandler;
    struct mqtt_client mqtt;
    uint8_t sendBuffer[MQTT_TX_BUFFER_SIZE];
    uint8_t receiveBuffer[MQTT_RX_BUFFER_SIZE];
} MqttClient;

static MqttClient mqttClient = {.epollFd = -1, .socketFd = -1};

/********************************************************************************************************************
 * 
 * MQTT broker configuration constants and defaults to build the MQTT topic strings for commands and sensors.
 * 
 ********************************************************************************************************************/

static const char szMqttClientIdPrefix[] = "avnet_sk2_";
/// @brief MQTT client ID string used to identify the device to the broker. Set to the szMqttClientIdPrefix followed by the first 8 characters of the Azure Sphere Device ID
static char szMqttAzSphereClientId[32] ;

static const char szMqttCommandTopicPrefix[] = "command";
static const char szMqttSensorTopicPrefix[] = "sensor";


/********************************************************************************************************************
 * 
 * Command line parameter names for MQTT broker configuration. 
 * 
 ********************************************************************************************************************/
/// @brief Broker Parameter name "--Broker". Can be omitted to use the default Home Assistant broker hostname "homeassistant.local", but can be overridden for testing.
/// Update app_manifest.json "AllowedConnections"accordingly if you change the default broker hostname.
static const char szBrokerParam[] = "--Broker";
/// @brief Port Parameter name "--Port"
static const char szPortParam[] = "--Port";
/// @brief Username Parameter name "--Username". See in Home Assistant "Configuration > Users" for the username of the MQTT broker user. The default is "homeassistant".
static const char szUsernameParam[] = "--Username";
/// @brief Password Parameter name "--Password". See in Home Assistant "Configuration > Users" for the password of the MQTT broker user. The default is "__**password_not_changed**__".
static const char szPasswordParam[] = "--Password";
/// @brief Client ID Parameter name "--ClientId". Should be omitted as it is automatically set to the Azure Sphere Device ID (first 8 chars only for readability), but can be overridden for testing.
static const char szClientIdParam[] = "--ClientId";

/********************************************************************************************************************
 * 
 * Default MQTT broker configuration values. These can be overridden by command line parameters.
 * 
 ********************************************************************************************************************/

/// @brief Default MQTT broker hostname. Typically "homeassistant.local" for a local Home Assistant broker.
static const char szBrokerDefault[] = "homeassistant.local";
/// @brief Default MQTT broker TCP port. Typically 1883 for a local Home Assistant broker.
static const uint16_t nPortDefault = 1883;
/// @brief Default MQTT broker username. Typically "homeassistant" for a local Home Assistant broker.
static const char szUsernameDefault[] = "homeassistant";
/// @brief Default MQTT broker password. Typically "__**password_not_changed**__" for a local Home Assistant broker.
static const char szPasswordDefault[] = "__**password_not_changed**__";
/// @brief Default MQTT client ID. Typically overriden by Azure Sphere Device ID (first 8 chars only for readability).
static const char szClientIdDefault[] = "AzureSphere";

/// @brief Copy a configuration option while enforcing a destination size limit.
/// @param pszDestination Buffer that receives the copied value.
/// @param nDestinationSize Size of destination in bytes.
/// @param pszValue Null-terminated source value.
/// @param pszOptionName Configuration option name used in diagnostic output.
/// @returns True if value fit and was copied; false otherwise.
static bool ParseStringOption(char *pszDestination, size_t nDestinationSize, const char *pszValue, const char *pszOptionName)
{
    size_t valueSize = strnlen(pszValue, nDestinationSize);
    if (valueSize >= nDestinationSize) {
        Log_Debug(MQTT_MODULE "ERROR: %s value is too long.\n", pszOptionName);
        return false;
    } else if (valueSize == 0) {
        Log_Debug(MQTT_MODULE "ERROR: %s value is missing.\n", pszOptionName);
        return false;
    }
    memcpy(pszDestination, pszValue, valueSize + 1);
    Log_Debug(MQTT_MODULE "INFO: %s set to '%s'.\n", pszOptionName, pszDestination);
    return true;
}

/// @brief  Parse a numeric configuration option while enforcing a destination size limit and range.
/// @param pnDestination 
/// @param pszValue 
/// @param pszOptionName 
/// @return 
static bool ParseNumericOption(uint16_t *pnDestination, const char *pszValue, const char *pszOptionName)
{
    char *end = NULL;
    unsigned long number = strtoul(pszValue, &end, 10);
    if (end == pszValue || *end != '\0' || number == 0 || number > UINT16_MAX) {
        Log_Debug(MQTT_MODULE "ERROR: %s must be between 1 and 65535.\n", pszOptionName);
        return false;
    }
    *pnDestination = (uint16_t)number;
    Log_Debug(MQTT_MODULE "INFO: %s set to '%d'.\n", pszOptionName, number);
    return true;
}

/// @brief Dispatch an MQTT publish received from the broker.
/// @param state Pointer to callback state supplied by MQTT-C.
/// @param published Decoded publish containing topic and payload data.
static void PublishCallback(void **state, struct mqtt_response_publish *published)
{
    (void)state;
    if (mqttClient.messageHandler == NULL) {
        return;
    }

    char *topic = malloc((size_t)published->topic_name_size + 1);
    char *payload = malloc(published->application_message_size + 1);
    if (topic == NULL || payload == NULL) {
        free(topic);
        free(payload);
        Log_Debug(MQTT_MODULE "ERROR: Out of memory receiving an MQTT publish.\n");
        return;
    }

    memcpy(topic, published->topic_name, published->topic_name_size);
    topic[published->topic_name_size] = '\0';
    memcpy(payload, published->application_message, published->application_message_size);
    payload[published->application_message_size] = '\0';
    mqttClient.messageHandler(topic, payload, published->application_message_size,
                          published->retain_flag != 0);
    free(topic);
    free(payload);
}

/// @brief Register the broker socket for epoll read and write events.
/// @returns True if the socket event handler was registered successfully.
static bool RegisterSocketEvents(void)
{
    if (mqttClient.socketFd < 0) {
        return true;
    }
    uint32_t events = EPOLLIN | EPOLLOUT | EPOLLERR | EPOLLHUP | EPOLLRDHUP;
    return RegisterEventHandlerToEpoll(mqttClient.epollFd, mqttClient.socketFd, &mqttClient.socketEvent,
                                       events) == 0;
}

/// @brief Close the broker socket and notify the application after a connection loss.
static void DisconnectSocket(void)
{
    bool wasConnected = mqttClient.connected;
    if (mqttClient.socketFd >= 0) {
        UnregisterEventHandlerFromEpoll(mqttClient.epollFd, mqttClient.socketFd);
        close(mqttClient.socketFd);
        mqttClient.socketFd = -1;
    }
    mqttClient.connected = false;
    if (wasConnected && mqttClient.connectionHandler != NULL) {
        mqttClient.connectionHandler(false);
    }
}

/// @brief Open a non-blocking TCP connection to an MQTT broker.
/// @param host Broker hostname or IP address.
/// @param port Broker TCP port.
/// @returns Connected socket file descriptor, or -1 if opening the socket failed.
static int OpenSocket(const char *host, uint16_t port)
{
    char portString[6];
    snprintf(portString, sizeof(portString), "%u", port);

    struct addrinfo hints = {.ai_family = AF_UNSPEC, .ai_socktype = SOCK_STREAM};
    struct addrinfo *addresses = NULL;
    int result = getaddrinfo(host, portString, &hints, &addresses);
    if (result != 0) {
        Log_Debug(MQTT_MODULE "Cannot resolve broker %s: %s.\n", host, gai_strerror(result));
        return -1;
    }

    int socketFd = -1;
    for (struct addrinfo *address = addresses; address != NULL; address = address->ai_next) {
        socketFd = socket(address->ai_family, address->ai_socktype, address->ai_protocol);
        if (socketFd < 0) {
            continue;
        }

        if (connect(socketFd, address->ai_addr, address->ai_addrlen) == 0) {
            break;
        }

        close(socketFd);
        socketFd = -1;
    }
    freeaddrinfo(addresses);

    if (socketFd < 0) {
        Log_Debug(MQTT_MODULE "Cannot connect to broker %s:%u.\n", host, port);
        return -1;
    }

    int flags = fcntl(socketFd, F_GETFL, 0);
    if (flags < 0 || fcntl(socketFd, F_SETFL, flags | O_NONBLOCK) < 0) {
        Log_Debug(MQTT_MODULE "Cannot configure broker socket for non-blocking I/O: %s.\n",
                  strerror(errno));
        close(socketFd);
        return -1;
    }
    return socketFd;
}


static void MqttClient_BuildCommandTopic(char *pszBuffer, size_t nBufferSize, const char *pszCommand)
{
    snprintf(pszBuffer, nBufferSize, "%s/%s/%s", szMqttTopicIdPrefix, szMqttCommandTopicPrefix, pszCommand);
}

/// @brief Reconnect an MQTT-C client and send an MQTT CONNECT packet.
/// @param mqtt MQTT-C client to reconnect.
/// @param reconnectState Reconnect callback state supplied by MQTT-C.
static void Reconnect(struct mqtt_client *mqtt, void **reconnectState)
{
    (void)reconnectState;
    if (mqtt->socketfd >= 0) {
        close(mqtt->socketfd);
    }

    int socketFd = OpenSocket(mqttClient.host, mqttClient.port);
    if (socketFd < 0) {
        mqttClient.socketFd = -1;
        mqtt->socketfd = -1;
        return;
    }

    mqttClient.socketFd = socketFd;

    mqtt_reinit(mqtt, socketFd, mqttClient.sendBuffer, sizeof(mqttClient.sendBuffer),
                mqttClient.receiveBuffer, sizeof(mqttClient.receiveBuffer));

    uint8_t connectFlags = MQTT_CONNECT_CLEAN_SESSION | MQTT_CONNECT_USER_NAME;
    if (mqttClient.password[0] != '\0') {
        connectFlags |= MQTT_CONNECT_PASSWORD;
    }

    static const char willMessage[] = "offline";
    enum MQTTErrors result = mqtt_connect(mqtt, mqttClient.clientId, "avnet_sk2/status",
                                          willMessage, sizeof(willMessage) - 1,
                                          mqttClient.username,
                                          mqttClient.password[0] == '\0' ? NULL : mqttClient.password,
                                          connectFlags, MQTT_KEEPALIVE_SECONDS);
    if (result != MQTT_OK) {
        Log_Debug(MQTT_MODULE "MQTT CONNECT failed: %s.\n", mqtt_error_str(result));
        DisconnectSocket();
        return;
    }
    RegisterSocketEvents();
}

/// @brief Initialize MQTT-C, broker settings, authentication, and epoll callbacks.
/// @param fdEpoll Epoll file descriptor used for broker socket events.
/// @param argc Application argument count.
/// @param argv Application argument vector.
/// @param messageHandler Callback invoked for received MQTT publishes.
/// @param connectionHandler Callback invoked when broker connection state changes.
/// @returns True if client configuration and initialization succeeded.
bool MqttClient_Init(int fdEpoll, int argc, char *argv[], MqttMessageHandler messageHandler,
                     MqttConnectionHandler connectionHandler)
{
    memset(&mqttClient, 0, sizeof(mqttClient));
    mqttClient.epollFd = fdEpoll;
    mqttClient.socketFd = -1;
    mqttClient.messageHandler = messageHandler;
    mqttClient.connectionHandler = connectionHandler;

    // try to pick up broker settings from command line arguments, but fall back to defaults if not provided
    for (int i = 1; i < argc; ++i) {
        if (strncmp(argv[i], szBrokerParam, sizeof(szBrokerParam) - 1) == 0 && i + 1 < argc) {
            if (!ParseStringOption(mqttClient.host, sizeof(mqttClient.host), argv[++i], szBrokerParam)) {
                return false;
            }
        } else if (strncmp(argv[i], szPortParam, sizeof(szPortParam) - 1) == 0 && i + 1 < argc) {
            if(!ParseNumericOption(&mqttClient.port, argv[++i], szPortParam)) {
                return false;
            }
        } else if (strncmp(argv[i], szUsernameParam, sizeof(szUsernameParam) - 1) == 0 && i + 1 < argc) {
            if (!ParseStringOption(mqttClient.username, sizeof(mqttClient.username), argv[++i], szUsernameParam)) {
                return false;
            }
        } else if (strncmp(argv[i], szPasswordParam, sizeof(szPasswordParam) - 1) == 0 && i + 1 < argc) {
            if (!ParseStringOption(mqttClient.password, sizeof(mqttClient.password), argv[++i], szPasswordParam)) {
                return false;
            }
        } else if (strncmp(argv[i], szClientIdParam, sizeof(szClientIdParam) - 1) == 0 && i + 1 < argc) {
            if (!ParseStringOption(mqttClient.clientId, sizeof(mqttClient.clientId), argv[++i], szClientIdParam)) {
                return false;
            }
        } 

    }

    // fall back to defaults if no command line arguments were provided
    if (mqttClient.host[0] == '\0') {
        memcpy(mqttClient.host, szBrokerDefault, sizeof(szBrokerDefault));
    }
    if (mqttClient.port == 0) {
        mqttClient.port = nPortDefault;
    }
    if (mqttClient.username[0] == '\0') {
        memcpy(mqttClient.username, szUsernameDefault, sizeof(szUsernameDefault));
    }
    if (mqttClient.password[0] == '\0') {
        memcpy(mqttClient.password, szPasswordDefault, sizeof(szPasswordDefault));
    }

    // DO NOT try to retrieve the Azure Sphere Device ID yet, because the Device Authentication service may not be ready at this point. 
    // Instead, we will retrieve the Device ID later in MqttClient_InitDeviceId() after the Device Authentication service is ready.

    mqttClient.socketEvent.eventHandler = MqttClient_HandleSocketEvent;
    mqttClient.socketEvent.context = &mqttClient;
    return true;
}

/// @brief Initialize the MQTT client ID to the Azure Sphere Device ID (first 8 chars only for readability).    
bool MqttClient_InitDeviceId(void)
{
    if(mqttClient.clientId[0] != '\0') {
        // client ID was already set from command line argument, so we will not override it with the Azure Sphere Device ID
        return true;
    }

    char szClientId[DEVICE_ID_BUFFER_SIZE];
    if (GetDeviceID(szClientId, sizeof(szClientId)) == 0) {
        size_t nLength = sizeof(szMqttClientIdPrefix) - 1;
        memcpy(szMqttAzSphereClientId, szMqttClientIdPrefix, nLength);
        memcpy(szMqttAzSphereClientId + nLength, szClientId, 8);
        nLength += 9; // 8 chars of Device ID + 1 for null terminator
        szMqttAzSphereClientId[nLength] = '\0';

        // Copy the string also to the mqttClient.clientId, which is used by MQTT-C for the CONNECT packet
        memcpy(mqttClient.clientId, szMqttAzSphereClientId, nLength);
        Log_Debug(MQTT_MODULE "INFO: Using Azure Sphere Device ID as MQTT client ID: %s\n", mqttClient.clientId);
        return true;
    } else {
        Log_Debug(MQTT_MODULE "WARNING: Could not read the Azure Sphere Device ID. Will use default instead.\n");
        memcpy(mqttClient.clientId, szClientIdDefault, sizeof(szClientIdDefault));
        return false;
    }
}

// /// @brief Start or reconnect to the configured MQTT broker.
// /// @returns True if a broker socket was established or already exists.
// bool MqttClient_Connect(void)
// {
//     if (mqttClient.socketFd >= 0) {
//         return true;
//     }

//     mqttClient.closeRequested = false;
//     enum MQTTErrors result = mqtt_sync(&mqttClient.mqtt);
//     if (result != MQTT_OK) {
//         Log_Debug(MQTT_MODULE "MQTT connect failed: %s.\n", mqtt_error_str(result));
//         return false;
//     }
//     if (!mqttClient.connected && mqttClient.socketFd >= 0) {
//         mqttClient.connected = true;
//         Log_Debug(MQTT_MODULE "Connected to broker %s:%u.\n", mqttClient.host, mqttClient.port);
//         if (mqttClient.connectionHandler != NULL) {
//             mqttClient.connectionHandler(true);
//         }
//     }
//     return mqttClient.socketFd >= 0;
// }

/// @brief Check whether an MQTT session is connected.
/// @returns True after the broker connection is active.
inline bool MqttClient_IsConnected(void)
{
    return mqttClient.connected;
}

/// @brief Publish a payload to an MQTT topic.
/// @param topic MQTT topic name.
/// @param payload Payload bytes to publish.
/// @param retained True to ask the broker to retain the publish.
/// @returns True if MQTT-C accepted and synchronized the publish.
bool MqttClient_Publish(const char *topic, const char *payload, bool retained)
{
    if (!MqttClient_IsConnected() || topic == NULL || payload == NULL) {
        return false;
    }
    uint8_t flags = MQTT_PUBLISH_QOS_0 | (retained ? MQTT_PUBLISH_RETAIN : 0);
    enum MQTTErrors result = mqtt_publish(&mqttClient.mqtt, topic, payload, strlen(payload), flags);
    if (result != MQTT_OK) {
        Log_Debug(MQTT_MODULE "MQTT publish failed: %s.\n", mqtt_error_str(result));
        return false;
    }
    result = mqtt_sync(&mqttClient.mqtt);
    return result == MQTT_OK;
}

/// @brief Subscribe to an MQTT topic.
/// @param topic MQTT topic name or topic filter.
/// @returns True if MQTT-C accepted and synchronized the subscription.
bool MqttClient_Subscribe(const char *topic)
{
    if (!MqttClient_IsConnected() || topic == NULL) {
        return false;
    }
    enum MQTTErrors result = mqtt_subscribe(&mqttClient.mqtt, topic, 0);
    if (result != MQTT_OK) {
        Log_Debug(MQTT_MODULE "MQTT subscribe failed: %s.\n", mqtt_error_str(result));
        return false;
    }
    return mqtt_sync(&mqttClient.mqtt) == MQTT_OK;
}

/// @brief Process broker socket events and synchronize MQTT-C traffic.
/// @param eventData Epoll event data associated with the broker socket.
void MqttClient_HandleSocketEvent(EventData *eventData)
{
    if (eventData == NULL || mqttClient.socketFd < 0) {
        return;
    }
    if ((eventData->events & (EPOLLERR | EPOLLHUP | EPOLLRDHUP)) != 0) {
        DisconnectSocket();
        return;
    }

    enum MQTTErrors result = mqtt_sync(&mqttClient.mqtt);
    if (result != MQTT_OK) {
        Log_Debug(MQTT_MODULE "MQTT sync failed: %s.\n", mqtt_error_str(result));
        DisconnectSocket();
    }
}

/// @brief Perform MQTT-C background processing and keepalive work.
void MqttClient_DoWork(void)
{
    if (!MqttClient_IsConnected() || mqttClient.closeRequested) {
        return;
    }
    enum MQTTErrors result = mqtt_sync(&mqttClient.mqtt);
    if (result != MQTT_OK) {
        Log_Debug(MQTT_MODULE "MQTT keepalive failed: %s.\n", mqtt_error_str(result));
        DisconnectSocket();
    }
}

/// @brief Close the MQTT connection and release callback state.
void MqttClient_Close(void)
{
    mqttClient.closeRequested = true;
    DisconnectSocket();
    mqttClient.epollFd = -1;
    mqttClient.messageHandler = NULL;
    mqttClient.connectionHandler = NULL;
}
