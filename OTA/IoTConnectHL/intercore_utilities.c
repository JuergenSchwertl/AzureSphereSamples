/* Copyright (c) Microsoft Corporation. All rights reserved.
   Licensed under the MIT License. */

	// This sample C utilities library for Azure Sphere sends messages to, and receives
	// responses from the real-time core.  
	// 
	//
	// It uses the following Azure Sphere libraries
	// - log (messages shown in Visual Studio's Device Output window during debugging);
	// - application (establish a connection with a real-time capable application).

#include <bits/alltypes.h>
#include <errno.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <string.h>

#include <applibs/log.h>
#include <applibs/application.h>

#include "intercore_utilities.h"
#include "epoll_timerfd_utilities.h"


	// Set timeout, to handle case where real-time capable application does not respond.
static const struct timeval recvTimeout = { .tv_sec = 5,.tv_usec = 0 };

// <summary>Helper function to print socket error and close socket</summary>
static void handleSocketError(InterCoreEventData * pIcEventData)
{
	Log_Debug("[InterCore] ERROR: Unable to send/receive message: %d (%s); closing socket.\n", errno, strerror(errno));
	InterCore_UnregisterHandler(pIcEventData);

	// Error: permission denied (app has been uninstalled)
	if (errno == EPERM) {
		pIcEventData->State = InterCoreState_AppNotInstalled;
	}
	// Error: connection reset (app exists but doesn't run; i.e. stopped state)
	if (errno == ECONNRESET)
	{
		pIcEventData->State = InterCoreState_AppUnresponsive;
	}
}

/// <summary>
///     Sends message to real-time capable application.
/// </summary>
/// <param name="pIcEventData">address of InterCoreEventData_t structure</param>
/// <param name="pMessage">pointer to message to transmit via inter-core mailslot</param>
/// <param name="nSize">number of bytes to send</param>
/// <returns>number of bytes sent or -1 on error</returns>
int InterCore_SendMessage(InterCoreEventData* pIcEventData, const void *pMessage, size_t nSize)
{
	if (pMessage == NULL || pIcEventData == NULL || pIcEventData->_evt.fd < 0)
	{
		return -1; // nothing to send or socket missing/closed
	}
	Log_Debug("[InterCore] Sending: %s\n", (const char *)pMessage);

	int bytesSent = send(pIcEventData->_evt.fd, pMessage, nSize, 0);
	if (bytesSent == -1) {
		handleSocketError(pIcEventData);
	}
	return bytesSent;
}

/// <summary>
///     Handle socket event by reading incoming data from real-time capable application.
/// </summary>
/// <param name="eventData">pointer to EventData structure containing eventContext</param>
static void intercoreEventHandler(InterCoreEventData * pIcEventData)
{
	// Read response from real-time capable application.
	char rxBuf[INTERCORE_RECV_BUFFER_SIZE];
	ssize_t bytesReceived = recv(pIcEventData->_evt.fd, rxBuf, sizeof(rxBuf), 0);
	Log_Debug("[InterCore] Received %d bytes.\n", bytesReceived);

	if( bytesReceived < 0 ) {
		handleSocketError( pIcEventData );
	}

	if( bytesReceived > 0 )	{
		pIcEventData->MessageHandler(pIcEventData, (const void *)rxBuf, bytesReceived);
	}
}

/// <summary>
///     Register event handler for incoming data from real-time capable application in ePoll.
/// </summary>
/// <param name="epollFd">epoll file descriptor</param>
/// <param name="pIcEventData">pointer to InterCoreEventData structure</param>
/// <returns>0 on success or -1 on error</returns>
int InterCore_RegisterHandler(int epollFd, InterCoreEventData * pIcEventData)
{
	int fdSocket = -1;
	pIcEventData->_evt.eventHandler = (EventHandler) &intercoreEventHandler;
	pIcEventData->State = InterCoreState_Unknown;
	pIcEventData->EpollFd = epollFd;

	// Open connection to real-time capable application.
	if ((fdSocket = Application_Socket(pIcEventData->ComponentId)) == -1) {
		if (errno == EACCES)
		{
			Log_Debug("[InterCore] App %s not available.\n", pIcEventData->ComponentId);
			pIcEventData->State = InterCoreState_AppNotInstalled;
		}
		else {
			Log_Debug("[InterCore] ERROR: Unable to create application socket for %s: %d (%s)\n", pIcEventData->ComponentId, errno, strerror(errno));
		}
		return -1;
	}

	int rcvlen;
	unsigned int m = sizeof(int);
	getsockopt(fdSocket, SOL_SOCKET, SO_RCVBUF, (void *)&rcvlen, &m);
	int sndlen;
	getsockopt(fdSocket, SOL_SOCKET, SO_SNDBUF, (void *)&sndlen, &m);
	Log_Debug("[InterCore] Length of receive buffer %d, send buffer %d", rcvlen, sndlen);

	int result = setsockopt(fdSocket, SOL_SOCKET, SO_RCVTIMEO, &recvTimeout, sizeof(recvTimeout));
	if (result == -1) {
		Log_Debug("[InterCore] ERROR: Unable to set socket timeout: %d (%s)\n", errno, strerror(errno));
		return -1;
	}

	// Register handler for incoming messages from real-time capable application.
	if (RegisterEventHandlerToEpoll(epollFd, fdSocket, (EventData *) pIcEventData, EPOLLIN) != 0) {
		return -1;
	}

	pIcEventData->State = InterCoreState_Unknown;
	pIcEventData->_evt.fd = fdSocket;
	return 0;
}

/// <summary>
/// Unregister InterCore event handler and close socket.
/// </summary>
/// <param name="pIcEventData">pointer to InterCoreEventData structure</param>
void InterCore_UnregisterHandler(InterCoreEventData * pIcEventData)
{
	UnregisterEventHandlerFromEpoll(pIcEventData->EpollFd, pIcEventData->_evt.fd);
	close(pIcEventData->_evt.fd);
	pIcEventData->_evt.fd = -1;
}

/// <summary>
/// Prepare InterCoreEventData structure.
/// </summary>
/// <param name="pIcEventData">pointer to InterCoreEventData structure</param>
void InterCore_Initialize(InterCoreEventData * pIcEventData)
{
	pIcEventData->_evt.fd = -1;
	pIcEventData->_evt.eventHandler = (EventHandler)&intercoreEventHandler;
	pIcEventData->State = InterCoreState_Unknown;
	pIcEventData->EpollFd = -1;
}