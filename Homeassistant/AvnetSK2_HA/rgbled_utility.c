#include <unistd.h>
#include <string.h>

#include <applibs/gpio.h>
#include <applibs/log.h>

#include "rgbled_utility.h"

///  @brief 
///     Maximum number of managed LEDs.
/// 
#define MAX_LED_COUNT 4

static const char *colorNames[] = {"white", "blue",   "cyan",    "green",
                                   "red",   "yellow", "magenta", "off"};
static const RgbLedUtility_Colors colors[] = {
    RgbLedUtility_Colors_White,   RgbLedUtility_Colors_Blue, RgbLedUtility_Colors_Cyan,
    RgbLedUtility_Colors_Green,   RgbLedUtility_Colors_Red,  RgbLedUtility_Colors_Yellow,
    RgbLedUtility_Colors_Magenta, RgbLedUtility_Colors_Off};

static RgbLed rgbLeds[MAX_LED_COUNT];
static size_t openedLeds = 0;

int RgbLedUtility_OpenLeds(RgbLed **outLeds, size_t ledCount, const int (*ledGpios)[NUM_CHANNELS])
{
    if (ledCount > MAX_LED_COUNT) {
        Log_Debug("ERROR: Cannot specify more than %d RGB LEDs.\n", MAX_LED_COUNT);
        return -1;
    }

    for (size_t i = 0; i < ledCount; i++) {
        Log_Debug("INFO: Open RGB LED %d.\n", i);
        for (int channel = 0; channel < NUM_CHANNELS; channel++) {
            outLeds[i]->channelGpioFd[channel] =
                GPIO_OpenAsOutput(ledGpios[i][channel], GPIO_OutputMode_PushPull, GPIO_Value_High);
            if (outLeds[i]->channelGpioFd[channel] < 0) {
                Log_Debug("ERROR: Could not open LED.\n");
                return -1;
            }

            // Copy the created handles in the internal rgbLeds struct.
            // They are needed when converting from a raw LED pointer to an index inside
            // the rgbLeds structure.
            rgbLeds[i].channelGpioFd[channel] = outLeds[i]->channelGpioFd[channel];
        }
    }

    openedLeds = ledCount;
    return 0;
}

int RgbLedUtility_SetLed(const RgbLed *led, RgbLedUtility_Colors colorRequested)
{
    int result;

    for (int channel = 0; channel < NUM_CHANNELS; channel++) {
        bool isOn = (int)colorRequested & (0x1 << channel);

        result =
            GPIO_SetValue(led->channelGpioFd[channel], isOn ? GPIO_Value_Low : GPIO_Value_High);
        if (result != 0) {
            Log_Debug("ERROR: Cannot change RGB LED 0x%x color.\n", led);
        }
    }
    return result;
}

void RgbLedUtility_CloseLeds(RgbLed **leds, size_t ledCount)
{
    for (size_t i = 0; i < ledCount; i++) {
        for (int channel = 0; channel < NUM_CHANNELS; channel++) {
            int ledFd = leds[i]->channelGpioFd[channel];
            if (ledFd >= 0) {
                GPIO_SetValue(ledFd, GPIO_Value_High); // off
                close(ledFd);
            }
        }
    }

    openedLeds = 0;
}

RgbLedUtility_Colors RgbLedUtility_GetColorFromString(const char *colorName, size_t colorNameSize)
{
    RgbLedUtility_Colors returnedColor = RgbLedUtility_Colors_Unknown;

    for (size_t i = 0; i < sizeof(colors) / sizeof(*colors); i++) {
        size_t colorNameLength = strlen(colorNames[i]);
        if ((strncmp(colorNames[i], colorName, colorNameLength) == 0) && /* Same content */
            (colorNameLength == colorNameSize))                          /* Same length */
            returnedColor = colors[i];
    }

    return returnedColor;
}

const char *RgbLedUtility_GetStringFromColor(RgbLedUtility_Colors color)
{
    const char *returnedColor = "unknown";

    for (size_t i = 0; i < sizeof(colors) / sizeof(*colors); i++) {
        if (color == colors[i]) {
            returnedColor = colorNames[i];
            break;
        }
    }

    return returnedColor;
}
