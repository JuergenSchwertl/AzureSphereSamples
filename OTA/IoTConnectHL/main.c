#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#include <applibs/gpio.h>
#include <applibs/log.h>

// This sample C application for a MT3620 Reference Development Board (Azure Sphere) demonstrates how to
// update Azure Sphere OTA (over-the-air) with image-sets consisting of a combination
// of high-level connectivity app and real-time HW control app.
// To use this sample, you must first add the Azure IoT Hub Connected Service reference to the project 
// (right-click References -> Add Connected Service -> Azure IoT Hub), which populates this projects
// app_manifest.json with the appropriate settings to allow connectivity to Azure IoT Hub.
//
// The sample leverages these functionalities of the Azure IoT SDK C:
// - Device to cloud messages;
// - Cloud to device messages;
// - Direct Method invocation;
// - Device Twin management;
//
// A description of the sample follows:
// - Pressing button A toggles the rate at which the real-time app blinks it's LED
//   between three values. The button press is sent via intercore-communications to the 
//   real-time app (RedSphere blinks LED1_RED, GreenSphere blinks LED2_GREEN, BlueSphere LED3_BLUE)
// - Pressing button B triggers the sending of a message to the IoT Hub.
// - STATUS_LED indicates by color to what realtime application is sideloaded.
// - WIFI_LED_BLUE indicates whether network connection to the Azure IoT Hub has been
//   established.
//
// Device Twin related notes:
// - Setting LedBlinkRateProperty in the Device Twin to a value from 0 to 2 causes the sample to
//   update the blink rate of LED 1 accordingly, e.g '{"LedBlinkRateProperty": 2}';
// - Upon receipt of the LedBlinkRateProperty desired value from the IoT hub, the sample updates
//   the device twin on the IoT hub with the new value for LedBlinkRateProperty.
// - Pressing button A causes the sample to report the blink rate to the device
//   twin on the IoT Hub.

// This sample uses the API for the following Azure Sphere application libraries:
// - gpio (digital input for button);
// - log (messages shown in Visual Studio's Device Output window during debugging);
// - azureiot (interaction with Azure IoT services)

// This sample is based on the features of the MT3620 Development Board:
// the HW configuration is therefore included in the project header files as per the below
#include "mt3620.h"
#include "mt3620_rdb.h"

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"
#include "epoll_timerfd_utilities.h"
#include "intercore_utilities.h"
#include "azure_iot_utilities.h"


#ifndef AZURE_IOT_HUB_CONFIGURED
#error \
    "WARNING: Please add a project reference to the Connected Service first \
(right-click References -> Add Connected Service)."
#endif

#define RED_SPHERE_COMPONENTID		"F4E25978-6152-447B-A2A1-64577582F327"
#define GREEN_SPHERE_COMPONENTID	"7E5FAB32-801C-4EDF-A1AA-9263652AA6BD"
#define BLUE_SPHERE_COMPONENTID		"07562362-3FEC-46C8-B0AF-DB9507F32748"

// forward declaration of inter-core communications message handler
void IntercoreMessageHandler(InterCoreEventData* pIcEventData, const void* pMessage, ssize_t iSize);


static InterCoreEventData iccRedSphere = {
	.ComponentId = RED_SPHERE_COMPONENTID,
	.MessageHandler = &IntercoreMessageHandler };

static InterCoreEventData iccGreenSphere = {
	.ComponentId = GREEN_SPHERE_COMPONENTID,
	.MessageHandler = &IntercoreMessageHandler };

static InterCoreEventData iccBlueSphere = {
	.ComponentId = BLUE_SPHERE_COMPONENTID,
	.MessageHandler = &IntercoreMessageHandler };


// realtime application PING message
static const char strPingMessage[] = "PING";

// Led blink rate and range
static unsigned int uLedBlinkRate = 0;
static const unsigned int uMaxBlinkRate = 3;

// ePoll file descriptors - initialized to invalid value
static int fdEpoll = -1;
static int fdConnectionStatus = -1;
static int fdBlinkRateButtonGpio = -1;
static int fdButtonPollTimer = -1;
static int fdAzureIoTDoWorkTimer = -1;

// Azure IoT poll periods
static const int AzureIoTDefaultPollPeriodSeconds = 5;
static const int AzureIoTMinReconnectPeriodSeconds = 60;
static const int AzureIoTMaxReconnectPeriodSeconds = 10 * 60;

static int azureIoTPollPeriodSeconds = -1;

// A null period to not start the timer when it is created with CreateTimerFdAndAddToEpoll.
//static const struct timespec nullPeriod = {0, 0};

// Connectivity state
static bool connectedToIoTHub = false;

// Termination state
static volatile sig_atomic_t terminationRequired = false;

/// <summary>
///     Signal handler for termination requests. This handler must be async-signal-safe.
/// </summary>
static void TerminationHandler(int signalNumber)
{
    // Don't use Log_Debug here, as it is not guaranteed to be async-signal-safe.
    terminationRequired = true;
}


void IntercoreMessageHandler(InterCoreEventData * pIcEventData, const void * pMessage, ssize_t iSize)
{
	Log_Debug("Message from %s is '%s'", pIcEventData->ComponentId, (const char *) pMessage);
}

void checkRealtimeApp(InterCoreEventData* pIcEventData)
{
	// If App was active before, try pinging the app to update status
	if (pIcEventData->State == InterCoreState_AppActive) {
		InterCore_SendMessage(pIcEventData, strPingMessage, sizeof(strPingMessage));
	}
	else {
		// else try registering the app (may fail gracefully)
		InterCore_RegisterHandler(fdEpoll, pIcEventData);
	}
}


/// <summary>
///     Helper function to open a file descriptor for the given GPIO as input mode.
/// </summary>
/// <param name="gpioId">The GPIO to open.</param>
/// <param name="outGpioFd">File descriptor of the opened GPIO.</param>
/// <returns>True if successful, false if an error occurred.</return>
static bool OpenGpioFdAsInput(GPIO_Id gpioId, int *outGpioFd)
{
    *outGpioFd = GPIO_OpenAsInput(gpioId);
    if (*outGpioFd < 0) {
        Log_Debug("ERROR: Could not open GPIO '%d': %d (%s).\n", gpioId, errno, strerror(errno));
        return false;
    }

    return true;
}

/// <summary>
///     Toggles the blink speed of the partner real-time app between 3 values
/// </summary>
/// <param name="uNewBlinkRate">the new blin krate</param>
static void SetLedRate(unsigned int uNewBlinkRate)
{
	// Clamp blink rate 
	uLedBlinkRate = uNewBlinkRate % uMaxBlinkRate;

	// send new blink rate to partner real-time app(s)
	//if (SetTimerFdToPeriod(led1BlinkTimerFd, rate) != 0) {
    //    Log_Debug("ERROR: could not set the period of the LED.\n");
    //    terminationRequired = true;
    //    return;
    //}

    if (connectedToIoTHub) {
        // Report the current state to the Device Twin on the IoT Hub.
        AzureIoT_TwinReportState("LedBlinkRateProperty", uLedBlinkRate);
    } else {
        Log_Debug("WARNING: Cannot send reported property; not connected to the IoT Hub.\n");
    }
}

///// <summary>
/////     Sends a message to the IoT Hub.
///// </summary>
//static void SendMessageToIoTHub(void)
//{
//    if (connectedToIoTHub) {
//        // Send a message
//        AzureIoT_SendMessage("Hello from Azure IoT sample!");
//    } else {
//        Log_Debug("WARNING: Cannot send message: not connected to the IoT Hub.\n");
//    }
//}

/// <summary>
///     MessageReceived callback function, called when a message is received from the Azure IoT Hub.
/// </summary>
/// <param name="payload">The payload of the received message.</param>
static void MessageReceived(const char *payload)
{
	// only message stub
}

/// <summary>
///     Device Twin update callback function, called when an update is received from the Azure IoT
///     Hub.
/// </summary>
/// <param name="desiredProperties">The JSON root object containing the desired Device Twin
/// properties received from the Azure IoT Hub.</param>
static void DeviceTwinUpdate(JSON_Object *desiredProperties)
{
    JSON_Value *blinkRateJson = json_object_get_value(desiredProperties, "LedBlinkRateProperty");

    // If the attribute is missing or its type is not a number.
    if (blinkRateJson == NULL) {
        Log_Debug(
            "INFO: A device twin update was received that did not contain the property "
            "\"LedBlinkRateProperty\".\n");
    } else if (json_value_get_type(blinkRateJson) != JSONNumber) {
        Log_Debug(
            "INFO: Device twin desired property \"LedBlinkRateProperty\" was received with "
            "incorrect type; it must be an integer.\n");
    } else {
        // Get the value of the LedBlinkRateProperty and print it.
        size_t desiredBlinkRate = (size_t)json_value_get_number(blinkRateJson);

        Log_Debug("INFO: Received desired value %zu for LedBlinkRateProperty.\n", desiredBlinkRate);

		SetLedRate(desiredBlinkRate);
    }
}

/// <summary>
///     Allocates and formats a string message on the heap.
/// </summary>
/// <param name="messageFormat">The format of the message</param>
/// <param name="maxLength">The maximum length of the formatted message string</param>
/// <returns>The pointer to the heap allocated memory.</returns>
static void *SetupHeapMessage(const char *messageFormat, size_t maxLength, ...)
{
    va_list args;
    va_start(args, maxLength);
    char *message =
        malloc(maxLength + 1); // Ensure there is space for the null terminator put by vsnprintf.
    if (message != NULL) {
        vsnprintf(message, maxLength, messageFormat, args);
    }
    va_end(args);
    return message;
}

/// <summary>
///     Direct Method callback function, called when a Direct Method call is received from the Azure
///     IoT Hub.
/// </summary>
/// <param name="methodName">The name of the method being called.</param>
/// <param name="payload">The payload of the method.</param>
/// <param name="responsePayload">The response payload content. This must be a heap-allocated
/// string, 'free' will be called on this buffer by the Azure IoT Hub SDK.</param>
/// <param name="responsePayloadSize">The size of the response payload content.</param>
/// <returns>404 HTTP status code: no methods supported in this sample.</returns>
static int DirectMethodCall(const char *methodName, const char *payload, size_t payloadSize,
                            char **responsePayload, size_t *responsePayloadSize)
{
	Log_Debug("INFO: DirectMethod called: '%s'.\n", methodName);

	// Prepare the payload for a 404 "not found" response. This is a heap allocated null terminated string.
	static const char noMethodFound[] = "\"method not found '%s'\"";
	size_t responseMaxLength = sizeof(noMethodFound) + strlen(methodName);
	*responsePayload = SetupHeapMessage(noMethodFound, responseMaxLength, methodName);
	if (*responsePayload == NULL) {
		Log_Debug("ERROR: Could not allocate buffer for direct method response payload.\n");
		abort();
	}
	*responsePayloadSize = strlen(*responsePayload);
	return 404; // HTTP status code 404: not found.
}


/// <summary>
///     IoT Hub connection status callback function.
/// </summary>
/// <param name="connected">'true' when the connection to the IoT Hub is established.</param>
static void IoTHubConnectionStatusChanged(bool connected)
{
	Log_Debug("INFO: IoT Hub Connection Status Changed to %d.\n", (int)connected);
	connectedToIoTHub = connected;
}

/// <summary>
///     Check whether a given button has just been pressed.
/// </summary>
/// <param name="fd">The button file descriptor</param>
/// <param name="oldState">Old state of the button (pressed or released)</param>
/// <returns>true if pressed, false otherwise</returns>
static bool IsButtonPressed(int fd, GPIO_Value_Type *oldState)
{
    bool isButtonPressed = false;
    GPIO_Value_Type newState;
    int result = GPIO_GetValue(fd, &newState);
    if (result != 0) {
        Log_Debug("ERROR: Could not read button GPIO: %s (%d).\n", strerror(errno), errno);
        terminationRequired = true;
    } else {
        // Button is pressed if it is low and different than last known state.
        isButtonPressed = (newState != *oldState) && (newState == GPIO_Value_Low);
        *oldState = newState;
    }

    return isButtonPressed;
}



void ApplicationCheckTimerHandler(EventData* pEventData)
{
	if (ConsumeTimerFdEvent(pEventData->fd) != 0) {
		terminationRequired = true;
		return;
	}

	checkRealtimeApp(&iccRedSphere);
	checkRealtimeApp(&iccGreenSphere);
	checkRealtimeApp(&iccBlueSphere);
}


/// <summary>
///     Handle button timer event: if the button is pressed, change the LED blink rate.
/// </summary>
static void ButtonPollTimerHandler(EventData *pEventData)
{
    if (ConsumeTimerFdEvent(pEventData->fd) != 0) {
        terminationRequired = true;
        return;
    }

    // If the button is pressed, change the LED blink interval, and update the Twin Device.
    static GPIO_Value_Type blinkButtonState;
    if (IsButtonPressed(fdBlinkRateButtonGpio, &blinkButtonState)) {
        SetLedRate(uLedBlinkRate+1);
    }

}

/// <summary>
///     Hand over control periodically to the Azure IoT SDK's DoWork.
/// </summary>
static void AzureIoTDoWorkHandler(EventData * pEventData)
{
	if (ConsumeTimerFdEvent(pEventData->fd) != 0) {
		terminationRequired = true;
		return;
	}

    // Set up the connection to the IoT Hub client.
    // Notes it is safe to call this function even if the client has already been set up, as in
    //   this case it would have no effect
    if (AzureIoT_SetupClient()) {
        if (azureIoTPollPeriodSeconds != AzureIoTDefaultPollPeriodSeconds) {
            azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;

            struct timespec azureTelemetryPeriod = {azureIoTPollPeriodSeconds, 0};
            SetTimerFdToPeriod(fdAzureIoTDoWorkTimer, &azureTelemetryPeriod);
        }

        // AzureIoT_DoPeriodicTasks() needs to be called frequently in order to keep active
        // the flow of data with the Azure IoT Hub
        AzureIoT_DoPeriodicTasks();
    } else {
        // If we fail to connect, reduce the polling frequency, starting at
        // AzureIoTMinReconnectPeriodSeconds and with a backoff up to
        // AzureIoTMaxReconnectPeriodSeconds
        if (azureIoTPollPeriodSeconds == AzureIoTDefaultPollPeriodSeconds) {
            azureIoTPollPeriodSeconds = AzureIoTMinReconnectPeriodSeconds;
        } else {
            azureIoTPollPeriodSeconds *= 2;
            if (azureIoTPollPeriodSeconds > AzureIoTMaxReconnectPeriodSeconds) {
                azureIoTPollPeriodSeconds = AzureIoTMaxReconnectPeriodSeconds;
            }
        }

        struct timespec azureTelemetryPeriod = {azureIoTPollPeriodSeconds, 0};
        SetTimerFdToPeriod(fdAzureIoTDoWorkTimer, &azureTelemetryPeriod);

        Log_Debug("ERROR: Failed to connect to IoT Hub; will retry in %i seconds\n",
                  azureIoTPollPeriodSeconds);
    }
}

// event handler data structures. Only the event handler field needs to be populated.
static EventData evtdataButtonPollTimer = {.eventHandler = &ButtonPollTimerHandler };
static EventData evtdataAzureIoTWorkTimer = {.eventHandler = &AzureIoTDoWorkHandler };
static EventData evtdataAppCheckTimer = { .eventHandler = &ApplicationCheckTimerHandler };


/// <summary>
///     Initialize peripherals, termination handler, and Azure IoT
/// </summary>
/// <returns>0 on success, or -1 on failure</returns>
static int InitPeripheralsAndHandlers(void)
{
    // Register a SIGTERM handler for termination requests
    struct sigaction action;
    memset(&action, 0, sizeof(struct sigaction));
    action.sa_handler = TerminationHandler;
    sigaction(SIGTERM, &action, NULL);

    // Open button A
    Log_Debug("INFO: Opening MT3620_RDB_BUTTON_A.\n");
    if (!OpenGpioFdAsInput(MT3620_RDB_BUTTON_A, &fdBlinkRateButtonGpio)) {
        return -1;
    }

    // Initialize the Azure IoT SDK
    if (!AzureIoT_Initialize()) {
        Log_Debug("ERROR: Cannot initialize Azure IoT Hub SDK.\n");
        return -1;
    }

	InterCore_Initialize(&iccRedSphere);
	InterCore_Initialize(&iccGreenSphere);
	InterCore_Initialize(&iccBlueSphere);
	

    // Set the Azure IoT hub related callbacks
    AzureIoT_SetMessageReceivedCallback(&MessageReceived);
    AzureIoT_SetDeviceTwinUpdateCallback(&DeviceTwinUpdate);
    AzureIoT_SetDirectMethodCallback(&DirectMethodCall);
    AzureIoT_SetConnectionStatusCallback(&IoTHubConnectionStatusChanged);

    // Display the currently connected WiFi connection.
    //DebugPrintCurrentlyConnectedWiFiNetwork();

    fdEpoll = CreateEpollFd();
    if (fdEpoll < 0) {
        return -1;
    }


    // Set up a timer for buttons status check
    static struct timespec tsButtonPressCheckPeriod = {0, 1000000};
    fdButtonPollTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsButtonPressCheckPeriod,
                                                   &evtdataButtonPollTimer, EPOLLIN);
    if (fdButtonPollTimer < 0) {
        return -1;
    }

	// Set up a timer for real-time app status check
	static struct timespec tsAppCheckPeriod = { 10, 0};
	fdConnectionStatus = CreateTimerFdAndAddToEpoll(fdEpoll, &tsAppCheckPeriod,
		&evtdataAppCheckTimer, EPOLLIN);
	if (fdConnectionStatus < 0) {
		return -1;
	}

    // Set up a timer for Azure IoT SDK DoWork execution.
    azureIoTPollPeriodSeconds = AzureIoTDefaultPollPeriodSeconds;
    struct timespec tsAzureIoTDoWorkPeriod = {azureIoTPollPeriodSeconds, 0};
    fdAzureIoTDoWorkTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsAzureIoTDoWorkPeriod, &evtdataAzureIoTWorkTimer, EPOLLIN);
    if (fdAzureIoTDoWorkTimer < 0) {
        return -1;
    }

    return 0;
}

/// <summary>
///     Close peripherals and Azure IoT
/// </summary>
static void ClosePeripheralsAndHandlers(void)
{
    Log_Debug("INFO: Closing GPIOs and Azure IoT client.\n");


    // Close all file descriptors
    CloseFdAndPrintError(fdBlinkRateButtonGpio, "LedBlinkRateButtonGpio");
    CloseFdAndPrintError(fdButtonPollTimer, "ButtonPollTimer");
    CloseFdAndPrintError(fdConnectionStatus, "AppCheckTimer");

	InterCore_UnregisterHandler(&iccRedSphere);
	InterCore_UnregisterHandler(&iccGreenSphere);
	InterCore_UnregisterHandler(&iccBlueSphere);

	CloseFdAndPrintError(fdAzureIoTDoWorkTimer, "IoTDoWorkTimer");
	CloseFdAndPrintError(fdEpoll, "Epoll");

    // Destroy the IoT Hub client
    AzureIoT_DestroyClient();
    AzureIoT_Deinitialize();
}

/// <summary>
///     Main entry point for this application.
/// </summary>
int main(int argc, char *argv[])
{
    Log_Debug("INFO: Azure IoT application starting.\n");

	if (argc > 0)
	{
		// only parameter should be DPS Scope ID
		AzureIoT_SetDPSScopeID(argv[0]);
	}

    if (InitPeripheralsAndHandlers() != 0) {
        terminationRequired = true;
    }

    while (!terminationRequired) {
        if (WaitForEventAndCallHandler(fdEpoll) != 0) {
            terminationRequired = true;
        }
    }

    ClosePeripheralsAndHandlers();
    Log_Debug("INFO: Application exiting.\n");
    return 0;
}
