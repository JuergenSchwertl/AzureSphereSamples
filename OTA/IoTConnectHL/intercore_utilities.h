#pragma once

#include <sys/epoll.h>
#include <intercore_messages.h>
#include "epoll_timerfd_utilities.h"

#define INTERCORE_RECV_BUFFER_SIZE	128

typedef struct InterCoreEventData InterCoreEventData;

/// <summary>
///     Function signature for data received handlers.
/// </summary>
/// <param name="pstrComponentId">Component id of message sender</param>
/// <param name="pMessage">The received message</param>
/// <param name="nSize">number of bytes received</param>
typedef void(*InterCoreMessageHandler)(InterCoreEventData * pIcEventData, const void * pMessage, ssize_t iSize);

//<summary>Enumeration of inter core communication states</summary>
typedef enum InterCoreState_t {
	//<summary>InterCoreEventData structure not initialized (default)</summary>
	InterCoreState_Uninitialized = 0,
	//<summary>Real time capable application not installed</summary>
	InterCoreState_AppNotInstalled = 1,
	//<summary>Real time capable application installed but unresponsive (maybe stopped)</summary>
	InterCoreState_AppUnresponsive = 2,
	//<summary>Real time capable application installed and responsive</summary>
	InterCoreState_AppActive = 3,
	//<summary>Initialized but unknown state yet</summary>
	InterCoreState_Unknown = 99
} InterCoreState;

//<summary>InterCoreEventData extends EventData with context data for inter core communication events</summary>
typedef struct InterCoreEventData {
	// EventData structure for epoll_timerfd_utilities. Do not change sequence!
	EventData _evt;
	///<summary>Component ID of realtime capable application</summary>
	const char ComponentId[37];
	///<summary>Message handler for incoming message</summary>
	InterCoreMessageHandler MessageHandler;
	///<summary>Status of intercore communications</summary>
	InterCoreState State;
	///<summary>The epoll instance</summary>
	int EpollFd;
} InterCoreEventData;

/// <summary>
///     Sends message to real-time capable application.
/// </summary>
/// <param name="pIcEventData">address of InterCoreEventData_t structure</param>
/// <param name="pMessage">pointer to message to transmit via inter-core mailslot</param>
/// <param name="nSize">number of bytes to send</param>
/// <returns>number of bytes sent or -1 on error</returns>
int InterCore_SendMessage(InterCoreEventData* pIcEventData, const void *pMessage, size_t nSize);


/// <summary>
///     Register event handler for incoming data from real-time capable application in ePoll.
/// </summary>
/// <param name="epollFd">epoll file descriptor</param>
/// <param name="pIcEventData">pointer to InterCoreEventData structure</param>
/// <returns>0 on success or -1 on error</returns>
int InterCore_RegisterHandler(int epollFd, InterCoreEventData * pIcEventData);

/// <summary>
/// Unregister InterCore event handler and close socket.
/// </summary>
/// <param name="pIcEventData">pointer to InterCoreEventData structure</param>
void InterCore_UnregisterHandler(InterCoreEventData * pIcEventData);

/// <summary>
/// Prepare InterCoreEventData structure.
/// </summary>
/// <param name="pIcEventData">pointer to InterCoreEventData structure</param>
void InterCore_Initialize(InterCoreEventData * pIcEventData);

