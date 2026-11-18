#pragma once

#include <time.h>
#include <stdbool.h>
#include <stdlib.h>
#include <applibs/gpio.h>

#define NUM_CHANNELS 3

///  @brief 
///     Struct representing an RGB LED
/// 
typedef struct {
    ///  @brief 
    ///     File descriptors for GPIOs for the red, green and blue color channels comprising the RGB
    ///     LED
    /// 
    int channelGpioFd[NUM_CHANNELS];
} RgbLed;

///  @brief 
///     The init value for RgbLed structs.
/// 
#define RGBLED_INIT_VALUE               \
    {                                   \
        .channelGpioFd = { -1, -1, -1 } \
    }

///  @brief 
///     Enumeration of available LED colors.
/// 
typedef enum {
    RgbLedUtility_Colors_Off = 0,     // 000 binary
    RgbLedUtility_Colors_White = 7,   // 111 binary
    RgbLedUtility_Colors_Red = 1,     // 001 binary
    RgbLedUtility_Colors_Green = 2,   // 010 binary
    RgbLedUtility_Colors_Blue = 4,    // 100 binary
    RgbLedUtility_Colors_Cyan = 6,    // 110 binary
    RgbLedUtility_Colors_Magenta = 5, // 101 binary
    RgbLedUtility_Colors_Yellow = 3,  // 011 binary
    RgbLedUtility_Colors_Unknown = 8  // 1000 binary
} RgbLedUtility_Colors;

///  @brief 
///     Opens the first ledCount LEDs in the ledGpios array, and writes their file
///     descriptors into the provided 'leds' array.
/// 
/// <param name="outLeds">An array which will be populated by opened RgbLeds.</param>
/// <param name="ledCount">The number of LEDs to open.</param>
/// <param name="ledGpios">An array containing the LED GPIO definitions for each channel of the RGB
/// LEDs to open.</param>
int RgbLedUtility_OpenLeds(RgbLed **outLeds, size_t ledCount, const int (*ledGpios)[NUM_CHANNELS]);

///  @brief 
///     Closes the file descriptors provided in the 'leds' array.
/// 
/// <param name="leds">An array of previously opened RgbLeds.</param>
/// <param name="ledCount">The number of LEDs to close.</param>
void RgbLedUtility_CloseLeds(RgbLed **leds, size_t ledCount);

///  @brief 
///     Changes the color of an RGB LED.
/// 
/// <param name="leds">An RgbLed.</param>
/// <param name="color">The color to change to.</param>
int RgbLedUtility_SetLed(const RgbLed *led, RgbLedUtility_Colors color);

///  @brief 
///     Searches the given string for the first occurence a color's name, for the
///     colors defined in the RgbLedUtility_Colors enum (e.g. "red" for RgbLedUtility_Colors_Red),
///     and returns the matching enum value.
///     If no matching color is found, <see cref="RgbLedUtility_Colors_Unknown"/> is returned.
/// 
/// <param name="string">string searched for a word indicating a color</param>
/// <param name="stringSize">size of the string</param>
/// <returns>The color's enum value. </returns>
RgbLedUtility_Colors RgbLedUtility_GetColorFromString(const char *string, size_t stringSize);

///  @brief 
///     Returns the string representation of a given color enumeration.
///     If no matching color is found, <see cref="RgbLedUtility_Colors_Unknown"/> representation
///     is returned.
/// 
/// <param name="color">The color enum to get the string representation of.</param>
/// <returns>The relative color string representation. </returns>
const char *RgbLedUtility_GetStringFromColor(RgbLedUtility_Colors color);
