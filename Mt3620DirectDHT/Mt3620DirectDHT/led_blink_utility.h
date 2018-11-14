#pragma once

#include <time.h>
#include <stdbool.h>
#include <stdlib.h>
#include <applibs/gpio.h>

#define NUM_CHANNELS 3

/// <summary>
///     Struct representing an RGB LED
/// </summary>
typedef struct RgbLed {
    /// <summary>
    ///     File descriptors for GPIOs for the red, green and blue color channels comprising the RGB
    ///     LED
    /// </summary>
    int channel[NUM_CHANNELS];
} RgbLed;

/// <summary>
///     The init value for RgbLed structs.
/// </summary>
#define RGBLED_INIT_VALUE         \
    {                             \
        .channel = { -1, -1, -1 } \
    }

/// <summary>
///     Enumeration of available LED colors.
/// </summary>
typedef enum {
    LedBlinkUtility_Colors_Off = 0,     // 000 binary
    LedBlinkUtility_Colors_White = 7,   // 111 binary
    LedBlinkUtility_Colors_Red = 1,     // 001 binary
    LedBlinkUtility_Colors_Green = 2,   // 010 binary
    LedBlinkUtility_Colors_Blue = 4,    // 100 binary
    LedBlinkUtility_Colors_Cyan = 6,    // 110 binary
    LedBlinkUtility_Colors_Magenta = 5, // 101 binary
    LedBlinkUtility_Colors_Yellow = 3,  // 011 binary
    LedBlinkUtility_Colors_Unknown = 8  // 1000 binary
} LedBlinkUtility_Colors;

/// <summary>
///     Opens the first 'n' LEDs as defined in the ledGpios array, where n is ledCount, and returns
///     their file descriptors via the provided 'leds' array.
/// </summary>
/// <param name="outLeds">An array which will be populated by opened RgbLeds.</param>
/// <param name="ledCount">The number of LEDs to open.</param>
/// <param name="ledGpios">An array containing the LED GPIO definitions for each channel of the RGB
/// LEDs to open.</param>
int LedBlinkUtility_OpenLeds(RgbLed **outLeds, size_t ledCount,
                             const int (*ledGpios)[NUM_CHANNELS]);

/// <summary>
///     Closes the file descriptors provided in the 'leds' array.
/// </summary>
/// <param name="leds">An array of previously opened RgbLeds.</param>
/// <param name="ledCount">The number of LEDs to close.</param>
void LedBlinkUtility_CloseLeds(RgbLed **leds, size_t ledCount);

/// <summary>
///     Blinks the LEDs according to the times set by calls to
///     LedBlinkUtility_SetLedNextBlinkTime(),
///     LedBlinkUtility_BlinkNow(), or LedBlinkUtility_SetBlinkingLedHandleAndPeriodAndColor().
/// </summary>
/// <param name="leds">An array ofRgbLeds.</param>
/// <param name="ledCount">The number of LEDs to blink.</param>
int LedBlinkUtility_BlinkLeds(RgbLed **leds, size_t ledCount);

/// <summary>
///     Sets the specified LED to blink at the given time with the given color.
/// </summary>
/// <param name="leds">An RgbLed.</param>
/// <param name="startTime">The next blink start time.</param>
/// <param name="color">The blink color.</param>
void LedBlinkUtility_SetLedNextBlinkTime(const RgbLed *led, struct timespec startTime,
                                         LedBlinkUtility_Colors color);

/// <summary>
///     Sets the specified LED to blink as soon as possible with the given color.
/// </summary>
/// <param name="color">The blink color.</param>
void LedBlinkUtility_BlinkNow(const RgbLed *led, LedBlinkUtility_Colors color);

/// <summary>
///     Sets the specified LED to blink periodically with the given color and blink period.
///     Only one LED may be set to blink at any one time; calling this overrides any previous
///     setting.
/// </summary>
/// <param name="leds">An RgbLed.</param>
/// <param name="startTime">The blink period.</param>
/// <param name="color">The blink color.</param>
void LedBlinkUtility_SetBlinkingLedHandleAndPeriodAndColor(const RgbLed *led,
                                                           struct timespec period,
                                                           LedBlinkUtility_Colors color);

/// <summary>
///     Changes the color of an RGB LED.
/// </summary>
/// <param name="leds">An RgbLed.</param>
/// <param name="color">The color to change to.</param>
int LedBlinkUtility_SetLed(const RgbLed *led, LedBlinkUtility_Colors color);

/// <summary>
///     Searches in the given string the first occurence of one of the color's name
///     defined in the LedBlinkUtility_Colors enum (e.g. "red" for LedBlinkUtility_Colors_Red), and
///     returns the matching enum.
///     If no matching color is found, <see cref="LedBlinkUtility_Colors_Unknown"/> is returned.
/// </summary>
/// <param name="string">string searched for a word indicating a color</param>
/// <param name="string">size of the string</param>
/// <returns>The relative color's enum. </returns>
LedBlinkUtility_Colors LedBlinkUtility_GetColorFromString(const char *string, size_t stringSize);

/// <summary>
///     Returns the string representation of a given color enumeration.
///     If no matching color is found, <see cref="LedBlinkUtility_Colors_Unknown"/> representation
///     is returned.
/// </summary>
/// <param name="color">The color enum to get the string representation of.</param>
/// <returns>The relative color string representation. </returns>
const char *LedBlinkUtility_GetStringFromColor(LedBlinkUtility_Colors color);
