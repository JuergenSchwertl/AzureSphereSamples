#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "epoll_timerfd_utilities.h"

typedef void (*MqttMessageHandler)(const char *topic, const char *payload, size_t payloadSize,
                                   bool retained);
typedef void (*MqttConnectionHandler)(bool connected);

bool MqttClient_Init(int fdEpoll, int argc, char *argv[], MqttMessageHandler messageHandler,
                     MqttConnectionHandler connectionHandler);
bool MqttClient_Connect(void);
bool MqttClient_IsConnected(void);
bool MqttClient_Publish(const char *topic, const char *payload, bool retained);
bool MqttClient_Subscribe(const char *topic);
void MqttClient_HandleSocketEvent(EventData *eventData);
void MqttClient_DoWork(void);
void MqttClient_Close(void);
