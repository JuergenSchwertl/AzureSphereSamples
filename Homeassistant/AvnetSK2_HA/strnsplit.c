#include <stdlib.h>
#include <string.h>



int strnsplit(char *pStr, char chDelimiter, char **ppStrArray, size_t nMaxSplits)
{
    if (pStr == NULL || ppStrArray == NULL || nMaxSplits == 0) {
        return -1;
    }

    while( *pStr != '\0' && *pStr == chDelimiter ) {
        pStr++; // Skip leading delimiters
    }

    if (*pStr == '\0') {
        return 0; // The string is empty or only contains delimiters
    }

    int nCount = 1; // At least one segment exists even if no delimiter is found
    ppStrArray[0] = pStr; // The first segment starts at the beginning of the input string

    while (*pStr != '\0' && nCount < nMaxSplits) {
        if (*pStr == chDelimiter) {
            *pStr = '\0'; // Replace the delimiter with a null terminator
            ppStrArray[nCount] = pStr + 1; // The next segment starts after the delimiter
            nCount++;
        }
        pStr++;
    }
    return nCount;
}