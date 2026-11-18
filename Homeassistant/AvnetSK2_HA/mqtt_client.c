#include "mqtt_client.h"

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

#define MQTT_MODULE "[MQTT] "
#define MQTT_HOST_MAX 128
#define MQTT_CREDENTIAL_MAX 128
#define MQTT_CLIENT_ID_MAX 64
#define MQTT_RX_BUFFER_SIZE 2048
#define MQTT_TX_PACKET_MAX 1024
#define MQTT_KEEPALIVE_SECONDS 30

typedef struct MqttPacket {
    struct MqttPacket *next;
    size_t size;
    size_t offset;
    unsigned char data[];
} MqttPacket;

typedef enum MqttSocketState {
    MqttSocket_Disconnected,
    MqttSocket_Connecting,
    MqttSocket_WaitingForConnack,
    MqttSocket_Connected
} MqttSocketState;

typedef struct MqttClient {
    int epollFd;
    int socketFd;
    EventData socketEvent;
    MqttSocketState state;
    char host[MQTT_HOST_MAX];
    char username[MQTT_CREDENTIAL_MAX];
    char password[MQTT_CREDENTIAL_MAX];
    char clientId[MQTT_CLIENT_ID_MAX];
    uint16_t port;
    MqttMessageHandler messageHandler;
    MqttConnectionHandler connectionHandler;
    MqttPacket *txHead;
    MqttPacket *txTail;
    unsigned char rxBuffer[MQTT_RX_BUFFER_SIZE];
    size_t rxSize;
    uint16_t nextPacketId;
    time_t lastPacketTime;
    bool pingOutstanding;
} MqttClient;

static MqttClient client = {.epollFd = -1, .socketFd = -1};

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

static bool AppendMqttString(unsigned char *buffer, size_t capacity, size_t *offset,
                             const char *value)
{
    size_t length = strlen(value);
    if (length > UINT16_MAX || *offset > capacity || capacity - *offset < length + 2) {
        return false;
    }

    buffer[(*offset)++] = (unsigned char)(length >> 8);
    buffer[(*offset)++] = (unsigned char)length;
    memcpy(buffer + *offset, value, length);
    *offset += length;
    return true;
}

static size_t EncodeRemainingLength(unsigned char *buffer, size_t value)
{
    size_t count = 0;
    do {
        unsigned char encoded = (unsigned char)(value % 128);
        value /= 128;
        if (value > 0) {
            encoded |= 0x80;
        }
        buffer[count++] = encoded;
    } while (value > 0 && count < 4);

    return count;
}

static bool UpdateSocketEvents(void)
{
    if (client.socketFd < 0) {
        return true;
    }

    uint32_t events = EPOLLIN | EPOLLERR | EPOLLHUP | EPOLLRDHUP;
    if (client.state == MqttSocket_Connecting || client.txHead != NULL) {
        events |= EPOLLOUT;
    }

    if (RegisterEventHandlerToEpoll(client.epollFd, client.socketFd, &client.socketEvent,
                                    events) != 0) {
        return false;
    }
    return true;
}

static void ClearQueuedPackets(void)
{
    while (client.txHead != NULL) {
        MqttPacket *packet = client.txHead;
        client.txHead = packet->next;
        free(packet);
    }
    client.txTail = NULL;
}

static void DisconnectSocket(void)
{
    bool wasConnected = client.state == MqttSocket_Connected;
    if (client.socketFd >= 0) {
        UnregisterEventHandlerFromEpoll(client.epollFd, client.socketFd);
        close(client.socketFd);
        client.socketFd = -1;
    }

    ClearQueuedPackets();
    client.rxSize = 0;
    client.state = MqttSocket_Disconnected;
    client.pingOutstanding = false;

    if (wasConnected && client.connectionHandler != NULL) {
        client.connectionHandler(false);
    }
}

static bool QueuePacket(const unsigned char *data, size_t size)
{
    if (client.socketFd < 0 || size == 0) {
        return false;
    }

    MqttPacket *packet = malloc(sizeof(*packet) + size);
    if (packet == NULL) {
        Log_Debug(MQTT_MODULE "ERROR: Out of memory while queuing a packet.\n");
        return false;
    }

    packet->next = NULL;
    packet->size = size;
    packet->offset = 0;
    memcpy(packet->data, data, size);

    if (client.txTail != NULL) {
        client.txTail->next = packet;
    } else {
        client.txHead = packet;
    }
    client.txTail = packet;

    if (!UpdateSocketEvents()) {
        DisconnectSocket();
        return false;
    }
    return true;
}

static bool QueueConnectPacket(void)
{
    unsigned char packet[MQTT_TX_PACKET_MAX];
    unsigned char body[MQTT_TX_PACKET_MAX];
    size_t bodySize = 0;
    unsigned char flags = 0x26; // Clean session and retained offline will.

    if (client.username[0] != '\0') {
        flags |= 0x80;
    }
    if (client.password[0] != '\0') {
        flags |= 0x40;
    }

    body[bodySize++] = 0;
    body[bodySize++] = 4;
    memcpy(body + bodySize, "MQTT", 4);
    bodySize += 4;
    body[bodySize++] = 4;
    body[bodySize++] = flags;
    body[bodySize++] = (unsigned char)(MQTT_KEEPALIVE_SECONDS >> 8);
    body[bodySize++] = (unsigned char)MQTT_KEEPALIVE_SECONDS;

    if (!AppendMqttString(body, sizeof(body), &bodySize, client.clientId) ||
        !AppendMqttString(body, sizeof(body), &bodySize, "avnet_sk2/status") ||
        !AppendMqttString(body, sizeof(body), &bodySize, "offline") ||
        (client.username[0] != '\0' &&
         !AppendMqttString(body, sizeof(body), &bodySize, client.username)) ||
        (client.password[0] != '\0' &&
         !AppendMqttString(body, sizeof(body), &bodySize, client.password))) {
        Log_Debug(MQTT_MODULE "ERROR: MQTT connection settings are too large.\n");
        return false;
    }

    packet[0] = 0x10;
    size_t remainingLengthSize = EncodeRemainingLength(packet + 1, bodySize);
    memcpy(packet + 1 + remainingLengthSize, body, bodySize);
    client.state = MqttSocket_WaitingForConnack;
    client.lastPacketTime = time(NULL);
    return QueuePacket(packet, 1 + remainingLengthSize + bodySize);
}

static bool QueueSimplePacket(unsigned char header)
{
    const unsigned char packet[] = {header, 0};
    return QueuePacket(packet, sizeof(packet));
}

static bool QueueSubscription(const char *topic)
{
    unsigned char packet[MQTT_TX_PACKET_MAX];
    size_t offset = 0;
    uint16_t packetId = ++client.nextPacketId;
    if (packetId == 0) {
        packetId = ++client.nextPacketId;
    }

    packet[0] = 0x82;
    offset = 2;
    packet[offset++] = (unsigned char)(packetId >> 8);
    packet[offset++] = (unsigned char)packetId;
    if (!AppendMqttString(packet, sizeof(packet), &offset, topic) || offset >= sizeof(packet)) {
        return false;
    }
    packet[offset++] = 0; // Subscribe at QoS 0.
    size_t remainingLengthSize = EncodeRemainingLength(packet + 1, offset - 2);
    memmove(packet + 1 + remainingLengthSize, packet + 2, offset - 2);
    return QueuePacket(packet, 1 + remainingLengthSize + offset - 2);
}

static bool QueuePublish(const char *topic, const char *payload, size_t payloadSize, bool retained)
{
    unsigned char packet[MQTT_TX_PACKET_MAX];
    size_t offset = 0;
    packet[offset++] = 0x30 | (retained ? 0x01 : 0x00);
    offset++; // Remaining-length placeholder.
    if (!AppendMqttString(packet, sizeof(packet), &offset, topic) ||
        payloadSize > sizeof(packet) - offset) {
        Log_Debug(MQTT_MODULE "ERROR: MQTT publish packet is too large.\n");
        return false;
    }

    memcpy(packet + offset, payload, payloadSize);
    offset += payloadSize;
    size_t remainingLengthSize = EncodeRemainingLength(packet + 1, offset - 2);
    memmove(packet + 1 + remainingLengthSize, packet + 2, offset - 2);
    return QueuePacket(packet, 1 + remainingLengthSize + offset - 2);
}

static bool HandlePacket(unsigned char header, const unsigned char *body, size_t bodySize)
{
    unsigned char packetType = header >> 4;
    if (packetType == 2) {
        if (client.state != MqttSocket_WaitingForConnack || bodySize != 2 || body[1] != 0) {
            Log_Debug(MQTT_MODULE "ERROR: Broker rejected the MQTT connection (code %u).\n",
                      bodySize == 2 ? body[1] : 0xff);
            return false;
        }

        client.state = MqttSocket_Connected;
        client.lastPacketTime = time(NULL);
        Log_Debug(MQTT_MODULE "Connected to broker %s:%u.\n", client.host, client.port);
        if (client.connectionHandler != NULL) {
            client.connectionHandler(true);
        }
        return true;
    }

    if (packetType == 3 && client.state == MqttSocket_Connected) {
        if (bodySize < 2) {
            return false;
        }

        size_t topicSize = ((size_t)body[0] << 8) | body[1];
        size_t offset = 2;
        unsigned char qos = (header >> 1) & 0x03;
        if (topicSize > bodySize - offset) {
            return false;
        }
        const char *topic = (const char *)(body + offset);
        offset += topicSize;
        if (qos != 0) {
            if (qos != 1 || bodySize - offset < 2) {
                Log_Debug(MQTT_MODULE "ERROR: Unsupported incoming QoS %u.\n", qos);
                return false;
            }
            uint16_t packetId = (uint16_t)(((uint16_t)body[offset] << 8) | body[offset + 1]);
            offset += 2;
            unsigned char ack[] = {0x40, 2, (unsigned char)(packetId >> 8),
                                   (unsigned char)packetId};
            if (!QueuePacket(ack, sizeof(ack))) {
                return false;
            }
        }

        size_t payloadSize = bodySize - offset;
        char *topicCopy = malloc(topicSize + 1);
        char *payloadCopy = malloc(payloadSize + 1);
        if (topicCopy == NULL || payloadCopy == NULL) {
            free(topicCopy);
            free(payloadCopy);
            Log_Debug(MQTT_MODULE "ERROR: Out of memory receiving an MQTT message.\n");
            return false;
        }

        memcpy(topicCopy, topic, topicSize);
        topicCopy[topicSize] = '\0';
        memcpy(payloadCopy, body + offset, payloadSize);
        payloadCopy[payloadSize] = '\0';
        client.lastPacketTime = time(NULL);
        if (client.messageHandler != NULL) {
            client.messageHandler(topicCopy, payloadCopy, payloadSize, (header & 0x01) != 0);
        }
        free(topicCopy);
        free(payloadCopy);
        return true;
    }

    if (packetType == 13 && client.state == MqttSocket_Connected && bodySize == 0) {
        client.pingOutstanding = false;
        client.lastPacketTime = time(NULL);
        return true;
    }

    if ((packetType == 9 || packetType == 4) && bodySize >= 2) {
        return true;
    }

    return true;
}

static void HandleSocketReadable(void)
{
    for (;;) {
        if (client.rxSize == sizeof(client.rxBuffer)) {
            Log_Debug(MQTT_MODULE "ERROR: Incoming MQTT packet exceeds the receive buffer.\n");
            DisconnectSocket();
            return;
        }

        ssize_t bytesRead = recv(client.socketFd, client.rxBuffer + client.rxSize,
                                 sizeof(client.rxBuffer) - client.rxSize, 0);
        if (bytesRead > 0) {
            client.rxSize += (size_t)bytesRead;
        } else if (bytesRead == 0) {
            DisconnectSocket();
            return;
        } else if (errno == EINTR) {
            continue;
        } else if (errno == EAGAIN || errno == EWOULDBLOCK) {
            break;
        } else {
            Log_Debug(MQTT_MODULE "Socket receive failed: %s.\n", strerror(errno));
            DisconnectSocket();
            return;
        }
    }

    size_t consumed = 0;
    while (client.rxSize - consumed >= 2) {
        const unsigned char *packet = client.rxBuffer + consumed;
        size_t remainingLength = 0;
        size_t multiplier = 1;
        size_t lengthBytes = 0;
        unsigned char encoded;
        do {
            if (1 + lengthBytes >= client.rxSize - consumed) {
                goto packets_done;
            }
            encoded = packet[1 + lengthBytes];
            remainingLength += (encoded & 0x7f) * multiplier;
            multiplier *= 128;
            lengthBytes++;
            if (lengthBytes == 4 && (encoded & 0x80) != 0) {
                Log_Debug(MQTT_MODULE "ERROR: Invalid MQTT remaining-length encoding.\n");
                DisconnectSocket();
                return;
            }
        } while ((encoded & 0x80) != 0);

        size_t packetSize = 1 + lengthBytes + remainingLength;
        if (packetSize > sizeof(client.rxBuffer) ||
            packetSize > client.rxSize - consumed) {
            if (packetSize > sizeof(client.rxBuffer)) {
                Log_Debug(MQTT_MODULE "ERROR: Incoming MQTT packet is too large.\n");
                DisconnectSocket();
            }
            goto packets_done;
        }

        if (!HandlePacket(packet[0], packet + 1 + lengthBytes, remainingLength)) {
            DisconnectSocket();
            return;
        }
        consumed += packetSize;
    }

packets_done:
    if (consumed > 0) {
        memmove(client.rxBuffer, client.rxBuffer + consumed, client.rxSize - consumed);
        client.rxSize -= consumed;
    }
}

static void HandleSocketWritable(void)
{
    if (client.state == MqttSocket_Connecting) {
        int socketError = 0;
        socklen_t errorSize = sizeof(socketError);
        if (getsockopt(client.socketFd, SOL_SOCKET, SO_ERROR, &socketError, &errorSize) != 0 ||
            socketError != 0) {
            if (socketError != 0) {
                errno = socketError;
            }
            Log_Debug(MQTT_MODULE "Connection to %s:%u failed: %s.\n", client.host, client.port,
                      strerror(errno));
            DisconnectSocket();
            return;
        }
        if (!QueueConnectPacket()) {
            DisconnectSocket();
            return;
        }
    }

    while (client.txHead != NULL) {
        MqttPacket *packet = client.txHead;
        ssize_t bytesWritten = send(client.socketFd, packet->data + packet->offset,
                                    packet->size - packet->offset, 0);
        if (bytesWritten > 0) {
            packet->offset += (size_t)bytesWritten;
            client.lastPacketTime = time(NULL);
            if (packet->offset == packet->size) {
                client.txHead = packet->next;
                if (client.txHead == NULL) {
                    client.txTail = NULL;
                }
                free(packet);
            }
            continue;
        }
        if (bytesWritten < 0 && errno == EINTR) {
            continue;
        }
        if (bytesWritten < 0 && (errno == EAGAIN || errno == EWOULDBLOCK)) {
            break;
        }

        Log_Debug(MQTT_MODULE "Socket send failed: %s.\n", strerror(errno));
        DisconnectSocket();
        return;
    }

    if (!UpdateSocketEvents()) {
        DisconnectSocket();
    }
}

bool MqttClient_Init(int fdEpoll, int argc, char *argv[], MqttMessageHandler messageHandler,
                     MqttConnectionHandler connectionHandler)
{
    memset(&client, 0, sizeof(client));
    client.epollFd = fdEpoll;
    client.socketFd = -1;
    client.port = 1883;
    client.nextPacketId = 0;
    client.messageHandler = messageHandler;
    client.connectionHandler = connectionHandler;
    if (!CopyOption(client.host, sizeof(client.host), "homeassistant.local", "--Broker") ||
        !CopyOption(client.clientId, sizeof(client.clientId), "avnet_sk2", "--ClientId")) {
        return false;
    }

    for (int i = 1; i < argc; ++i) {
        if (strcmp(argv[i], "--Broker") == 0 && i + 1 < argc) {
            if (!CopyOption(client.host, sizeof(client.host), argv[++i], "--Broker")) {
                return false;
            }
        } else if (strcmp(argv[i], "--Port") == 0 && i + 1 < argc) {
            char *end = NULL;
            unsigned long port = strtoul(argv[++i], &end, 10);
            if (end == argv[i] || *end != '\0' || port == 0 || port > UINT16_MAX) {
                Log_Debug(MQTT_MODULE "ERROR: --Port must be between 1 and 65535.\n");
                return false;
            }
            client.port = (uint16_t)port;
        } else if (strcmp(argv[i], "--Username") == 0 && i + 1 < argc) {
            if (!CopyOption(client.username, sizeof(client.username), argv[++i], "--Username")) {
                return false;
            }
        } else if (strcmp(argv[i], "--Password") == 0 && i + 1 < argc) {
            if (!CopyOption(client.password, sizeof(client.password), argv[++i], "--Password")) {
                return false;
            }
        } else if (strcmp(argv[i], "--ClientId") == 0 && i + 1 < argc) {
            if (!CopyOption(client.clientId, sizeof(client.clientId), argv[++i], "--ClientId")) {
                return false;
            }
        } else if (strcmp(argv[i], "--Broker") == 0 || strcmp(argv[i], "--Port") == 0 ||
                   strcmp(argv[i], "--Username") == 0 || strcmp(argv[i], "--Password") == 0 ||
                   strcmp(argv[i], "--ClientId") == 0) {
            Log_Debug(MQTT_MODULE "ERROR: Missing value for %s.\n", argv[i]);
            return false;
        }
    }

    if (client.epollFd < 0 || client.host[0] == '\0' || client.clientId[0] == '\0') {
        Log_Debug(MQTT_MODULE "ERROR: Broker host and client ID must not be empty.\n");
        return false;
    }
    if (client.password[0] != '\0' && client.username[0] == '\0') {
        Log_Debug(MQTT_MODULE "ERROR: --Password requires --Username.\n");
        return false;
    }
    client.socketEvent.eventHandler = MqttClient_HandleSocketEvent;
    client.socketEvent.context = &client;
    return true;
}

bool MqttClient_Connect(void)
{
    if (client.socketFd >= 0) {
        return true;
    }

    char portString[6];
    snprintf(portString, sizeof(portString), "%u", client.port);
    struct addrinfo hints = {.ai_family = AF_UNSPEC, .ai_socktype = SOCK_STREAM};
    struct addrinfo *addresses = NULL;
    int result = getaddrinfo(client.host, portString, &hints, &addresses);
    if (result != 0) {
        Log_Debug(MQTT_MODULE "Cannot resolve broker %s: %s.\n", client.host,
                  gai_strerror(result));
        return false;
    }

    int lastError = ECONNREFUSED;
    for (struct addrinfo *address = addresses; address != NULL; address = address->ai_next) {
        int fd = socket(address->ai_family, address->ai_socktype, address->ai_protocol);
        if (fd < 0) {
            lastError = errno;
            continue;
        }

        int flags = fcntl(fd, F_GETFL, 0);
        if (flags < 0 || fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) {
            lastError = errno;
            close(fd);
            continue;
        }

        result = connect(fd, address->ai_addr, address->ai_addrlen);
        if (result < 0 && errno != EINPROGRESS) {
            lastError = errno;
            close(fd);
            continue;
        }

        client.socketFd = fd;
        client.state = MqttSocket_Connecting;
        client.rxSize = 0;
        if (!UpdateSocketEvents()) {
            DisconnectSocket();
            freeaddrinfo(addresses);
            return false;
        }
        freeaddrinfo(addresses);
        return true;
    }

    freeaddrinfo(addresses);
    Log_Debug(MQTT_MODULE "Cannot open a connection to %s:%u: %s.\n", client.host, client.port,
              strerror(lastError));
    return false;
}

bool MqttClient_IsConnected(void)
{
    return client.state == MqttSocket_Connected;
}

bool MqttClient_Publish(const char *topic, const char *payload, bool retained)
{
    if (!MqttClient_IsConnected() || topic == NULL || payload == NULL) {
        return false;
    }
    return QueuePublish(topic, payload, strlen(payload), retained);
}

bool MqttClient_Subscribe(const char *topic)
{
    if (!MqttClient_IsConnected() || topic == NULL) {
        return false;
    }
    return QueueSubscription(topic);
}

void MqttClient_HandleSocketEvent(EventData *eventData)
{
    if (eventData == NULL || client.socketFd < 0) {
        return;
    }

    if ((eventData->events & (EPOLLERR | EPOLLHUP | EPOLLRDHUP)) != 0) {
        DisconnectSocket();
        return;
    }
    if ((eventData->events & EPOLLOUT) != 0) {
        HandleSocketWritable();
    }
    if (client.socketFd >= 0 && (eventData->events & EPOLLIN) != 0) {
        HandleSocketReadable();
    }
}

void MqttClient_DoWork(void)
{
    if (client.state != MqttSocket_Connected) {
        return;
    }

    time_t now = time(NULL);
    if (client.pingOutstanding && now - client.lastPacketTime >= MQTT_KEEPALIVE_SECONDS * 2) {
        Log_Debug(MQTT_MODULE "ERROR: Broker did not respond to PINGREQ.\n");
        DisconnectSocket();
        return;
    }
    if (!client.pingOutstanding && now - client.lastPacketTime >= MQTT_KEEPALIVE_SECONDS / 2) {
        if (QueueSimplePacket(0xc0)) {
            client.pingOutstanding = true;
            client.lastPacketTime = now;
        } else {
            DisconnectSocket();
        }
    }
}

void MqttClient_Close(void)
{
    DisconnectSocket();
    client.epollFd = -1;
    client.messageHandler = NULL;
    client.connectionHandler = NULL;
}
