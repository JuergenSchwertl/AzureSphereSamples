/**
 * @file azure_iot_central.c
 * @author Juergen Schwertl (jschwert@microsoft.com)
 * @brief This file contains function declaration for Azure IoT Central specific property handling.
 * 
 * @version 1.0
 * @date 2021-12-27
 * 
 * @copyright Copyright (c) 2021
 * 
 */


#include "azure_iot_central.h"
#include "azure_iot_pnp.h"
#include "azure_iot_json.h"
#include <applibs/log.h>

#define MODULE "[Iot Central] "

static const char cstrValueProperty[] = "value";
static const char cstrVersionProperty[] = "av";
static const char cstrStatusProperty[] = "ac";
//static const char cstrStatusDescriptionProperty[] = "ad";

/**
 * @brief helper function to create property value partial in form of e.g. { "value" : 21 } 
 * <a href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types" /> 
 * 
 * @param  pValue              address of a double, string or json value; NULL to set { "value" : null };
 * @param  jsonType            valid json value types are: JSONString, JSONObject, JSONNumber, JSONNull
 * @returns JSON_Value response
 */
static JSON_Value * createValueJson( void *pValue, JSON_Value_Type jsonType )
{

    JSON_Value  *jsonValue = json_value_init_object();
    if( jsonValue == NULL )
    {
        return NULL;
    }
    JSON_Object *jsonObject = json_value_get_object( jsonValue );

    // "value" property
    if( pValue == NULL || jsonType == JSONNull) {
        json_object_set_null( jsonObject, cstrValueProperty);
    } else {
        switch( jsonType )
        {
            case JSONString:
                json_object_set_string(jsonObject, cstrValueProperty, (const char *)pValue);
                break;
            case JSONNumber:
                json_object_set_number(jsonObject, cstrValueProperty, *(double *)pValue);
                break;
            case JSONBoolean:
                json_object_set_boolean(jsonObject, cstrValueProperty, *(int *)pValue);
                break;
            default:
                Log_Debug( MODULE "ERROR: unsupported JSON_Value_Type.");
                json_value_free( jsonValue );
                return( NULL );
        }
    }
    return jsonValue;
}

/**
 * @brief 
 * create writeable property json for Azure IoT Central in form of 
 * { "blinkRateProperty" : {    # property name
 *     "value" : 21.00          # property value 
 *   } 
 * }
 * <a href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types" /> 
 * 
 * @param  cstrPropertyName    property name
 * @param  pValue              address of a double, string or json value
 * @param  jsonType            valid json value types are: JSON_String, JSON_Object, JSON_Number
 * @returns JSON_Value response
 */
static JSON_Value * createWritablePropertyJson( const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType )
{
    if( cstrPropertyName == NULL )
    {
        Log_Debug( MODULE "ERROR in ...createWritablePropertyJson(): missing property name" );
        return NULL;
    }
 
    JSON_Value  *jsonValue = createValueJson( pValue, jsonType);
    JSON_Value  *jsonPropertyValue = json_value_init_object();
    if( jsonValue == NULL || jsonPropertyValue==NULL)
    {
        return NULL;
    }
    JSON_Object *jsonPropertyObject = json_value_get_object( jsonPropertyValue );
    json_object_set_value( jsonPropertyObject, cstrPropertyName, jsonValue );
    return jsonPropertyValue;
}

/**
 * @brief 
 * Create json to acknowledge desired pproerty change for Azure IoT Central in form of 
 * { "propertyName" : {    # property name
 *     "value" : 21.00          # property value 
 *     "av" : 1,                # property version
 *     "ac" : 200,              # status
 * }
 * <a href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types" /> 
 * 
 * @param  cstrPropertyName    property name
 * @param  pValue              address of a double, string or json value
 * @param  jsonType            valid json value types are: JSON_String, JSON_Object, JSON_Number
 * @param  nVersion            the desired property version
 * @param  nStatus             HTTP status value
 * @returns JSON_Value response
 */
static JSON_Value * createWriteablePropertyResponseJson( const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType, unsigned int nVersion, unsigned int nStatus )
{
 
    if( cstrPropertyName == NULL )
    {
        Log_Debug( MODULE "ERROR in ...createWriteablePropertyResponseJson(): missing property name" );
        return NULL;
    }
 
    JSON_Value  *jsonValue = createValueJson( pValue, jsonType);
    if( jsonValue==NULL )
    {
        return NULL;
    }
    JSON_Object *jsonObject = json_value_get_object( jsonValue );
    json_object_set_number(jsonObject, cstrVersionProperty, (double)nVersion ); // add "av" version property
    json_object_set_number(jsonObject, cstrStatusProperty, (double)nStatus );   // add "ac" status value
    JSON_Value  *jsonPropertyValue = json_value_init_object();
    JSON_Object *jsonPropertyObject = json_value_get_object( jsonPropertyValue );
    json_object_set_value( jsonPropertyObject, cstrPropertyName, jsonValue );
    return jsonPropertyValue;
}

/**
 * @brief Helper function to create a desired property change acknowledgement json.
 * { "componentName" : {          # component name
 *     "__t" : "c",               # component indicator
 *     "propertyname" : {         # property name
 *       "value" : 21.00          # property value 
 *       "av" : 1,                # property version
 *       "ac" : 200               # status
 *   } 
 * }
 * <a href="https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types" /> 
 * 
 * @param  cstrPropertyName    property name
 * @param  pValue              address of a double, string or json value
 * @param  jsonType            valid json value types are: JSON_String, JSON_Object, JSON_Number
 * @param  nVersion            the desired property version
 * @param  nStatus             HTTP status value
 * @returns JSON_Value response
 */
static JSON_Value * createComponentPropertyResponseJson( const char *cstrComponentName, const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType, unsigned int nVersion, unsigned int nStatus )
{
    JSON_Value  *jsonValue = createWriteablePropertyResponseJson( cstrPropertyName, pValue, jsonType, nVersion, nStatus);
    return  AzureIoT_PnP_CreateComponentPropertyJson( NULL, cstrComponentName, jsonValue);
}

IOTHUB_CLIENT_RESULT AzureIoTCentral_ReportWriteableProperty( const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType )
{
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;
    JSON_Value * jsonValue = createWritablePropertyJson(cstrPropertyName, pValue, jsonType);
    if( jsonValue != NULL )
    {
        result = AzureIoTJson_TwinReportState( jsonValue );
        json_value_free( jsonValue );
    }

    return result;
}

IOTHUB_CLIENT_RESULT AzureIoTCentral_ReportComponentWriteableProperty( const char *cstrComponentName, const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType )
{
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;
    JSON_Value * jsonValue = createWritablePropertyJson(cstrPropertyName, pValue, jsonType);
    JSON_Value * jsonComponentValue = AzureIoT_PnP_CreateComponentPropertyJson( NULL, cstrComponentName, jsonValue);;
    if( jsonValue != NULL )
    {
        result = AzureIoTJson_TwinReportState( jsonComponentValue );
        json_value_free( jsonComponentValue );
    }

    return result;
}

IOTHUB_CLIENT_RESULT AzureIoTCentral_AckPropertyChange( const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType, unsigned int nVersion, unsigned int nStatus )
{
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;
    JSON_Value * jsonValue = createWriteablePropertyResponseJson(cstrPropertyName, pValue, jsonType, nVersion, nStatus);
    if( jsonValue != NULL )
    {
        result = AzureIoTJson_SendMessage( jsonValue );
        json_value_free( jsonValue );
    }

    return result;
}

IOTHUB_CLIENT_RESULT AzureIoTCentral_AckComponentPropertyChange( const char * cstrComponentName, const char *cstrPropertyName, void *pValue, JSON_Value_Type jsonType, unsigned int nVersion, unsigned int nStatus )
{
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_ERROR;
    JSON_Value * jsonValue = createComponentPropertyResponseJson(cstrComponentName, cstrPropertyName, pValue, jsonType, nVersion, nStatus);
    if( jsonValue != NULL )
    {
        result = AzureIoTJson_TwinReportState( jsonValue );
        json_value_free( jsonValue );
    }

    return result;
}