#include <errno.h>
#include <signal.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <math.h>

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"
#include "epoll_timerfd_utilities.h"
#include <applibs/uart.h>
#include <applibs/gpio.h>
#include <applibs/log.h>
#include <applibs/networking.h>

#include "mt3620_rdb.h"
#include "UART_utilities.h"
#include "MCU_utilities.h"

/// <summary>
/// This sample C application for the MT3620 Reference Development Board (Azure Sphere)
/// demonstrates how to gather telemetry data from a secondary MCU over UART.
/// 
/// UART_utilities.c demonstrates how to use Epoll to handle UART events 
/// It collects UART data in a 'ring'-buffer until a full line is received
/// and invokes the given callback to handle the UART string. 
/// The sample opens UART ISU0 with a baud rate of 9600 Baud.
///
/// MCU_utilities.c demonstrates how to extract MCU delivered data values and how to send temeletry to IoT Hub
/// once a temperature threshold between two readings is exceeded.
/// The temperature threshold can be cloud controlled using a device twin desired property "TemperatureChange"
/// i.e. using DeviceExplorer to send 
/// <example>
///		{ "properties": { "desired": { "TemperatureChange": 2.5 } } }
/// </example>
/// It also reports minimum and maximum temperatures within a session as device twin reported properties
/// once the last temperature reading exceeds the current boundaries. <see cref="checkAndUpdateDeviceTwin"/>
///
/// It uses the API for the following Azure Sphere application libraries:
/// - UART (serial port)
/// - GPIO (digital input for button)
/// - log (messages shown in Visual Studio's Device Output window during debugging)
/// </summary>

#ifndef AZURE_IOT_HUB_CONFIGURED
#error \
    "WARNING: Please add a project reference to the Connected Service first \
(right-click References -> Add Connected Service)."
#endif

#include "azure_iot_utilities.h"

// File descriptors - initialized to invalid value
static int epollFd = -1;
static int gpioConnectionStateLedFds[3] = {-1,-1,-1};
static int uartFd = -1;
static int azureIotDoWorkTimerFd = -1;

static GPIO_Id gpioConnectionStateLeds[3] = { MT3620_RDB_NETWORKING_LED_RED, 
											  MT3620_RDB_NETWORKING_LED_GREEN, 
											  MT3620_RDB_NETWORKING_LED_BLUE };

#define RGB_RED_INDEX		0
#define RGB_GREEN_INDEX		1
#define RGB_BLUE_INDEX		2

typedef enum  {
	RGB_Color_Black = 0,
	RGB_Color_Red = 1,
	RGB_Color_Green = 2,
	RGB_Color_Yellow = 3,
	RGB_Color_Blue = 4,
	RGB_Color_Magenta = 5,
	RGB_Color_Cyan = 6,
	RGB_Color_White = 7
} RGB_Color;

// State variables
static bool bConnectedToIoTHub = false;

// Termination state
static volatile sig_atomic_t terminationRequired = false;

/// <summary>
///     Signal handler for termination requests. This handler must be async-signal-safe.
/// </summary>
static void TerminationHandler(int signalNumber)
{
    // Don't use Log_Debug here, as it is not guaranteed to be async signal safe
    terminationRequired = true;
}


void setConnectionStatusLed(RGB_Color color)
{
	GPIO_SetValue(gpioConnectionStateLedFds[RGB_RED_INDEX], (color & (1 << RGB_RED_INDEX)) ? GPIO_Value_Low : GPIO_Value_High);
	GPIO_SetValue(gpioConnectionStateLedFds[RGB_GREEN_INDEX], (color & (1 << RGB_GREEN_INDEX)) ? GPIO_Value_Low : GPIO_Value_High);
	GPIO_SetValue(gpioConnectionStateLedFds[RGB_BLUE_INDEX], (color & (1 << RGB_BLUE_INDEX)) ? GPIO_Value_Low : GPIO_Value_High);
}

void updateConnectionStatusLed(void)
{
	RGB_Color color;
	bool bIsNetworkReady = false;

	if (Networking_IsNetworkingReady(&bIsNetworkReady) < 0) {
		color = RGB_Color_Red ; // network error
	} else {
		color = !bIsNetworkReady ? RGB_Color_Black // no Network
							      : (bConnectedToIoTHub ? RGB_Color_Blue // IoT hub connected
													    : RGB_Color_Green); // only Network connected
	}
	setConnectionStatusLed(color);
}

void ConnectionToIoTHubChanged(bool bConnected)
{
	bConnectedToIoTHub = bConnected;
	updateConnectionStatusLed();
}


/// <summary>
///     Hand over control periodically to the Azure IoT SDK's DoWork.
/// </summary>
static void AzureIotDoWorkHandler(event_data_t *eventData)
{
	if (ConsumeTimerFdEvent(azureIotDoWorkTimerFd) != 0) {
		terminationRequired = true;
		return;
	}

	updateConnectionStatusLed();

	// Set up the connection to the IoT Hub client.
	// Notes it is safe to call this function even if the client has already been set up, as in
	//   this case it would have no effect
	if (AzureIoT_SetupClient()) {
		// AzureIoT_DoPeriodicTasks() needs to be called frequently in order to keep active
		// the flow of data with the Azure IoT Hub
		AzureIoT_DoPeriodicTasks();
	}
}

static event_data_t azureIotEventData = { .eventHandler = &AzureIotDoWorkHandler };


/// <summary>
///     Set up SIGTERM termination handler, initialize peripherals, and set up event handlers.
/// </summary>
/// <returns>0 on success, or -1 on failure</returns>
static int InitPeripheralsAndHandlers(void)
{
    struct sigaction action;
    memset(&action, 0, sizeof(struct sigaction));
    action.sa_handler = TerminationHandler;
    sigaction(SIGTERM, &action, NULL);

	AzureIoT_SetDeviceTwinUpdateCallback(&MCU_DeviceTwinChangedHandler);
	AzureIoT_SetConnectionStatusCallback(&ConnectionToIoTHubChanged);

    epollFd = CreateEpollFd();
    if (epollFd < 0) {
        return -1;
    }

	// Create a UART_Config object, open the UART and set up UART event handler
	if ((uartFd = UART_InitializeAndAddToEpoll(MT3620_RDB_HEADER2_ISU0_UART, epollFd, &MCU_ParseDataToIotHub)) < 0)
	{
		return -1;
	}

	for (int i = 0; i < 3; i++)
	{
		gpioConnectionStateLedFds[i] = GPIO_OpenAsOutput(gpioConnectionStateLeds[i], GPIO_OutputMode_PushPull, GPIO_Value_High );
		if (gpioConnectionStateLedFds[i] < 0) {
			Log_Debug("ERROR: Could not open LED GPIO: %s (%d).\n", strerror(errno), errno);
			return -1;
		}
	}

	// Set up a timer for Azure IoT SDK DoWork execution.
	static struct timespec azureIotDoWorkPeriod = { 1, 0 };
	azureIotDoWorkTimerFd =
		CreateTimerFdAndAddToEpoll(epollFd, &azureIotDoWorkPeriod, &azureIotEventData, EPOLLIN);
	if (azureIotDoWorkTimerFd < 0) {
		return -1;
	}


    return 0;
}

/// <summary>
///     Close peripherals and handlers.
/// </summary>
static void ClosePeripheralsAndHandlers(void)
{
    // Turn the WiFi connection status LED off
	setConnectionStatusLed(RGB_Color_Black);

    Log_Debug("Closing file descriptors\n");
	UART_Close();
	CloseFdAndPrintError(epollFd, "Epoll");
}

/// <summary>
///     Main entry point for this application.
/// </summary>
int main(int argc, char *argv[])
{
    Log_Debug("MCUtoMt3620toAzure application starting\n");
    if (InitPeripheralsAndHandlers() != 0) {
        terminationRequired = true;
    }

    // Use epoll to wait for events and trigger handlers, until an error or SIGTERM happens
    while (!terminationRequired) {
        if (WaitForEventAndCallHandler(epollFd) != 0) {
            terminationRequired = true;
        }
	}

    ClosePeripheralsAndHandlers();
    Log_Debug("Application exiting\n");
    return 0;
}