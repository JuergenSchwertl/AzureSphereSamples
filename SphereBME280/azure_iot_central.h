/**
* @file azure_iot_central.h
* @brief This header defines helper functions for Azure IoT Central.
*   <a href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types">Azure IoT Central Docs</a> 
*/
#pragma once
#ifndef __AZURE_IOT_CENTRAL_H__
#define __AZURE_IOT_CENTRAL_H__

#include "azure_iot.h"

/**
 * @brief Helper function to acknowledge a writable (desired) property change for Azure IoT Central.
 * {"propertyname" : {         # property name
 *    "value" : 21.00          # property value 
 * }  } 
 *   <a href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types">Azure IoT Central Docs</a> 
 * @param  cstrPropertyName    property name
 * @param  pValue              address of a double, string or json value
 * @param  jsonType            valid json value types are: JSONString, JSONObject, JSONNumber, JSONNull
 * @returns IOTHUB_CLIENT_RESULT 
 */
IOTHUB_CLIENT_RESULT AzureIoTCentral_ReportWriteableProperty( const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType );


/**
 * @brief Helper function to acknowledge a writable (desired) property change for Azure IoT Central.
 * {"propertyname" : {         # property name
 *    "value" : 21.00          # property value 
 *    "av" : 1,                # property version
 *    "ac" : 200               # status
 * }  } 
 *   <a href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types">Azure IoT Central Docs</a> 
 * @param  cstrPropertyName    property name
 * @param  pValue              address of a double, string or json value
 * @param  jsonType            valid json value types are: JSONString, JSONObject, JSONNumber, JSONNull
 * @param  nVersion            the desired property version
 * @param  nStatus             HTTP status value
 * @returns IOTHUB_CLIENT_RESULT 
 */
IOTHUB_CLIENT_RESULT AzureIoTCentral_AckPropertyChange( const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType, unsigned int nVersion, unsigned int nStatus );

/**
 * @brief Helper function to acknowledge a component writable (desired) property change for Azure IoT Central.
 * { "componentName" : {          # component name
 *     "__t" : "c",               # component indicator
 *     "propertyname" : {         # property name
 *       "value" : 21.00          # property value 
 *       "av" : 1,                # property version
 *       "ac" : 200               # status
 * }  }  } 
 * <a href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types" /> 
 * @param  cstrComponentName   PnP component name
 * @param  cstrPropertyName    property name
 * @param  pValue              address of a double, string or json value
 * @param  jsonType            valid json value types are: JSONString, JSONObject, JSONNumber, JSONNull
 * @param  nVersion            the desired property version
 * @param  nStatus             HTTP status value
 * @returns IOTHUB_CLIENT_RESULT 
 */
IOTHUB_CLIENT_RESULT AzureIoTCentral_AckComponentPropertyChange( 
    const char * cstrComponentName, const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType, unsigned int nVersion, unsigned int nStatus );


#endif // AZURE_IOT_CENTRAL_H