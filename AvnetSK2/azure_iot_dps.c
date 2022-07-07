

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <time.h>

#include <azure_prov_client/iothub_security_factory.h>
#include <azure_prov_client/prov_device_ll_client.h>
#include <azure_prov_client/prov_security_factory.h>
#include <azure_prov_client/prov_transport_mqtt_client.h>
#include <azureiot/azure_sphere_provisioning.h>
#include <azureiot/iothub_device_client_ll.h>
#include <azureiot/iothub_client_options.h>
#include <azureiot/iothubtransportmqtt.h>
#include <azureiot/iothub.h>

#include <applibs/application.h>
#include <applibs/log.h>
#include <applibs/networking.h>

#include "epoll_timerfd_utilities.h"
#include "azure_iot_dps.h"
#define MODULE "[DPS] "

/// @brief Enable IoT SDK tracing
bool bTraceOn = true;

/// @brief IoT Hub Client Handle is kept in azure_iot.c
extern IOTHUB_DEVICE_CLIENT_LL_HANDLE hIoTHubClient;

/// @brief List of low level IoT Hub callbacks is kept in azure_iot.c
extern iothub_LL_callbacks_t lstIotHubCallbacks;


bool dpsRegisterDevice( void );
void dpsCleanup( void );
bool hubInitialize( void );
void  hubCleanup( void );

/// @brief  DPS device registration status
static AZURE_IOT_DPS_STATUS dpsRegisterStatus = AZURE_IOT_DPS_NOT_STARTED;

/// @brief  IoT Hub connection status
static AZURE_IOT_HUB_STATUS hubConnectionStatus = AZURE_IOT_HUB_DISCONNECTED;
/// @brief  handle to provisioning client
PROV_DEVICE_LL_HANDLE hProvDevice = NULL;

/// @brief Set the keepalive period over MQTT to 20 seconds
static int iKeepalivePeriodSeconds = 20;


/// @brief  max size of PnP Model Id payload "{'modelid':'dtmi:...]'}" 
#define MAX_MODEL_ID_BUFFER_SIZE (512)

/// @brief  Json format for PnP Model Id payload on device registration
static const char cstrModelIdJsonFmt[] = "{\"modelId\":\"%s\"}";

/// @brief  Azure PnP Model Id is typically hardcoded in main. Just store reference here.
static const char *cstrPnPModelId = NULL;

/// @brief  Globally unique DPS Uri "global.azure-devices-provisioning.net"
static const char cstrDpsUri[] = "global.azure-devices-provisioning.net";

/// @brief  DPS device provisioning error message with one %s parameter
static const char cstrErrorDpsProvisioningFmt[] = MODULE "ERROR: device provisioning failed with %s "; 
/// IoT Hub options error  message with two %s parameters
static const char cstrErrorIoTHubSetOptionFmt[] = MODULE "ERROR: setting IoT Hub option '%s' failed with %s "; 

/// DPS Scope ID. Filled on app start via command line parameter or static string so keep ptr only.
static const char * cstrScopeId = NULL; 

/// IoT Hub Uri.
static char strIotHubUri[MAX_HUB_URI_LENGTH]; 

/// @brief IoT Hub option to set device id
static const char * OPTION_SET_DEVICE_ID = "SetDeviceId";

/// null period to disarm timer
static const struct timespec tsNullPeriod = {0,0};

/// DPS registration doWork polling period
static const struct timespec tsDpsPollPeriod = {1, 0};
/// @brief (Forward declared) dpsPollingHandler checks regularly for device registration progress
/// @param eventData timer event data 
static void dpsPollingHandler(EventData* eventData);
/// @brief EventData structure for DPS polling timer
static EventData evtDpsPollingTimer = { .eventHandler = &dpsPollingHandler, .fd = -1, .context=NULL };

/// DPS timeout timer
static const struct timespec tsDpsTimeoutPeriod = {30, 0};
/// @brief (Forward declared) dpsTimeoutHandler closes device registation after extended timeout 
/// @param eventData timer event data 
static void dpsTimeoutHandler(EventData* eventData);
/// @brief EventData structure for DPS timeout timer
static EventData evtDpsTimeoutTimer = { .eventHandler = &dpsTimeoutHandler, .fd = -1, .context=NULL };

/// Azure IoT Hub connection polling period (100ms)
static const struct timespec tsConnectionTimerPeriod = {0, 100*1000*1000};
/// @brief (Forward declared) connectionTimerHandler checks regularly for network and connection 
///     status and initiates DPS registration or IoT Hub connection
/// @param eventData timer event data 
static void connectionTimerHandler(EventData* eventData);
/// @brief EventData structure for connection timer handler
static EventData evtConnectionTimer = { .eventHandler = &connectionTimerHandler, .fd = -1, .context=NULL };

/// @brief In case of connection error, extend retry wait time
static const int iConnectionRetryMinWaitSeconds = 5;
static const int iConnectionRetryMaxWaitSeconds = 240;
static int iConnectionRetrySeconds = iConnectionRetryMinWaitSeconds;


MU_DEFINE_ENUM_STRINGS_WITHOUT_INVALID(PROV_DEVICE_RESULT, PROV_DEVICE_RESULT_VALUE);
MU_DEFINE_ENUM_STRINGS_WITHOUT_INVALID(PROV_DEVICE_REG_STATUS, PROV_DEVICE_REG_STATUS_VALUES);

/// @brief    Periodically outputs a provided format string with a variable number of arguments.
/// 
/// @param    lastInvokedTime Pointer where to store the 'last time this function has been
///         invoked' information
/// @param    periodInSeconds The desired period of the output
/// @param    format  The format string
static void periodicLogVarArgs(time_t *lastInvokedTime, time_t periodInSeconds, const char *format,
                               ...)
{
    struct timespec ts;
    int timeOk = timespec_get(&ts, TIME_UTC);
    if (!timeOk) {
        return;
    }

    if (ts.tv_sec > *lastInvokedTime + periodInSeconds) {
        va_list args;
        va_start(args, format);
        Log_DebugVarArgs(format, args);
        va_end(args);
        *lastInvokedTime = ts.tv_sec;
    }
}


/**
 * @brief Check networking and DAA status before connection
 * 
 * @return true     True if networking and DAA are ready
 */
static bool isNetworkReady(void)
{
    static time_t tmNetworkReady = 0;

    bool isNetworkingReady = false;

    // Verifies networking on device
    if (Networking_IsNetworkingReady(&isNetworkingReady) != 0) {
        Log_Debug("[Networking] ERROR: Networking_IsNetworkingReady: %d (%s)\n", errno, strerror(errno));
        return false;
    }

    if (!isNetworkingReady) {
        periodicLogVarArgs(&tmNetworkReady, 5, MODULE "INFO: networking not ready.\n");
        return false;
    }

    // Verifies authentication is ready on device
    bool isDeviceAuthReady = false;
    if (Application_IsDeviceAuthReady(&isDeviceAuthReady) != 0) {
        Log_Debug("[Application] ERROR: Application_IsDeviceAuthReady: %d (%s)\n", errno, strerror(errno));
        return false;
    }

    if (!isDeviceAuthReady) {
        periodicLogVarArgs(&tmNetworkReady, 5, MODULE "INFO: Device authentication not ready.\n");
        return false;
    }

    return true;
}


/// @brief Regularly calls low level provisioning doWork handler  
/// @param eventData Polling handler event data (with timer file descriptor)
static void dpsPollingHandler(EventData* eventData)
{
    if (ConsumeTimerFdEvent(eventData->fd) != 0) {
        return;
    }

    Prov_Device_LL_DoWork(hProvDevice);

    if( dpsRegisterStatus != AZURE_IOT_DPS_REGISTERING )
    {
        // it's now safe to cleanup DPS memory footprint and disarm the timers
        dpsCleanup();
        if( dpsRegisterStatus == AZURE_IOT_DPS_COMPLETED )
        {
            // We initialize IoT Hub Client *after* DPS client de-initialisation
            // On constrained devices this reduces memory footprint
            hubInitialize();
        }
    }
}


/// @brief Outer timeout handler for dps registration  
/// @param eventData Polling handler event data (with timer file descriptor)
static void dpsTimeoutHandler(EventData* eventData)
{
    if (ConsumeTimerFdEvent(eventData->fd) != 0) {
        return;
    }

    Log_Debug(MODULE "ERROR: DPS registration timeout.\n");

    dpsRegisterStatus = AZURE_IOT_DPS_FAILED;
    dpsCleanup();
}




/**
 * @brief (Optional) callback to log status information about device registration progress
 * 
 * @param reg_status 
 * @param user_context 
 */
static void dpsRegisterDeviceStatusCallback(PROV_DEVICE_REG_STATUS reg_status, void* user_context)
{
    Log_Debug(MODULE "INFO: DPS register device status %s ...\n", PROV_DEVICE_REG_STATUSStrings(reg_status));
}


/**
 * @brief  Callback that gets invoked on device registration for provisioning. On successful
 *  DPS registration it sets IoT Hub Uri and immediately returns after setting _COMPLETED state.
 *  You SHOULD NOT de-initialize DPS client here since this callback is invoked by the DPS client.
 *  See dpsPollingHandler() for DPS client de-initialisation and invocation for IoT Hub connection.    
 * 
 * @param registerResult PROV_DEVICE_RESULT of device registration
 * @param iothub_uri     IoT Hub DNS Uri if registerResult is PROV_DEVICE_RESULT_OK
 * @param deviceId       Device name (1 for Azure Sphere!)
 * @param userContext    User provided context from Prov_Device_LL_Register_Device call
 */
static void dpsRegisterDeviceCallback(PROV_DEVICE_RESULT registerResult, const char *iothub_uri,
                                   const char *deviceId, void *userContext)
{
    if (registerResult == PROV_DEVICE_RESULT_OK) {
        if( MAX_HUB_URI_LENGTH > strnlen(iothub_uri, MAX_HUB_URI_LENGTH) )
        {
            strcpy( strIotHubUri, iothub_uri );
            Log_Debug(MODULE "INFO: DPS register device succeeded. IoT Hub is %s\n", iothub_uri);
            dpsRegisterStatus = AZURE_IOT_DPS_COMPLETED;
            return;
        } else {
            registerResult = PROV_DEVICE_RESULT_INVALID_ARG;
        }
    }
    dpsRegisterStatus = AZURE_IOT_DPS_FAILED;
    Log_Debug(MODULE "ERROR: DPS register device failed with %s\n", PROV_DEVICE_RESULTStrings(registerResult));
}

/**
* @brief    Internal Callback function invoked whenever the connection status to IoT Hub changes.
* 
* @param    result              Current authentication status
* @param    reason              result's specific reason
* @param    userContextCallback User specified context
*/
static void hubConnectionStatusCallback(IOTHUB_CLIENT_CONNECTION_STATUS result,
                                        IOTHUB_CLIENT_CONNECTION_STATUS_REASON reason,
                                        void *userContextCallback)
{
    if( result == IOTHUB_CLIENT_CONNECTION_AUTHENTICATED ){
        hubConnectionStatus = AZURE_IOT_HUB_CONNECTED;
        iConnectionRetrySeconds = iConnectionRetryMinWaitSeconds;
    } else {
        hubConnectionStatus = AZURE_IOT_HUB_FAILED;
    }

    if( lstIotHubCallbacks.ConnectionStatusChangedHandler )
    {
        lstIotHubCallbacks.ConnectionStatusChangedHandler( result, reason, userContextCallback );
    }
}

/// @brief for better readability, wrap repetitive error checking/reporting into macro 
#define CHECK_PROV_RESULT_AND_REPORT_ERROR(msg) if(PROV_DEVICE_RESULT_OK != result){ \
        Log_Debug(cstrErrorDpsProvisioningFmt, msg, PROV_DEVICE_RESULTStrings(result)); \
        goto cleanup; \
    }


/**
 * @brief Initializes DPS security factory (for DAA usage), provisioning client, 
 * sets options, PnP Model Id and starts RegisterDevice 
 */
bool dpsRegisterDevice( void )
{
    PROV_DEVICE_RESULT result;
    dpsRegisterStatus = AZURE_IOT_DPS_NOT_STARTED;
    Log_Debug(MODULE "INFO: Initializing DPS registration for scope ID %s using PnP ID '%s'\n", cstrScopeId, cstrPnPModelId);

    // Initiate security with X509 Certificate
    if (0 != prov_dev_security_init(SECURE_DEVICE_TYPE_X509)) {
        Log_Debug(MODULE "ERROR: Failed to initiate X509 Certificate security\n");
        goto cleanup;
    }

    // Create Provisioning Client for communication with DPS requires MQTT protocol for IoT PnP
    hProvDevice = Prov_Device_LL_Create(cstrDpsUri, cstrScopeId, Prov_Device_MQTT_Protocol);
    if (NULL == hProvDevice) {
        Log_Debug(MODULE "ERROR: Failed to create Provisioning Client\n");
        goto cleanup;
    }

    // Use DAA cert in provisioning flow - requires the SetDeviceId option to be set on the
    // provisioning client.
    static const int deviceIdForDaaCertUsage = 1;
    result = Prov_Device_LL_SetOption(hProvDevice, "SetDeviceId", &deviceIdForDaaCertUsage);
    CHECK_PROV_RESULT_AND_REPORT_ERROR("set Device ID");

    if( NULL != cstrPnPModelId ){
        char strJson[MAX_MODEL_ID_BUFFER_SIZE];

        int len = snprintf(strJson, MAX_MODEL_ID_BUFFER_SIZE, cstrModelIdJsonFmt, cstrPnPModelId);
        if (len < 0 || len >= MAX_MODEL_ID_BUFFER_SIZE) {
            Log_Debug( MODULE "ERROR: Cannot write Model ID to buffer.\n");
            goto cleanup;
        }

        // Sets Model ID provisioning data (re-allocates buffer)
        result = Prov_Device_LL_Set_Provisioning_Payload(hProvDevice, strJson);
        CHECK_PROV_RESULT_AND_REPORT_ERROR("set Model Id");
    } else {
        Log_Debug(MODULE "INFO: Azure IoT PnP Model Id not specified.\n");
    }


    // Asynchronous call initiates the registration of a device.
    result = Prov_Device_LL_Register_Device( hProvDevice, 
                dpsRegisterDeviceCallback, NULL, 
                dpsRegisterDeviceStatusCallback, NULL); 
    CHECK_PROV_RESULT_AND_REPORT_ERROR("set registerDeviceCallback");

    SetTimerFdToPeriod( evtDpsTimeoutTimer.fd, &tsDpsTimeoutPeriod);
    SetTimerFdToPeriod( evtDpsPollingTimer.fd, &tsDpsPollPeriod);

    dpsRegisterStatus = AZURE_IOT_DPS_REGISTERING;
    return true;

cleanup:
    dpsCleanup();
    dpsRegisterStatus = AZURE_IOT_DPS_FAILED;
    return false;
}

/// @brief closes ProvisioningDevice if active and disarms DPS connection timers 
void  dpsCleanup( void )
{
    Log_Debug(MODULE "INFO: DPS client de-init.\n");
    if (hProvDevice != NULL) {
        Prov_Device_LL_Destroy(hProvDevice);
        hProvDevice = NULL;
    }

    DisarmTimerFd( evtDpsPollingTimer.fd );
    DisarmTimerFd( evtDpsTimeoutTimer.fd );
}



// for better readability define repetitive error checking/reporting as macro  
#define CHECK_CLIENT_RESULT_AND_REPORT_ERROR(m)   if (IOTHUB_CLIENT_OK != result){ \
        Log_Debug(cstrErrorIoTHubSetOptionFmt, m, IOTHUB_CLIENT_RESULTStrings(result)); \
        goto cleanup; \
    }


/**
 * @brief hubInitialize() initializes teh IoT Hub client and security factory and 
 * starts authentication with IoT Hub 
 * 
 * @return true on success
 * @return false on gailure
 */
bool hubInitialize( void )
{
    IOTHUB_CLIENT_RESULT result = IOTHUB_CLIENT_INVALID_ARG;

    if (IoTHub_Init() != 0) {
        Log_Debug(MODULE "ERROR: failed initializing platform.\n");
        return false;
    }

    // Set up auth type
    int retError = iothub_security_init(IOTHUB_SECURITY_TYPE_X509);
    if (retError != 0) {
        Log_Debug("ERROR: iothub_security_init failed with error %d.\n", retError);
        return false;
    }

    // Create Azure Iot Hub client handle
    Log_Debug(MODULE "INFO: Connecting to IoT Hub %s\n", strIotHubUri);
    hIoTHubClient = IoTHubDeviceClient_LL_CreateWithAzureSphereFromDeviceAuth(strIotHubUri, MQTT_Protocol);
    if (NULL ==  hIoTHubClient) 
    {
        Log_Debug(MODULE "ERROR: _CreateWithAzureSphereFromDeviceAuth returned NULL.\n");
        goto cleanup;
    }

    // Use DAA cert when connecting - requires the "SetDeviceId" option to be set
    static const int deviceIdForDaaCertUsage = 1;
    result = IoTHubDeviceClient_LL_SetOption( hIoTHubClient, OPTION_SET_DEVICE_ID, &deviceIdForDaaCertUsage);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( OPTION_SET_DEVICE_ID );


#if defined(USE_AZURE_CLOUD_ECC_CERT)
    result = IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_TRUSTED_CERT cstrAzureIoTCertificates);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( OPTION_TRUSTED_CERT );
#endif

    result = IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_LOG_TRACE, &bTraceOn);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( OPTION_LOG_TRACE );

    static bool bUrlAutoEncodeDecode = true; 
    result = IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_AUTO_URL_ENCODE_DECODE, &bUrlAutoEncodeDecode);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( OPTION_AUTO_URL_ENCODE_DECODE );

    // Sets Azure IoT PnP Model ID on IoT Hub Client
    result = IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_MODEL_ID, cstrPnPModelId);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( OPTION_MODEL_ID );

    result = IoTHubDeviceClient_LL_SetOption(hIoTHubClient, OPTION_KEEP_ALIVE, &iKeepalivePeriodSeconds);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( OPTION_KEEP_ALIVE );

    result = IoTHubDeviceClient_LL_SetRetryPolicy(hIoTHubClient, IOTHUB_CLIENT_RETRY_EXPONENTIAL_BACKOFF_WITH_JITTER, 240);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( "retry policy ...EXPONENTIAL_BACKOFF_WITH_JITTER" );

    // Set callbacks for Message, MethodCall and Device Twin features.
    result = IoTHubDeviceClient_LL_SetMessageCallback(hIoTHubClient, lstIotHubCallbacks.MessageReceivedHandler, NULL);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( "SetMessageCallback" );

    result = IoTHubDeviceClient_LL_SetDeviceMethodCallback(hIoTHubClient, lstIotHubCallbacks.DirectMethodHandler, NULL);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( "SetDeviceMethodCallback" );

    result = IoTHubDeviceClient_LL_SetDeviceTwinCallback(hIoTHubClient, lstIotHubCallbacks.DeviceTwinUpdateHandler, NULL);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( "SetDeviceTwinCallback" );

    // Set callbacks for connection status related events.
    result = IoTHubDeviceClient_LL_SetConnectionStatusCallback( hIoTHubClient, &hubConnectionStatusCallback, NULL);
    CHECK_CLIENT_RESULT_AND_REPORT_ERROR( "SetConnectionStatusCallback" );

    hubConnectionStatus = AZURE_IOT_HUB_AUTHENTICATING;
    return true;

cleanup:
    hubCleanup();
    hubConnectionStatus = AZURE_IOT_HUB_FAILED;
    return false;
}



/// @brief closes IoT Hub Device Client if active, de-initializes security factory and IoT Hub SDK 
void hubCleanup( void )
{
    Log_Debug(MODULE "INFO: IoT Hub client de-init.\n");

    if (hIoTHubClient != NULL) {
        IoTHubDeviceClient_LL_Destroy(hIoTHubClient);
        hIoTHubClient = NULL;
    }
    iothub_security_deinit();
    IoTHub_Deinit();
}


/**
 * @brief connectionTimerHandler() is the watchdog timer for the IoT Hub connection.
 * it runs on a 100ms period (per IoT Hub SDK recommendation), first checking on network connectivety,
 * then initiating DPS device registration and checking IoT Hub connection.
 * On connection failure it also handles the backoff schedule to reconnect via DPS to IoT Hub. 
 * 
 * @param eventData 
 */
static void connectionTimerHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(eventData->fd) != 0) {
        return;
    }

    // If network not (yet or no longer) ready, de-initialize  
    if( !isNetworkReady() )
    {
        if( dpsRegisterStatus != AZURE_IOT_DPS_NOT_STARTED )
        {
            dpsCleanup();
            dpsRegisterStatus = AZURE_IOT_DPS_NOT_STARTED;
        }
        if( hubConnectionStatus != AZURE_IOT_HUB_DISCONNECTED )
        {
            hubCleanup();
            hubConnectionStatus = AZURE_IOT_HUB_DISCONNECTED;
        }
        return;
    }

    if( dpsRegisterStatus==AZURE_IOT_DPS_NOT_STARTED )
    {
        dpsRegisterDevice();
        return;
    }

    // Keeps IoT Hub Client alive by exchanging data with the Azure IoT Hub.
    // When using low level samples (iothub_ll_*), the IoTHubDeviceClient_LL_DoWork function must be called regularly 
    // (eg. every 100 milliseconds) for the IoT device client to work properly.
    // <a href="https://github.com/Azure/azure-iot-sdk-c/blob/1c1b2c1a3a00bc445165dde44eb3e58ca999ec23/iothub_client/samples/readme.md#note" />
    if( (hubConnectionStatus == AZURE_IOT_HUB_CONNECTED)
        || (hubConnectionStatus == AZURE_IOT_HUB_AUTHENTICATING) )
    {
        static time_t lastHubDoWorkLogged = 0;
        periodicLogVarArgs(&lastHubDoWorkLogged, 10,  MODULE "%s calls in progress...\n", __func__);

        // DoWork - send some of the buffered events to the IoT Hub, and receive some of the
        // buffered events from the IoT Hub.
        IoTHubDeviceClient_LL_DoWork(hIoTHubClient);
        return;
    }

    // in case anything failed
    if( (dpsRegisterStatus == AZURE_IOT_DPS_FAILED) 
        || (hubConnectionStatus == AZURE_IOT_HUB_FAILED) )
    {
        static struct timespec tsLastRetry = {};
        struct timespec tsNow;
        timespec_get(&tsNow, TIME_UTC);
        if( tsNow.tv_sec < tsLastRetry.tv_sec + iConnectionRetrySeconds )
        {
            return;
        }

        tsLastRetry = tsNow;

        iConnectionRetrySeconds *=  2;
        if( iConnectionRetrySeconds > iConnectionRetryMaxWaitSeconds )
        {
            iConnectionRetrySeconds = iConnectionRetryMaxWaitSeconds;
        }
        
        dpsRegisterStatus=AZURE_IOT_DPS_NOT_STARTED;
        hubConnectionStatus = AZURE_IOT_HUB_DISCONNECTED;
        dpsRegisterDevice();
    }
}


/*****************************************************************************
 * 
 *   public functions to 
 * 
 * 
 *****************************************************************************/ 


int AzureIoT_DPS_Initialize(int fdEpoll, const char * strPnPModelId)
{
    cstrPnPModelId = strPnPModelId;

    // Create disarmed IoT connection timer
    if( 0 > CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullPeriod, &evtConnectionTimer, EPOLLIN))
    {
        Log_Debug(MODULE "ERROR: cannot create IoT connection timer.\n");
        return -1;
    }

    // Create disarmed DPS registration polling
    if( 0 > CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullPeriod, &evtDpsPollingTimer, EPOLLIN))
    {
        Log_Debug(MODULE "ERROR: cannot create DPS polling timer.\n");
        return -1;
    }

    // Create disarmed DPS timeout timer
    if( 0 > CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullPeriod, &evtDpsTimeoutTimer, EPOLLIN))
    {
        Log_Debug(MODULE "ERROR: cannot create DPS timeout timer.\n");
        return -1;
    }   

    return 0;
}


void AzureIoT_DPS_DeInitialize( void )
{
    if( evtConnectionTimer.fd > 0)
    {
        DisarmTimerFd( evtConnectionTimer.fd );
    }

    hubCleanup();
    dpsCleanup();
}

int AzureIoT_DPS_StartConnection( void )
{
    dpsRegisterStatus = AZURE_IOT_DPS_NOT_STARTED;
    if( evtConnectionTimer.fd > 0)
    {
        return SetTimerFdToPeriod( evtConnectionTimer.fd, &tsConnectionTimerPeriod);
    }

    return 0;
}

void AzureIoT_DPS_SetScopeID(const char* cstrId)
{
    cstrScopeId = NULL;
    if( NULL == cstrId ) {
        Log_Debug(MODULE "ERROR: DPS Scope Id is missing.\n");
        return; 
    } 

    if( MAX_SCOPEID_LENGTH == strnlen(cstrId, MAX_SCOPEID_LENGTH) )
    {
        Log_Debug(MODULE "ERROR: DPS Scope Id too long or malformed.\n");
        return; 
    }

    cstrScopeId = cstrId;
    Log_Debug(MODULE "Initializing with DPS Scope Id %s.\n", cstrId);
}

void AzureIoT_DPS_Options(int argc, char *argv[])
{
    static const char cszScopeIdParam[] = "--ScopeId";
    for(int i=0; i<argc-1; i++)
    {
        if( strncmp(argv[i],cszScopeIdParam, sizeof(cszScopeIdParam)) == 0 )
        {
            AzureIoT_DPS_SetScopeID( argv[i+1] );
            return;
        }
    }
    Log_Debug(MODULE "WARNING: DPS Scope Id is missing.\n");
}
