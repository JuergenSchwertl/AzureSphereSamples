#pragma once

#ifndef INTERCORE_UTILITIES_H
#define INTERCORE_UTILITIES_H

///<summary>Helper type containing the Component ID of the partner app and its socket file descriptor</summary>
typedef struct __intercorecomms_t {
	///<summary>Component ID of realtime capable application</summary>
	const char ComponentId[37];
	///<summary>Socket file descriptor of mailslot</summary>
	int SocketFd;
	///<summary>Message handler for incoming message</summary>
	IntercoreMessageHandler MessageHandler;
} InterCoreComms_t;


/// <summary>
///     Function signature for data received handlers.
/// </summary>
/// <param name="pstrComponentId">Component id of message sender</param>
/// <param name="pMessage">The received message</param>
/// <param name="nSize">number of bytes received</param>
typedef void (*IntercoreMessageHandler)(const char *pstrComponentId, void * pMessage, size_t nSize);


#endif // INTERCORE_UTILITIES_H