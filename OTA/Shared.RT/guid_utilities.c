#include "guid_utilities.h"

static const char achHex[] = "0123456789ABCDEF";

typedef struct Nibbles { uint8_t Low : 4; uint8_t High : 4; } Nibbles;
typedef union NibbleByte { uint8_t Byte; Nibbles Nibble; } NibbleByte;

///<summary>Converts GUID into string</summary>
///<param name="pGuid">Pointer to GUID structure</param>
///<param name="pGuid">Pointer to string buffer</param>
///<returns>Number of characters written (excluding `\0` character)</param>
int Guid_ToString(const GUID *pGuid, char * pStrOut)
{
	register uint8_t *pSrc = (uint8_t*)pGuid;
	register char *pDst = pStrOut;
	register int i;
	register NibbleByte nibblebyte;
	
	for (i = 3; i >= 0; i--) // int32 LITTLE_ENDIAN 78563412
	{
		nibblebyte.Byte = *(pSrc + i);
		*pDst++ = achHex[nibblebyte.Nibble.High];
		*pDst++ = achHex[nibblebyte.Nibble.Low];
	}
	*pDst++ = '-';
	for (i = 5; i >= 4; i--) // int16 LITTLE_ENDIAN 3412
	{
		nibblebyte.Byte = *(pSrc + i);
		*pDst++ = achHex[nibblebyte.Nibble.High];
		*pDst++ = achHex[nibblebyte.Nibble.Low];
	}
	*pDst++ = '-';
	for (i = 7; i >= 6; i--) // int16 LITTLE_ENDIAN 3412
	{
		nibblebyte.Byte = *(pSrc + i);
		*pDst++ = achHex[nibblebyte.Nibble.High];
		*pDst++ = achHex[nibblebyte.Nibble.Low];
	}
	*pDst++ = '-';
	for (i = 8; i <= 9; i++)
	{
		nibblebyte.Byte = *(pSrc + i);
		*pDst++ = achHex[nibblebyte.Nibble.High];
		*pDst++ = achHex[nibblebyte.Nibble.Low];
	}
	*pDst++ = '-';
	for (i = 10; i < 16; i++)
	{
		nibblebyte.Byte = *(pSrc + i);
		*pDst++ = achHex[nibblebyte.Nibble.High];
		*pDst++ = achHex[nibblebyte.Nibble.Low];
	}
	*pDst = '\0';
	return (int) (pDst-pStrOut);
}