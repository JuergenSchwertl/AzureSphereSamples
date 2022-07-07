/**
* @file azure_iot_utilities.h
* @brief This header defines a sample interface for performing basic operations with an
* Azure IoT Hub Device Provisioning Service (DPS) using the low-level API layer 
* provided in the Azure IoT Device SDK for C.
*/
#pragma once
#ifndef _AZURE_IOT_DPS_H_
#define _AZURE_IOT_DPS_H_

#include <stdbool.h>
#include "azure_iot.h"

#define MAX_HUB_URI_LENGTH (512)
#define MAX_SCOPEID_LENGTH (32)

typedef enum  {
    AZURE_IOT_DPS_COMPLETED=0,
    AZURE_IOT_DPS_NOT_STARTED,
    AZURE_IOT_DPS_REGISTERING,
    AZURE_IOT_DPS_FAILED
} AZURE_IOT_DPS_STATUS;

typedef enum  {
    AZURE_IOT_HUB_CONNECTED=0,
    AZURE_IOT_HUB_DISCONNECTED,
    AZURE_IOT_HUB_AUTHENTICATING,
    AZURE_IOT_HUB_FAILED
} AZURE_IOT_HUB_STATUS;

/**
 * @brief 
 * @param status AZURE_IOT_HUB_STATUS with values AZURE_IOT_HUB_CONNECTED, ...DISCONNECTED, ...AUTHENTICATING, ...FAILED
 * @param iothub_uri IoT Hub address provisioned by DPS
 */
typedef void(*AZURE_IOT_DPS_REGISTRATION_CALLBACK)(AZURE_IOT_DPS_STATUS status, const char* iothub_uri);


/**
 * @brief Initializes DPS security factory (for DAA usage), provisioning client, 
 * sets options (incl Model Id) and starts RegisterDevice 
 * 
 * @param fdEpoll               epoll file descriptor for timers 
 * @param strPnPModelId         PnP Model Id (optional)
 */
int AzureIoT_DPS_Initialize(int fdEpoll, const char * strPnPModelId);

/**
 * @brief De-Initializes DPS-client and IoT Hub client and stops connection watchdog timer
 * 
 * @return int 0 on success, <1 on Error
 */
void AzureIoT_DPS_DeInitialize( void );

/**
 * @brief Starts the Azure IoT Hub Connection and keeps it up all the time
 * 
 * @return int int 0 on success, <1 on Error
 */
int AzureIoT_DPS_StartConnection(void );

/**
* @brief    Sets the DPS Scope ID.
*
* @param    cstrID      The Scope ID string (typically from command line)
*/
void AzureIoT_DPS_SetScopeID(const char* cstrID);


/**
 * @brief reads "--ScopeId" from command line
 * 
 * @param argc  main() command line argument count 
 * @param argv  main() command line arguments
 */
void AzureIoT_DPS_Options(int argc, char *argv[]);

#endif //#ifndef _AZURE_IOT_DPS_H_
