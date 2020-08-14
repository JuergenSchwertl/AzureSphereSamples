#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <time.h>

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"
#include <applibs/gpio.h>
#include <applibs/log.h>

#include "MCU_utilities.h"
#include "azure_iot_utilities.h"

/// <summary>
/// MCU_utilities.c demonstrates how to extract MCU delivered data values and how to send temeletry to IoT Hub
/// once a temperature threshold between two readings is exceeded.
/// The temperature threshold can be cloud controlled using a device twin desired property "TemperatureChange"
/// i.e. using DeviceExplorer to send 
/// <example>
///		{ "properties": { "desired": { "TemperatureChange": 2.5 } } }
/// </example>
/// It also reports minimum and maximum temperatures within a session as device twin reported properties
/// once the last temperature reading exceeds the current boundaries. <see cref="checkAndUpdateDeviceTwin"/>
/// </summary>


#define JSON_BUFFER_SIZE 128

///<summary>The minimum temperature change to report telemetry data</summary>
static float fTemperatureChange = 2.0F;

typedef struct min_max {
	float Mininum;
	float Maximum;
} min_max_t;

static float fTemperature = NAN;
static float fTemperatureLastReported = NAN;
static float fHumidity = NAN;
static float fHumidityLastReported = NAN;
static min_max_t minmaxTemperature = { NAN, NAN };

static const char cstrTemperatureKey[] = "Temperature";
static const char cstrHumidityKey[] = "Humidity";
static const char cstrKeyValuePairDelimiter[] = ";";
static const char cstrKeyValueSeparator[] = ":";
static const char cstrTemperatureChangeKey[] = "TemperatureChange";

static const char cstrDeviceTelemetryJson[] = "{\"timestamp\":\"%s\",\"Temperature\":%.2f,\"Humidity\":%.2f}";
static const char cstrDeviceTwinJson[] = "{\"TemperatureMinimum\":%.2f,\"TemperatureMaximum\":%.2f}";

/// <summary>
///     Parses Keys and extracts the temperature/humidity values accordingly
/// </summary>
/// <param name="pszKey">Key name.</param>
/// <param name="pszValue">Value as string.</param>
bool parseKeyValue(char * pszKey, char * pszValue)
{
	if (strncmp(pszKey, cstrTemperatureKey, sizeof(cstrTemperatureKey)) == 0) {
		fTemperature = (float)atof(pszValue);
		return true;
	}
	else if (strncmp(pszKey, cstrHumidityKey, sizeof(cstrHumidityKey)) == 0) {
		fHumidity = (float)atof(pszValue);
		return true;
	}

	return false;
}


/// <summary>
///     Parses incoming Uart data from secondary MCU extracting key value pairs
/// </summary>
/// <param name="pszLine">data string read from MCU.</param>
/// <param name="nLineLength">length of data string read from MCU.</param>
void parseMessage(char *pszLine, size_t nLineLength)
{
	//Split the data coming in from the MCU board as "key:value;key:value"
	char *pchSavePair;
	char *pchPair = strtok_r(pszLine, cstrKeyValuePairDelimiter, &pchSavePair);
	while (pchPair != NULL) {
		char *pchSaveKeyValue;
		char *pchKey = strtok_r(pchPair, cstrKeyValueSeparator, &pchSaveKeyValue);
		char *pchValue = strtok_r(NULL, cstrKeyValueSeparator, &pchSaveKeyValue);
		if (pchKey != NULL && pchValue != NULL) {
			parseKeyValue(pchKey, pchValue);
		}
		pchPair = strtok_r(NULL, cstrKeyValuePairDelimiter, &pchSavePair);
	}
}

///<summary>
///		checks if received temperature value is large enough to send new telemetry message to IoT hub
///</summary>
void checkAndSendTelemetry( void )
{
	// if the temperatur change is big enough, we send telemetry data
	if ( isnan(fTemperatureLastReported) || __islessf(fTemperatureChange, fabsf(fTemperature - fTemperatureLastReported))) {

		char *pjsonBuffer = (char *)malloc(JSON_BUFFER_SIZE);
		if (pjsonBuffer == NULL) {
			Log_Debug("ERROR: not enough memory to send Temperature/Humitidy telemetry");
		}

		// create ISO timestamp as "yyyy-mm-ddThh:mm:ssZ"
		char isoTime[22];
		time_t rawtime;
		struct tm * ptm;
		time(&rawtime);
		ptm = gmtime(&rawtime);
		strftime(isoTime, sizeof(isoTime), "%FT%TZ", ptm);

		// send message to IoTHub
		snprintf(pjsonBuffer, JSON_BUFFER_SIZE, cstrDeviceTelemetryJson, isoTime, fTemperature, fHumidity);
		fTemperatureLastReported = fTemperature;
		fHumidityLastReported = fHumidity;

		Log_Debug("[MCU] Sending telemetry %s\n", pjsonBuffer);
		AzureIoT_SendMessageWithContentType(pjsonBuffer, ContentType.Application_JSON, ContentEncoding.UTF_8);

		free(pjsonBuffer);
	}
}

///<summary>
///		checks if received temperature exceeds previous temperature bounds and updates desired properties accordingly
///</summary>
void checkAndUpdateDeviceTwin(void)
{
	bool bIsTwinReportNeeded = false;

	if (isnan(minmaxTemperature.Mininum) || isnan(minmaxTemperature.Maximum)) {
		bIsTwinReportNeeded = true;
		minmaxTemperature.Mininum = fTemperature;
		minmaxTemperature.Maximum = fTemperature;
	}

	if (fTemperature < minmaxTemperature.Mininum) {
		bIsTwinReportNeeded = true;
		minmaxTemperature.Mininum = fTemperature;
	}

	if (fTemperature > minmaxTemperature.Maximum) {
		bIsTwinReportNeeded = true;
		minmaxTemperature.Maximum = fTemperature;
	}

	if (bIsTwinReportNeeded) {
		char *pjsonBuffer = (char *)malloc(JSON_BUFFER_SIZE);
		if (pjsonBuffer == NULL) {
			Log_Debug("ERROR: not enough memory to report device twin changes.");
		}

		// report temperature minimum and maximum as reported properties IoTHub
		int nJsonLength = snprintf(pjsonBuffer, JSON_BUFFER_SIZE, cstrDeviceTwinJson, 
								   minmaxTemperature.Mininum, minmaxTemperature.Maximum);

		Log_Debug("[MCU] Updating device twin: %s\n", pjsonBuffer);
		AzureIoT_TwinReportState(pjsonBuffer, (size_t) nJsonLength);

		free(pjsonBuffer);
	}
}


///<summary>
///		Parses received MCU data to extract data values and reports to IoT Hub as needed.
///</summary>
///<param name="pszLine">Address of received MCU data.</param>
///<param name="nLineLength">Length of received MCU data.</param>
void MCU_ParseDataToIotHub(char *pszLine, size_t nLineLength)
{
	fTemperature = NAN;
	fHumidity = NAN;

	parseMessage(pszLine, nLineLength);
	if (!isnan(fTemperature) && !isnan(fHumidity)) {

		checkAndSendTelemetry();
		checkAndUpdateDeviceTwin();

	}
}

///<summary>
///		Parses received desired property changes.
///</summary>
///<param name="desiredProperties">Address of desired properties JSON_Object</param>
void MCU_DeviceTwinChangedHandler(JSON_Object * desiredProperties)
{

	if (json_object_has_value(desiredProperties, cstrTemperatureChangeKey) != 0)
	{
		
		fTemperatureChange = (float) json_object_get_number(desiredProperties, cstrTemperatureChangeKey);
		
		Log_Debug("Received device update. New TemperatureChange is %0.2f ", fTemperatureChange);
	}
}