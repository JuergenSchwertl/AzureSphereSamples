#include "guid_utilities.h"
#include <stdlib.h>
#include <stdbool.h>
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

uint32_t inline chConf(char chHex)
{
	return (uint32_t) (((chHex >= '0') && (chHex <= '9')) ? (chHex - '0') :
						((chHex >= 'A') && (chHex <= 'F')) ? (chHex - 'A') :
						((chHex >= 'a') && (chHex <= 'f')) ? (chHex - 'a') : 0xFF);
}

uint32_t htoi(const char* pStr, size_t nLength)
{
	uint32_t uiResult = 0;
	uint32_t nConvResult;
	while ((nLength-- > 0) && ((nConvResult = chConf(*pStr++)) < 16))
	{
		uiResult <<= 8;
		uiResult += nConvResult;
	}
	return uiResult;
}

bool Guid_Compare(const GUID* pLeft, const GUID* pRight)
{
	return (__builtin_memcmp((const void*)pLeft, (const void*)pRight, sizeof(GUID)) == 0);
}

bool Guid_TryParse(const char* pstrGuid, GUID * pGuid)
{
	if (pGuid == NULL)
	{
		return false;
	}
	if ((pstrGuid[8] != '-') ||
		(pstrGuid[13] != '-') ||
		(pstrGuid[18] != '-') ||
		(pstrGuid[23] != '-'))
	{
		return false;
	}

	
	pGuid->a = (int32_t)__builtin_bswap32( (unsigned int) htoi( &pstrGuid[0], 8) );
	pGuid->b = (int16_t) __builtin_bswap16( (unsigned short) htoi( &pstrGuid[9], 4) );
	pGuid->c = (int16_t) __builtin_bswap16( (unsigned short) htoi( &pstrGuid[14], 4));

	pGuid->d[0] = (uint8_t)htoi( &pstrGuid[19], 2);
	pGuid->d[1] = (uint8_t)htoi( &pstrGuid[21], 2);

	for( int i = 0; i < 6; i++)
	{
		pGuid->d[2+i] = (uint8_t)htoi( &pstrGuid[24+(i<<1)], 2);
	}

	return true;
}