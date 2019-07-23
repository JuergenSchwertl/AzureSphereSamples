/* Copyright (c) Microsoft Corporation. All rights reserved.
   Licensed under the MIT License. */

	// This sample C utilities library for Azure Sphere sends messages to, and receives
	// responses from the real-time core.  
	// 
	//
	// It uses the following Azure Sphere libraries
	// - log (messages shown in Visual Studio's Device Output window during debugging);
	// - application (establish a connection with a real-time capable application).

#include <errno.h>
#include <sys/time.h>
#include <sys/socket.h>

#include <applibs/log.h>
#include <applibs/application.h>

#include "intercore_utilities.h"
#include "epoll_timerfd_utilities.h"

// Component IDs of realtime capable partner apps
static const char strRedSphereComponentID[] = "F4E25978-6152-447B-A2A1-64577582F327";
static const char strGreenSphereComponentID[] = "7E5FAB32-801C-4EDF-A1AA-9263652AA6BD";
static const char strBlueSphereComponentID[] = "07562362-3FEC-46C8-B0AF-DB9507F32748";

// List of component id's and socket file descriptors this high-level app knows about
static InterCoreComms_t iccRedSphere = {
	.ComponentId = "F4E25978-6152-447B-A2A1-64577582F327",
	.SocketFd = -1,
	.MessageHandler = NULL
};

static InterCoreComms_t iccGreenSphere = { 
	.ComponentId = "7E5FAB32-801C-4EDF-A1AA-9263652AA6BD",
	.SocketFd = -1,
	.MessageHandler = NULL };

static InterCoreComms_t iccBlueSphere = { 
	.ComponentId = "07562362-3FEC-46C8-B0AF-DB9507F32748",
	.SocketFd = -1,
	.MessageHandler = NULL };

static const int nMaxComponent = sizeof(Components) / sizeof(InterCoreComms_t);

IntercoreMessageHandler fnHandleMessage = NULL;

// <summary>Helper function to print socket error and close socket</summary>
static void handleSocketError(InterCoreComms_t* pComm)
{
	Log_Debug("[InterCore] : ERROR: Unable to send/receive message: %d (%s); closing socket.\n", errno, strerror(errno));
	close(pComm->SocketFd);
	pComm->SocketFd = -1;
}

/// <summary>
///     Sends message to real-time capable application.
/// </summary>
/// <param name="pComm">address of InterCoreComms_t structure containing socket file descriptor</param>
/// <param name="pMessage">pointer to message to transmit via inter-core mailslot</param>
/// <param name="nSize">number of bytes to send</param>
static int InterCore_SendMessage(InterCoreComms_t* pComm, const void *pMessage, size_t nSize)
{
	if (pMessage == NULL || pComm == NULL || pComm->SocketFd < 0)
	{
		return -1; // nothing to send or socket missing/closed
	}
	Log_Debug("[InterCore] Sending: %s\n", (const char *)pMessage);

	int bytesSent = send(pComm->SocketFd, pMessage, nSize, 0);
	if (bytesSent == -1) {
		handleSocketError(pComm);
	}
	return bytesSent;
}

/// <summary>
///     Handle socket event by reading incoming data from real-time capable application.
/// </summary>
static void socketEventHandler(EventData* eventData)
{
	// Read response from real-time capable application.
	char rxBuf[32];
	int bytesReceived = recv(eventData->fd, rxBuf, sizeof(rxBuf), 0);

	if (bytesReceived == -1) {
		handleSocketError( (InterCoreComms_t *) eventData->eventContext );
	}

	Log_Debug("[InterCore] Received %d bytes.\n", bytesReceived);
}

static void registerIntercoreCommsHandler(int epollFd, InterCoreComms_t * pComm)
{
	// Open connection to real-time capable application.
	if ((pComm->SocketFd = Application_Socket(pComm->ComponentId)) == -1) {
		Log_Debug("ERROR: Unable to create socket: %d (%s)\n", errno, strerror(errno));
		return -1;
	}

	// Set timeout, to handle case where real-time capable application does not respond.
	static const struct timeval recvTimeout = { .tv_sec = 5,.tv_usec = 0 };
	int result = setsockopt(pComm->SocketFd, SOL_SOCKET, SO_RCVTIMEO, &recvTimeout, sizeof(recvTimeout));
	if (result == -1) {
		Log_Debug("ERROR: Unable to set socket timeout: %d (%s)\n", errno, strerror(errno));
		return -1;
	}

	// Register handler for incoming messages from real-time capable application.
	if (RegisterEventHandlerToEpoll(epollFd, pComm->SocketFd, &socketEventData, EPOLLIN) != 0) {
		return -1;
	}

}

static int InterCore_RegisterHandler(int epollFd, IntercoreMessageHandler fnHandler)
{
	fnHandleMessage = fnHandler;
	RegisterEventHandlerToEpoll( epollFd, )
}