#pragma once

#ifndef INTERCORE_MESSAGES_H
#define INTERCORE_MESSAGES_H

#include <stdint.h>
#include "guid_utilities.h"

///<summary>Memory layout of intercore message</summary>
typedef struct 
{
	///<summary>16 bytes of binary Component ID</summary>
	GUID ComponentId;
	///<summary>4 fill bytes</summary>
	uint32_t Reserved;
	///<summary>Message_Header payload starts here</summary>
	uint8_t Payload[];
} InterCoreMessageLayout;

///<summary>Message header is 4 bytes (i.e. "PING" without terminator)</summary>
typedef union  { uint32_t MagicValue;  const char Text[4]; } InterCoreMessageHeader;

///<summary>Plain message only has header</summary>
typedef struct  { InterCoreMessageHeader Header; } InterCoreMessagePlain;

///<summary>Message has header and uint32 payload</summary>
typedef struct  { InterCoreMessageHeader Header; uint32_t Value; } InterCoreMessageUint32;

///<summary>Message has header and variable payload</summary>
typedef struct  { InterCoreMessageHeader Header; uint32_t Length; uint8_t Payload[]; } InterCoreMessageData;

///<summary>"PING" message header</summary>
extern const InterCoreMessageHeader InterCoreMessage_Ping;
///<summary>"ping" response message header</summary>
extern const InterCoreMessageHeader InterCoreMessage_PingResponse;
///<summary>"recv" response message header</summary>
extern const InterCoreMessageHeader InterCoreMessage_ReceivedResponse;
///<summary>"BLNK" message header</summary>
extern const InterCoreMessageHeader InterCoreMessage_BlinkInterval;

#endif // INTERCORE_MESSAGES_H