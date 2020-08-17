#include <errno.h>
#include <signal.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"
#include "epoll_timerfd_utilities.h"

#include <applibs/gpio.h>
#include <applibs/log.h>

#include <hw/mt3620_rdb.h>
#include <SSD1308.h>


// This sample C application for the MT3620 Reference Development Board (Azure Sphere)
// blinks an LED.
// The blink rate can be changed through a button press.
//
// It uses the API for the following Azure Sphere application libraries:
// - gpio (digital input for button)
// - log (messages shown in Visual Studio's Device Output window during debugging)

// File descriptors - initialized to invalid value
static int fdButtonA = -1;
static int fdButtonB = -1;
static int fdButtonPollTimer = -1;
static int fdOledI2C = -1;
static int fdEpoll = -1;

// Button state variables
static GPIO_Value_Type buttonAState = GPIO_Value_High;
static GPIO_Value_Type buttonBState = GPIO_Value_High;

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

static bool CheckButtonPressed(int gpioFd, GPIO_Value_Type* lastState)
{
    GPIO_Value_Type newButtonState;
    if (GPIO_GetValue(gpioFd, &newButtonState) != 0) {
        Log_Debug("ERROR: Could not read button GPIO: %s (%d).\n", strerror(errno), errno);
        terminationRequired = true;
        return false;
    }

    // The button has GPIO_Value_Low when pressed and GPIO_Value_High when released
    if (newButtonState != *lastState) {
        *lastState = newButtonState;
        if (newButtonState == GPIO_Value_Low) {
            return true;
        }
    }

    return false;
}


/// <summary>
///     Handle button timer event: if the button is pressed, change the LED blink rate.
/// </summary>
static void ButtonTimerEventHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdButtonPollTimer) != 0) {
        terminationRequired = true;
        return;
    }

 
    if (CheckButtonPressed( fdButtonA, &buttonAState)) 
    {
        Log_Debug("Button A: write 'Hello World !'\n");

        OLED_Display(true); 
        OLED_ClearDisplay();
		OLED_SetTextPos(0, 0);
        OLED_PutString("Hello World!");
		OLED_SetTextPos(1, 1);
		OLED_PutString("Hello World!");
		OLED_SetTextPos(2, 2);
		OLED_PutString("Hello World!");
		OLED_SetTextPos(3, 4);
		OLED_PutString("Hello World!");
		//OLED_ClearPos(7,3,5);

		OLED_SetVerticalScrollProperties(SCROLL_VERTICAL_LEFT, 3, 6, SCROLL_PER_25_FRAMES, 1);
		OLED_ActivateScroll();
        struct timespec waitPeriod = { 3, 0 };
        nanosleep(&waitPeriod, NULL);
		OLED_DeactivateScroll();
    }

    if (CheckButtonPressed(fdButtonB, &buttonBState))
    {
        struct timespec waitPeriod = { 0, 250 * 1000 * 1000 };
        Log_Debug("Button B: Reset Display\n");

        OLED_Display(true);
        OLED_FillDisplay(0xFF);
        OLED_SetTextPos(0, 3);
        OLED_PutString("Display checked and working.");
        //OLED_SetInverseDisplay();
        //nanosleep(&waitPeriod, NULL);
        //OLED_SetNormalDisplay();

        OLED_Test();
        nanosleep(&waitPeriod, NULL);
        OLED_Test();
        nanosleep(&waitPeriod, NULL);
        OLED_Test();
        nanosleep(&waitPeriod, NULL);

    }

}

// event handler data structures. Only the event handler field needs to be populated.
static EventData buttonTimerEventData = {.eventHandler = &ButtonTimerEventHandler};

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

    fdEpoll = CreateEpollFd();
    if (fdEpoll < 0) {
        return -1;
    }
	
    // Open button GPIO for ButtonA as input
    Log_Debug("Opening MT3620_RDB_BUTTON_A as input.\n");
    fdButtonA = GPIO_OpenAsInput(MT3620_RDB_BUTTON_A);
    if (fdButtonA < 0) {
        Log_Debug("ERROR: Could not open button GPIO: %s (%d).\n", strerror(errno), errno);
        return -1;
    }

    // Open button GPIO for ButtonB as input
    Log_Debug("Opening MT3620_RDB_BUTTON_B as input.\n");
    fdButtonB = GPIO_OpenAsInput(MT3620_RDB_BUTTON_B);
    if (fdButtonB < 0) {
        Log_Debug("ERROR: Could not open button GPIO: %s (%d).\n", strerror(errno), errno);
        return -1;
    }


    // Set up a timer to poll the buttons
    struct timespec buttonPressCheckPeriod = {0, 1000000};
    fdButtonPollTimer =
        CreateTimerFdAndAddToEpoll(fdEpoll, &buttonPressCheckPeriod, &buttonTimerEventData, EPOLLIN);
    if (fdButtonPollTimer < 0) {
        return -1;
    }

    // Open I2C and initialize OLED
    Log_Debug("Opening MT3620_ISU3_I2C.\n");
	fdOledI2C = I2CMaster_Open(MT3620_ISU3_I2C);
	if (fdOledI2C < 0) {
		return -1;
	}
    I2CMaster_SetBusSpeed(fdOledI2C, I2C_BUS_SPEED_FAST_PLUS);

    if (OLED_Init(fdOledI2C, true) < 0)
    {
        Log_Debug("ERROR: OLED error.\n");
        return -1;
    }
	//OLED_SetTextPos(0,3);
	//OLED_PutString("Display checked!");
	//OLED_SetInverseDisplay();
	//struct timespec waitPeriod = { 0, 250 * 1000 * 1000 };
	//nanosleep(&waitPeriod, NULL);
	//OLED_SetNormalDisplay();

    return 0;
}

/// <summary>
///     Close peripherals and handlers.
/// </summary>
static void ClosePeripheralsAndHandlers(void)
{
    Log_Debug("Closing file descriptors.\n");
    CloseFdAndPrintError(fdButtonPollTimer, "ButtonPollTimer");
    CloseFdAndPrintError(fdOledI2C, "ISU3");
    CloseFdAndPrintError(fdButtonA, "ButtonA");
    CloseFdAndPrintError(fdButtonB, "ButtonA");
    CloseFdAndPrintError(fdEpoll, "Epoll");
}

/// <summary>
///     Main entry point for this application.
/// </summary>
int main(int argc, char *argv[])
{
    Log_Debug("OLED application starting.\n");
    if (InitPeripheralsAndHandlers() != 0) {
        terminationRequired = true;
    }

    // Use epoll to wait for events and trigger handlers, until an error or SIGTERM happens
    while (!terminationRequired) {
        if (WaitForEventAndCallHandler(fdEpoll) != 0) {
            terminationRequired = true;
        }
    }

    ClosePeripheralsAndHandlers();
    Log_Debug("OLED application exiting.\n");
    return 0;
}
