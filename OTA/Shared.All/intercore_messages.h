#pragma once

#ifndef INTERCORE_MESSAGES_H
#define INTERCORE_MESSAGES_H


///<summary>Memory layout of intercore message</summary>
typedef struct InterCoreMessageLayout
{
	///<summary>16 bytes of binary Component ID</summary>
	GUID ComponentId;
	///<summary>4 fill bytes</summary>
	uint32_t Reserved;
	///<summary>Message_Header payload starts here</summary>
	uint8_t Payload[];
} InterCoreMessageLayout;

///<summary>Message header is 4 bytes (i.e. "PING" without terminator)</summary>
typedef union InterCoreMessageHeader { uint32_t MagicValue;  const char Text[4]; } InterCoreMessageHeader;

///<summary>Plain message only has header</summary>
typedef struct InterCoreMessagePlain { InterCoreMessageHeader Header; } InterCoreMessagePlain;

///<summary>Message has header and uint32 payload</summary>
typedef struct InterCoreMessageUint32 { InterCoreMessageHeader Header; uint32_t Value; } InterCoreMessageUint32;

///<summary>Message has header and variable payload</summary>
typedef struct InterCoreMessageUint32 { InterCoreMessageHeader Header; uint32_t Length; uint8 Payload[] } InterCoreMessageUint32;


#endif