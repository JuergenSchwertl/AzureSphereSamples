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
#define MQTT_USERNAME_MAX DEVICE_ID_BUFFER_SIZE
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

/// @brief Default MQTT broker hostname. Typically "homeassistant.local" for a local Home Assistant broker.
static const char szBrokerDefault[] = "homeassistant.local";
/// @brief Broker Parameter name "--Broker"
static const char szBrokerParam[] = "--Broker";
/// @brief Port Parameter name "--Port"
static const char szPortParam[] = "--Port";
/// @brief Password Parameter name "--Password"
static const char szPasswordParam[] = "--Password";
/// @brief Client ID Parameter name "--ClientId"
static const char szClientIdParam[] = "--ClientId";
/// @brief Username Parameter name "--Username"
static const char szUsernameParam[] = "--Username";

/// @brief Copy a configuration option while enforcing a destination size limit.
/// @param destination Buffer that receives the copied value.
/// @param destinationSize Size of destination in bytes.
/// @param value Null-terminated source value.
/// @param optionName Configuration option name used in diagnostic output.
/// @returns True if value fit and was copied; false otherwise.
static bool CopyOption(char *destination, size_t destinationSize, const char *value,
                       const char *optionName)
{
    size_t valueSize = strlen(value);
    if (valueSize >= destinationSize) {
        Log_Debug(MQTT_MODULE "ERROR: %s value is too long.\n", optionName);
        return false;
    }
    memcpy(destination, value, valueSize + 1);
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
    mqttClient.port = 1883;
    mqttClient.messageHandler = messageHandler;
    mqttClient.connectionHandler = connectionHandler;

    if (!CopyOption(mqttClient.host, sizeof(mqttClient.host), szBrokerDefault, szBrokerParam)) {
        return false;
    }
    if (GetDeviceID(mqttClient.username, sizeof(mqttClient.username)) != 0) {
        Log_Debug(MQTT_MODULE "ERROR: Could not read the Azure Sphere Device ID.\n");
        return false;
    }
    if (!CopyOption(mqttClient.clientId, sizeof(mqttClient.clientId), mqttClient.username, szClientIdParam)) {
        return false;
    }

    for (int i = 1; i < argc; ++i) {
        if (strncmp(argv[i], szBrokerParam, sizeof(szBrokerParam) - 1) == 0 && i + 1 < argc) {
            if (!CopyOption(mqttClient.host, sizeof(mqttClient.host), argv[++i], szBrokerParam)) {
                return false;
            }
        } else if (strncmp(argv[i], szPortParam, sizeof(szPortParam) - 1) == 0 && i + 1 < argc) {
            char *end = NULL;
            unsigned long port = strtoul(argv[++i], &end, 10);
            if (end == argv[i] || *end != '\0' || port == 0 || port > UINT16_MAX) {
                Log_Debug(MQTT_MODULE "ERROR: --Port must be between 1 and 65535.\n");
                return false;
            }
            mqttClient.port = (uint16_t)port;
        } else if (strncmp(argv[i], szPasswordParam, sizeof(szPasswordParam) - 1) == 0 && i + 1 < argc) {
            if (!CopyOption(mqttClient.password, sizeof(mqttClient.password), argv[++i], szPasswordParam)) {
                return false;
            }
        } else if (strncmp(argv[i], szClientIdParam, sizeof(szClientIdParam) - 1) == 0 && i + 1 < argc) {
            if (!CopyOption(mqttClient.clientId, sizeof(mqttClient.clientId), argv[++i], szClientIdParam)) {
                return false;
            }
        } else if (strncmp(argv[i], szBrokerParam,   sizeof(szBrokerParam) - 1  ) == 0 || 
                   strncmp(argv[i], szPortParam,     sizeof(szPortParam) - 1    ) == 0 ||
                   strncmp(argv[i], szPasswordParam, sizeof(szPasswordParam) - 1) == 0 || 
                   strncmp(argv[i], szClientIdParam, sizeof(szClientIdParam) - 1) == 0) {
            Log_Debug(MQTT_MODULE "ERROR: Missing value for %s.\n", argv[i]);
            return false;
        }
    }

    mqttClient.socketEvent.eventHandler = MqttClient_HandleSocketEvent;
    mqttClient.socketEvent.context = &mqttClient;
    mqtt_init_reconnect(&mqttClient.mqtt, Reconnect, NULL, PublishCallback);
    return mqttClient.epollFd >= 0 && mqttClient.host[0] != '\0' &&
           mqttClient.username[0] != '\0' && mqttClient.clientId[0] != '\0';
}

/// @brief Start or reconnect to the configured MQTT broker.
/// @returns True if a broker socket was established or already exists.
bool MqttClient_Connect(void)
{
    if (mqttClient.socketFd >= 0) {
        return true;
    }
    mqttClient.closeRequested = false;
    enum MQTTErrors result = mqtt_sync(&mqttClient.mqtt);
    if (result != MQTT_OK) {
        Log_Debug(MQTT_MODULE "MQTT connect failed: %s.\n", mqtt_error_str(result));
        return false;
    }
    if (!mqttClient.connected && mqttClient.socketFd >= 0) {
        mqttClient.connected = true;
        Log_Debug(MQTT_MODULE "Connected to broker %s:%u.\n", mqttClient.host, mqttClient.port);
        if (mqttClient.connectionHandler != NULL) {
            mqttClient.connectionHandler(true);
        }
    }
    return mqttClient.socketFd >= 0;
}

/// @brief Check whether an MQTT session is connected.
/// @returns True after the broker connection is active.
bool MqttClient_IsConnected(void)
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
