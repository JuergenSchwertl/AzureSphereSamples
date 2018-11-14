#pragma once

#include <stdlib.h>
#include "parson.h"

///<summary>
///		Parses received MCU data to extract data values and reports to IoT Hub as needed.
///</summary>
///<param name="pszLine">Address of received MCU data.</param>
///<param name="nLineLength">Length of received MCU data.</param>
void MCU_ParseDataToIotHub(char *pszLine, size_t nLineLength);

///<summary>
///		Parses received desired property changes.
///</summary>
///<param name="desiredProperties">Address of desired properties JSON_Object</param>
void MCU_DeviceTwinChangedHandler(JSON_Object * desiredProperties);
