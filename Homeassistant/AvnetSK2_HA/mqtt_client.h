#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "epoll_timerfd_utilities.h"

/// @brief Callback invoked for received MQTT commands. The command payload is not null-terminated, 
/// so the payload size must be used to process the payload.
typedef  void (MqttCommandHandler)(const char *pszPayload, size_t nPayloadSize);

/// @brief Callback invoked for received MQTT publishes. The payload is not null-terminated,
/// so the payload size must be used to process the payload.
typedef void (*MqttMessageHandler)(const char *topic, const char *payload, size_t payloadSize,
                                   bool retained);

/// @brief Callback invoked when the MQTT broker connection state changes.
typedef void (*MqttConnectionHandler)(bool connected);

/// @brief MQTT command structure used to register commands and their handlers.
typedef struct MqttCommandType {
    /// @brief MQTT command name.
    const char *pszCommand;
    /// @brief Pointer to the command handler function.
    MqttCommandHandler *pfnCommandHandler;
    /// @brief (private) MQTT topic name. Created by MqttClient_SubscribeCommands(). 
    const char *pszTopicName;
} MqttCommand;


bool MqttClient_Init(int fdEpoll, int argc, char *argv[], MqttMessageHandler messageHandler,
                     MqttConnectionHandler connectionHandler, MqttCommand *aCommands, size_t nCommandsCount);
bool MqttClient_InitDeviceId(void);
void MqttClient_Reconnect(struct mqtt_client *mqtt, void **reconnectState);
bool MqttClient_IsConnected(void);
bool MqttClient_Publish(const char *topic, const char *payload, bool retained);
bool MqttClient_Subscribe(const char *topic);
void MqttClient_HandleSocketEvent(EventData *eventData);
void MqttClient_DoWork(void);
void MqttClient_Close(void);
