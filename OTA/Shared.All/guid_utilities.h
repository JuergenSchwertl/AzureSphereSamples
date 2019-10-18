/* Copyright (c) Microsoft Corporation. All rights reserved.
   Licensed under the MIT License. */

#ifndef GUID_UTILITIES_H
#define GUID_UTILITIES_H

#include <stdbool.h>
#include <stdint.h>

/// <summary>Format is 12345678-1234-1234-1234-56789abcdef0 but memory format is little endian
///0x78 0x56 0x34 0x12 - 0x34 0x12 - 0x34 0x12 - 0x12 0x34 - 0x56 0x78 0x9a 0xbc 0xde 0xf0</summary>
typedef struct GUID
{
	/// <summary>int32 LITTLE_ENDIAN 78563412</summary>
	int32_t a;
	/// <summary>int16 LITTLE_ENDIAN 3412</summary>
	int16_t b;
	/// <summary>int32 LITTLE_ENDIAN 3412</summary>
	int16_t c;
	/// <summary>remaining 2+6 bytes 1234-123456789ab</summary>
	uint8_t d[8];
} GUID;


///<summary>Converts GUID into string</summary>
///<param name="pGuid">Pointer to GUID structure</param>
///<param name="pStrOut">Pointer to string buffer</param>
///<returns>Number of characters written (excluding `\0` character)</returns>
int Guid_ToString(const GUID* pGuid, char* pStrOut);

///<summary>Compares two GUIDs</summary>
///<param name="pLeft">Pointer to left GUID structure</param>
///<param name="pRight">Pointer to string buffer</param>
///<returns>true if left and right GUIDs are identical</returns>
bool Guid_Compare(const GUID* pLeft, const GUID* pRight);

///<summary>Parses a GUID string to a binary GUID structure</summary>
///<param name="pstrGuid">Pointer to GUID string</param>
///<param name="pGuid">Pointer to GUID buffer receiving parsed guid</param>
///<returns>true if parsed successfully</returns>
bool Guid_TryParse(const char* pstrGuid, GUID* pGuid);

#endif // #ifndef GUID_UTILITIES_H
