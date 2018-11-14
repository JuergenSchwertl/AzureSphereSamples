#include <unistd.h>
#include <string.h>

#include <applibs/gpio.h>
#include <applibs/log.h>

#include "led_blink_utility.h"

/// <summary>
///     Maximum number of managed LEDs.
/// </summary>
#define MAX_LED_COUNT 4

typedef struct intervaltime {
    struct timespec rising;
    struct timespec falling;
    LedBlinkUtility_Colors color;
} IntervalTime;

/// <summary>
///     A struct timespec value that is treated as an invalid value.
/// </summary>
#define INVALID_TIME \
    {                \
        0, 0         \
    }

/// <summary>
///     Invalid time instance.
/// </summary>
static const struct timespec invalidTime = INVALID_TIME;

static IntervalTime ledRisingFallingEdgeIntervalTime[MAX_LED_COUNT] = {
    {INVALID_TIME, INVALID_TIME, LedBlinkUtility_Colors_White},
    {INVALID_TIME, INVALID_TIME, LedBlinkUtility_Colors_White},
    {INVALID_TIME, INVALID_TIME, LedBlinkUtility_Colors_White},
    {INVALID_TIME, INVALID_TIME, LedBlinkUtility_Colors_White}};

static const struct timespec blinkOrdinaryTime = {0, 62500000};

static const char *colorNames[] = {"white", "blue",   "cyan",    "green",
                                   "red",   "yellow", "magenta", "off"};
static const LedBlinkUtility_Colors colors[] = {
    LedBlinkUtility_Colors_White,   LedBlinkUtility_Colors_Blue, LedBlinkUtility_Colors_Cyan,
    LedBlinkUtility_Colors_Green,   LedBlinkUtility_Colors_Red,  LedBlinkUtility_Colors_Yellow,
    LedBlinkUtility_Colors_Magenta, LedBlinkUtility_Colors_Off};

// Time function utilities.
static inline bool LedBlinkUtility_TimerCompareGreater(const struct timespec *s,
                                                       const struct timespec *t)
{
    return (s->tv_sec == t->tv_sec) ? (s->tv_nsec > t->tv_nsec) : (s->tv_sec) > (t->tv_sec);
}

static inline bool LedBlinkUtility_TimerCompareLesserEqual(const struct timespec *s,
                                                           const struct timespec *t)
{
    return (s->tv_sec == t->tv_sec) ? (s->tv_nsec <= t->tv_nsec) : (s->tv_sec) <= (t->tv_sec);
}

static inline void LedBlinkUtility_TimerAdd(const struct timespec *s, const struct timespec *t,
                                            struct timespec *a)
{
    a->tv_sec = s->tv_sec + t->tv_sec;
    if ((a->tv_nsec = s->tv_nsec + t->tv_nsec) >= 1000000000) {
        a->tv_nsec -= 1000000000;
        a->tv_sec++;
    }
}
static inline bool LedBlinkUtility_TimerEqual(const struct timespec *s, const struct timespec *t)
{
    return (s->tv_nsec == t->tv_nsec) && (s->tv_sec == t->tv_sec);
}

static RgbLed rgbLeds[MAX_LED_COUNT];
static size_t openedLeds = 0;

static inline size_t RgbLedToIndex(const RgbLed *led)
{
    for (size_t i = 0; i <= MAX_LED_COUNT; i++) {
        size_t channel;
        for (channel = 0; channel < NUM_CHANNELS; channel++) {
            if (rgbLeds[i].channel[channel] != led->channel[channel])
                break;
        }
        if (channel == NUM_CHANNELS)
            return i;
    }
    return SIZE_MAX;
}

int LedBlinkUtility_OpenLeds(RgbLed **outLeds, size_t ledCount, const int (*ledGpios)[NUM_CHANNELS])
{
    if (ledCount > MAX_LED_COUNT) {
        Log_Debug("ERROR: Cannot specify more than %d RGB LEDs\n", MAX_LED_COUNT);
        return -1;
    }

    for (size_t i = 0; i < ledCount; i++) {
        Log_Debug("Open RGB LED %d\n", i);
        for (int channel = 0; channel < NUM_CHANNELS; channel++) {
            outLeds[i]->channel[channel] =
                GPIO_OpenAsOutput(ledGpios[i][channel], GPIO_OutputMode_PushPull, GPIO_Value_High);
            if (outLeds[i]->channel[channel] < 0) {
                Log_Debug("ERROR: Could not open LED\n");
                return -1;
            }

            // Copy the created handles in the internal rgbLeds struct.
            // They are needed when converting from a raw LED pointer to an index inside
            // the rgbLeds structure.
            rgbLeds[i].channel[channel] = outLeds[i]->channel[channel];
        }
    }

    openedLeds = ledCount;
    return 0;
}

int LedBlinkUtility_SetLed(const RgbLed *led, LedBlinkUtility_Colors colorRequested)
{
    int result;

    for (int channel = 0; channel < NUM_CHANNELS; channel++) {
        bool isOn = (int)colorRequested & (0x1 << channel);

        result = GPIO_SetValue(led->channel[channel], isOn ? GPIO_Value_Low : GPIO_Value_High);
        if (result != 0) {
            Log_Debug("ERROR: Cannot change RGB LED 0x%x color\n", led);
        }
    }
    return result;
}

static void SetLedTimeInterval(const RgbLed *led, struct timespec rise,
                               LedBlinkUtility_Colors color)
{
    size_t ledIndex = RgbLedToIndex(led);
    if (ledIndex >= openedLeds) {
        Log_Debug("ERROR: invalid LED pointer provided!");
    } else {
        ledRisingFallingEdgeIntervalTime[ledIndex].rising = rise;
        LedBlinkUtility_TimerAdd(&rise, &blinkOrdinaryTime,
                                 &ledRisingFallingEdgeIntervalTime[ledIndex].falling);
        ledRisingFallingEdgeIntervalTime[ledIndex].color = color;
    }
}

/// <summary>
///     The pointer to the periodic blinking LED.
/// </summary>
static const RgbLed *periodicBlinkingLed = NULL;
/// <summary>
///     The blink period of the blinking LED.
/// </summary>
static struct timespec periodicBlinkingLedPeriod;
/// <summary>
///     The color of the blinking LED.
/// </summary>
static LedBlinkUtility_Colors periodicBlinkingLedColor = LedBlinkUtility_Colors_White;

void LedBlinkUtility_SetBlinkingLedHandleAndPeriodAndColor(const RgbLed *led,
                                                           struct timespec period,
                                                           LedBlinkUtility_Colors color)
{
    periodicBlinkingLedPeriod = period;
    periodicBlinkingLed = led;
    periodicBlinkingLedColor = color;
}

int LedBlinkUtility_BlinkLeds(RgbLed **leds, size_t ledCount)
{
    int result = 0;
    struct timespec currentTime;
    clock_gettime(CLOCK_MONOTONIC, &currentTime);

    // Handle the blinking of all LEDs
    for (size_t i = 0; i < ledCount; i++) {
        if (leds[i] == periodicBlinkingLed)
            continue;
        // Ignore LEDs with intervals containing invalid values.
        if (LedBlinkUtility_TimerEqual(&ledRisingFallingEdgeIntervalTime[i].falling,
                                       &invalidTime) ||
            (LedBlinkUtility_TimerEqual(&ledRisingFallingEdgeIntervalTime[i].rising, &invalidTime)))
            continue;

        bool turnedOn = (LedBlinkUtility_TimerCompareLesserEqual(
                             &currentTime, &ledRisingFallingEdgeIntervalTime[i].falling) &&
                         LedBlinkUtility_TimerCompareGreater(
                             &currentTime, &ledRisingFallingEdgeIntervalTime[i].rising));
        LedBlinkUtility_Colors color = ledRisingFallingEdgeIntervalTime[i].color;
        if (!turnedOn)
            color = LedBlinkUtility_Colors_Off;
        LedBlinkUtility_SetLed(leds[i], color);
    }

    //// Manage the blinking LED, see also SetBlinkingLedHandleAndPeriodAndColor().
    //static struct timespec blinkingLedNextBlinkTime = INVALID_TIME;
    //static bool blinkingLedIsOn = false;
    //if (LedBlinkUtility_TimerCompareLesserEqual(&blinkingLedNextBlinkTime, &currentTime)) {
    //    LedBlinkUtility_TimerAdd(&currentTime, &periodicBlinkingLedPeriod,
    //                             &blinkingLedNextBlinkTime);
    //    LedBlinkUtility_SetLed(periodicBlinkingLed, blinkingLedIsOn ? LedBlinkUtility_Colors_Off
    //                                                                : periodicBlinkingLedColor);
    //    blinkingLedIsOn = !blinkingLedIsOn;
    //}

    return result;
}

void LedBlinkUtility_SetLedNextBlinkTime(const RgbLed *led, struct timespec startBlinkTime,
                                         LedBlinkUtility_Colors color)
{
    SetLedTimeInterval(led, startBlinkTime, color);
}

void LedBlinkUtility_BlinkNow(const RgbLed *led, LedBlinkUtility_Colors color)
{
    struct timespec currentTime;
    clock_gettime(CLOCK_MONOTONIC, &currentTime);
    SetLedTimeInterval(led, currentTime, color);
}

void LedBlinkUtility_CloseLeds(RgbLed **leds, size_t ledCount)
{
    for (size_t i = 0; i < ledCount; i++) {
        for (int channel = 0; channel < NUM_CHANNELS; channel++) {
            int ledFd = leds[i]->channel[channel];
            if (ledFd >= 0) {
                GPIO_SetValue(ledFd, GPIO_Value_High); // off
                close(ledFd);
            }
        }
    }

    openedLeds = 0;
}

LedBlinkUtility_Colors LedBlinkUtility_GetColorFromString(const char *colorName,
                                                          size_t colorNameSize)
{
    LedBlinkUtility_Colors returnedColor = LedBlinkUtility_Colors_Unknown;

    for (size_t i = 0; i < sizeof(colors) / sizeof(*colors); i++) {
        if (strncmp(colorNames[i], colorName, strlen(colorNames[i])) == 0)
            returnedColor = colors[i];
    }

    return returnedColor;
}

const char *LedBlinkUtility_GetStringFromColor(LedBlinkUtility_Colors color)
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
