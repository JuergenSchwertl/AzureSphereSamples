/**
 * @file main.c
 * @author Juergen Schwertl (jschwert@hotmail.com, Ex-MSFT)
 * @brief Connects an AVNET Starter Kit Rev.2 (Azure Sphere) to Home Assistant using MQTT.
 *
 * A description of the sample follows:
 * - UserLed blinks constantly.
 * - Pressing button A toggles the rate at which LED 1 blinks between three values.
 * - Pressing button B triggers an immediate sensor update over MQTT.
 * - AppStatusLed flashes green on publish, blue on command, and red on error.
 * - Home Assistant MQTT discovery creates sensor entities and controls for the RGB LED.
 *
 * This sample uses the following Azure Sphere application libraries:
 * - i2c (serial port for BME280 sensor);
 * - gpio (digital input for button);
 * - log (messages shown in Visual Studio's Device Output window during debugging);
 * - wificonfig (configure WiFi settings);
 * - sockets (MQTT connection to a local broker).
 * @version 26.11
 * @date 2026-11-19
 * 
 * @copyright Copyright (c) 2021
 * 
 */

#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// applibs_versions.h defines the API struct versions to use for applibs APIs.
#include "applibs_versions.h"

#include <applibs/log.h>
#include <applibs/i2c.h>
#include <applibs/gpio.h>
#include <applibs/networking.h>
#include <applibs/wificonfig.h>
#include <applibs/powermanagement.h>
#include <applibs/application.h>
#include <applibs/applications.h>

// include the appropriate AVNET Starter Kit revision header file. 
// The #defines have the same names on both but content differes on some (i.e. GPIO port settings for named LEDs)
#ifdef AVNETSK_REV1
#include <hw/avnet_mt3620_sk.h>
#endif
#ifdef AVNETSK_REV2
#include <hw/avnet_mt3620_sk_rev2.h>
#endif


#include <sensors.h>

#include "rgbled_utility.h"
#include "epoll_timerfd_utilities.h"
#include "mqtt_client.h"
#include "parson.h"


// An array defining the RGB GPIOs for each LED on the device
static const GPIO_Id gpioLedPins[1][3] = {
    {AVNET_MT3620_SK_USER_LED_RED, AVNET_MT3620_SK_USER_LED_GREEN, AVNET_MT3620_SK_USER_LED_BLUE}
};

static RgbLedUtility_Colors colBlinkingLedColor = RgbLedUtility_Colors_Blue;

static const struct timespec atsBlinkingIntervals[] = {{0, 125000000}, {0, 250000000}, {0, 500000000}};
static const size_t nBlinkingIntervalsCount = sizeof(atsBlinkingIntervals) / sizeof(*atsBlinkingIntervals);

static const char *strLastOrientation = NULL;

/// @brief File descriptors - initialized to invalid value
static int fdEpoll = -1;
static int fdBlinkRateButtonGpio = -1;
static int fdSendMessageButtonGpio = -1;
static int fdAppStatusLedGpio = -1;
static int fdWifiStatusLedGpio = -1;
static int fdButtonPollTimer = -1;
static int fdUserLedBlinkTimer = -1;
static int fdAppStatusLedFlashTimer = -1;
static int fdTelemetryTimer = -1;
static int fdResetTimer = -1;
static int fdMqttReconnectTimer = -1;
static int fdMqttWorkTimer = -1;
static int fdSensorI2c = -1;

/// @brief tsTelemetryInterval is set to send teleletry every 30 seconds
static const struct timespec tsTelemetryInterval = {30, 0};
static const struct timespec tsMqttReconnectInterval = {5, 0};
static const struct timespec tsMqttWorkInterval = {1, 0};

/// @brief default tsResetDelay is set to reboot after 5 second (overridden by resetTimer property)
static struct timespec tsResetDelay = { 5, 0 };


static const char cstrMsgPressed[] = "pressed";
static const char cstrMsgApplicationStarted[] = "Application started";
static char strWiFiStatus[128];
static size_t nLastTotalMemoryUsed = 0;
static size_t nLastUserMemoryUsed = 0;


// LED state
static RgbLed rgbUserLed = RGBLED_INIT_VALUE;
static RgbLed *rgbLeds[] = {&rgbUserLed };
static const size_t nLedCount = sizeof(rgbLeds) / sizeof(*rgbLeds);

// Default blinking rate of UserLed
static struct timespec tsBlinkingLedInterval = {0, 125000000};
static bool bBlinkingLedState;

// A null interval to not start the timer when it is created with CreateTimerFdAndAddToEpoll.
static const struct timespec tsNullInterval = {0, 0};

// AppStatusLed flashes for 300ms 
static const struct timespec tsAppStatusLedBlinkTime = {0, 300 * 1000 * 1000};

// forward declarations for timer handler
static void ButtonPollTimerHandler(EventData* eventData);
static void UserLedUpdateHandler(EventData* eventData);
static void AppStatusLedUpdateHandler(EventData* eventData);
static void TelemetryTimerHandler(EventData* eventData);
static void ResetTimerHandler(EventData* eventData);
static void MqttReconnectTimerHandler(EventData *eventData);
static void MqttWorkTimerHandler(EventData *eventData);

// event handler data structures. Only the event handler field needs to be populated.
static EventData evtdataButtonPollTimer = { .eventHandler = &ButtonPollTimerHandler };
static EventData evtdataUserLedUpdate = { .eventHandler = &UserLedUpdateHandler };
static EventData evtdataAppStatusLedUpdate = { .eventHandler = &AppStatusLedUpdateHandler };
static EventData evtdataTelemetryTimer = { .eventHandler = &TelemetryTimerHandler };
static EventData evtdataResetTimer = { .eventHandler = &ResetTimerHandler };
static EventData evtdataMqttReconnectTimer = { .eventHandler = &MqttReconnectTimerHandler };
static EventData evtdataMqttWorkTimer = { .eventHandler = &MqttWorkTimerHandler };


// forward declarations for close handlers
void ClosePeripheralsAndHandlers(void);

///  @brief network connectivety status. Frequently updated in ButtonPollTimerHandler
static bool bIsNetworkReady = false;

/// @brief Device authentication status. Also frequently updated in ButtonPollTimerHandler. This is used to determine if the Azure Sphere Device ID can be retrieved.
static bool bIsDeviceAuthReady = false;

///  @brief 
/// Reason for reconnect/last disconnect
/// 
static const char* pstrConnectionStatus = cstrMsgApplicationStarted;

///  @brief 
/// Current blink-rate preset.
static size_t nBlinkRateValue = 0;

///  @brief 
/// Termination state
/// 
static volatile sig_atomic_t terminationRequired = false;

static const char szMqttCommandSetBlinkRate[] = "blink_rate";
static const char szMqttCommandSetLedColor[] = "led_color";
static const char szMqttCommandReset[] = "reset";

static const MqttCommand aMqttCommands[] = {
    {szMqttCommandSetBlinkRate, &MqttCommandHandler_SetBlinkRate, NULL},
    {szMqttCommandSetLedColor, &MqttCommandHandler_SetLedColor, NULL},
    {szMqttCommandReset, &MqttCommandHandler_Reset, NULL}
};

#define MQTT_COMMANDS_COUNT (sizeof(aMqttCommands) / sizeof(*aMqttCommands))



///  @brief 
///     Signal handler for termination requests. This handler must be async-signal-safe.
/// 
/// @param signalNumber Signal received by the process.
static void TerminationHandler(int signalNumber)
{
    // Don't use Log_Debug here, as it is not guaranteed to be async-signal-safe.
    terminationRequired = true;
}


///  @brief 
///     Show details of the currently connected WiFi network.
/// 
static void DebugPrintCurrentlyConnectedWiFiNetwork(void)
{
    char szBuffer[128];
    int nPos=0, nChar = 0;
    WifiConfig_ConnectedNetwork network;
    szBuffer[0] = '\0';

    int result = WifiConfig_GetCurrentNetwork(&network);
    if (result < 0) {
        if( (nChar=snprintf(&szBuffer[nPos], sizeof(szBuffer)-(size_t)nPos, 
                            "WiFi Disconnected. ")) >= 0){
            nPos+=nChar;
        }
    } else {
        if( (nChar=snprintf(&szBuffer[nPos], sizeof(szBuffer)-(size_t)nPos, 
                            "SSID \"%.*s\", Freq:%dMHz, Sig:%d. ", 
                            network.ssidLength, network.ssid, network.frequencyMHz, network.signalRssi)) >= 0){
            nPos+=nChar;
        }
    }
    Networking_Interface_HardwareAddress hwAddress;
    result = Networking_GetHardwareAddress( "wlan0", &hwAddress);
    if( result < 0){
        if( (nChar=snprintf(&szBuffer[nPos], sizeof(szBuffer)-(size_t)nPos, 
                            "[ERR] No MAC. ")) >= 0){
            nPos+=nChar;
        }
    } else {
        if( (nChar=snprintf(&szBuffer[nPos], sizeof(szBuffer)-(size_t)nPos, 
                            "MAC %02x:%02x:%02x:%02x:%02x:%02x. ",
                            hwAddress.address[0], hwAddress.address[1],
                            hwAddress.address[2], hwAddress.address[3],
                            hwAddress.address[4], hwAddress.address[5])) >= 0){
            nPos+=nChar;
        }
    }
    Log_Debug("[INFO] %s\n", szBuffer);
    strncpy( strWiFiStatus, szBuffer, sizeof(strWiFiStatus));
}

///  @brief 
///     Helper function to blink AppStatusLed once.
/// 
/// @param color LED color whose blink timer duration determines the blink behavior.
static void BlinkAppStatusLedOnce( RgbLedUtility_Colors color )
{
    GPIO_SetValue( fdAppStatusLedGpio, GPIO_Value_Low );
    SetTimerFdToSingleExpiry(fdAppStatusLedFlashTimer, ((color == RgbLedUtility_Colors_Red) ? &tsAppStatusLedBlinkTime : &tsAppStatusLedBlinkTime));
}

///  @brief 
///     Helper function to open a file descriptor for the given GPIO as input mode.
/// 
/// @param  gpioId      The GPIO to open.
/// @param  outGpioFd   File descriptor of the opened GPIO.
/// @returns    
///     True    if successful
///     false   if an error occurred.
static bool OpenGpioFdAsInput(GPIO_Id gpioId, int *outGpioFd)
{
    *outGpioFd = GPIO_OpenAsInput(gpioId);
    if (*outGpioFd < 0) {
        Log_Debug("ERROR: Could not open GPIO '%d': %d (%s).\n", gpioId, errno, strerror(errno));
        return false;
    }

    return true;
}




/// @brief Toggles the blink speed of the blink LED between 3 values.
/// @param nValue       new Blink rate (index into timespec table)
/// @returns actual blink rate set (in bounds)
static size_t SetLedRate(size_t nValue)
{
    nBlinkRateValue = (nValue >= nBlinkingIntervalsCount) ? 0 : nValue; //clamp to array size 
    const struct timespec * pBlinkRate = &atsBlinkingIntervals[nBlinkRateValue];

    if (SetTimerFdToPeriod(fdUserLedBlinkTimer, pBlinkRate) != 0) {
        Log_Debug("ERROR: could not set the period of the LED.\n");
        terminationRequired = true;
        return 0;
    }

    return nBlinkRateValue;
}


/// @brief Publish an application event.
/// @param event Event name used to construct the MQTT topic.
/// @param payload Event payload to publish.
static void PublishEvent(const char *event, const char *payload)
{
    char topic[128];
    int length = snprintf(topic, sizeof(topic), "avnet_sk2/event/%s", event);
    if (length < 0 || (size_t)length >= sizeof(topic) ||
        !MqttClient_Publish(topic, payload, false)) {
        Log_Debug("[MQTT] Failed to publish event %s.\n", event);
        BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
        return;
    }
    BlinkAppStatusLedOnce(RgbLedUtility_Colors_Green);
}

/// @brief Publish Home Assistant discovery configuration for a sensor.
/// @param id Sensor identifier and MQTT state suffix.
/// @param name Human-readable sensor name.
/// @param attributes Additional JSON attributes appended to the discovery payload.
static void PublishSensorDiscovery(const char *id, const char *name, const char *attributes)
{
    char topic[160];
    char payload[768];
    int topicLength = snprintf(topic, sizeof(topic), "homeassistant/sensor/avnet_sk2_%s/config", id);
    int payloadLength = snprintf(
        payload, sizeof(payload),
        "{\"name\":\"AVNET %s\",\"unique_id\":\"avnet_sk2_%s\","
        "\"state_topic\":\"avnet_sk2/sensor/%s\",\"availability_topic\":\"avnet_sk2/status\","
        "\"payload_available\":\"online\",\"payload_not_available\":\"offline\","
        "\"device\":{\"identifiers\":[\"avnet_sk2\"],\"name\":\"AVNET Starter Kit\","
        "\"manufacturer\":\"AVNET\",\"model\":\"MT3620 Starter Kit Rev2\"}%s}",
        name, id, id, attributes);

    Log_Debug("[MQTT] Publishing discovery for sensor %s as\n\t%s\n", id, payload);
    if (topicLength < 0 || (size_t)topicLength >= sizeof(topic) || payloadLength < 0 ||
        (size_t)payloadLength >= sizeof(payload) ||
        !MqttClient_Publish(topic, payload, true)) {
        Log_Debug("[MQTT] Failed to publish Home Assistant discovery for sensor %s.\n", id);
    }
}

/// @brief Publish Home Assistant discovery configuration for sensors and controls.
static void PublishDiscovery(void)
{
    PublishSensorDiscovery("temperature", "Temperature",
                           ",\"unit_of_measurement\":\"°C\",\"device_class\":\"temperature\","
                           "\"state_class\":\"measurement\"");
    PublishSensorDiscovery("pressure", "Pressure",
                           ",\"unit_of_measurement\":\"hPa\",\"device_class\":\"pressure\","
                           "\"state_class\":\"measurement\"");
    PublishSensorDiscovery("acceleration_x", "Acceleration X",
                           ",\"unit_of_measurement\":\"m/s²\",\"state_class\":\"measurement\"");
    PublishSensorDiscovery("acceleration_y", "Acceleration Y",
                           ",\"unit_of_measurement\":\"m/s²\",\"state_class\":\"measurement\"");
    PublishSensorDiscovery("acceleration_z", "Acceleration Z",
                           ",\"unit_of_measurement\":\"m/s²\",\"state_class\":\"measurement\"");
    PublishSensorDiscovery("orientation", "Orientation", "");
    PublishSensorDiscovery("total_memory", "Total Memory Used",
                           ",\"unit_of_measurement\":\"kB\",\"state_class\":\"measurement\"");
    PublishSensorDiscovery("user_memory", "User Memory Used",
                           ",\"unit_of_measurement\":\"kB\",\"state_class\":\"measurement\"");

    static const char blinkRateConfig[] =
        "{\"name\":\"AVNET LED Blink Rate\",\"unique_id\":\"avnet_sk2_blink_rate\","
        "\"state_topic\":\"avnet_sk2/control/blink_rate\","
        "\"command_topic\":\"avnet_sk2/command/blink_rate\",\"min\":0,\"max\":2,\"step\":1,"
        "\"mode\":\"slider\",\"availability_topic\":\"avnet_sk2/status\","
        "\"payload_available\":\"online\",\"payload_not_available\":\"offline\","
        "\"device\":{\"identifiers\":[\"avnet_sk2\"],\"name\":\"AVNET Starter Kit\","
        "\"manufacturer\":\"AVNET\",\"model\":\"MT3620 Starter Kit Rev2\"}}";
    static const char ledColorConfig[] =
        "{\"name\":\"AVNET LED Color\",\"unique_id\":\"avnet_sk2_led_color\","
        "\"state_topic\":\"avnet_sk2/control/led_color\","
        "\"command_topic\":\"avnet_sk2/command/led_color\","
        "\"options\":[\"white\",\"blue\",\"cyan\",\"green\",\"red\",\"yellow\",\"magenta\",\"off\"],"
        "\"availability_topic\":\"avnet_sk2/status\",\"payload_available\":\"online\","
        "\"payload_not_available\":\"offline\",\"device\":{\"identifiers\":[\"avnet_sk2\"],"
        "\"name\":\"AVNET Starter Kit\",\"manufacturer\":\"AVNET\","
        "\"model\":\"MT3620 Starter Kit Rev2\"}}";
    static const char resetConfig[] =
        "{\"name\":\"AVNET Restart\",\"unique_id\":\"avnet_sk2_restart\","
        "\"command_topic\":\"avnet_sk2/command/reset\",\"payload_press\":\"5\","
        "\"availability_topic\":\"avnet_sk2/status\",\"payload_available\":\"online\","
        "\"payload_not_available\":\"offline\",\"device\":{\"identifiers\":[\"avnet_sk2\"],"
        "\"name\":\"AVNET Starter Kit\",\"manufacturer\":\"AVNET\","
        "\"model\":\"MT3620 Starter Kit Rev2\"}}";

    if (!MqttClient_Publish("homeassistant/number/avnet_sk2_blink_rate/config",
                            blinkRateConfig, true) ||
        !MqttClient_Publish("homeassistant/select/avnet_sk2_led_color/config", ledColorConfig,
                            true) ||
        !MqttClient_Publish("homeassistant/button/avnet_sk2_restart/config", resetConfig, true)) {
        Log_Debug("[MQTT] Failed to publish Home Assistant control discovery.\n");
    }
}

/// @brief Publish the current LED blink-rate and color control states.
static void PublishControlState(void)
{
    char blinkRate[8];
    snprintf(blinkRate, sizeof(blinkRate), "%u", (unsigned)nBlinkRateValue);
    if (!MqttClient_Publish("avnet_sk2/control/blink_rate", blinkRate, true) ||
        !MqttClient_Publish("avnet_sk2/control/led_color",
                            RgbLedUtility_GetStringFromColor(colBlinkingLedColor), true)) {
        Log_Debug("[MQTT] Failed to publish LED control state.\n");
    }
}

/// @brief Read sensors and publish a combined JSON telemetry payload.
static void SendTelemetry(void)
{
    if (!MqttClient_IsConnected()) {
        Log_Debug("[MQTT] Not connected; sensor telemetry was not sent.\n");
        BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
        return;
    }

    JSON_Value *rootValue = json_value_init_object();
    if (rootValue == NULL) {
        Log_Debug("[MQTT] Failed to allocate telemetry JSON.\n");
        return;
    }
    JSON_Object *root = json_value_get_object(rootValue);

    vector3d_t vector;
    if (Sensors_GetAcceleration(&vector)) {
        JSON_Value *accelerationValue = json_value_init_object();
        if (accelerationValue != NULL) {
            JSON_Object *acceleration = json_value_get_object(accelerationValue);
            if (acceleration != NULL) {
                json_object_set_number(acceleration, "x", vector.x);
                json_object_set_number(acceleration, "y", vector.y);
                json_object_set_number(acceleration, "z", vector.z);
                json_object_set_value(root, "acceleration", accelerationValue);
            } else {
                json_value_free(accelerationValue);
            }
        }
        strLastOrientation = Sensors_GetOrientation(&vector);
        json_object_set_string(root, "orientation", strLastOrientation);
    }

    // Read the accelerometer before the pressure sensor, which resets the accelerometer.
    envdata_t dataset;
    if (Sensors_GetEnvironmentData(&dataset)) {
        Log_Debug("[Send] Temperature: %.2f C, Pressure: %.2f hPa\n", dataset.fTemperature,
                  dataset.fPressure_hPa);
        json_object_set_number(root, "temperature", dataset.fTemperature);
        json_object_set_number(root, "pressure", dataset.fPressure_hPa);
    }

    size_t totalMemoryUsed = Applications_GetTotalMemoryUsageInKB();
    size_t userMemoryUsed = Applications_GetUserModeMemoryUsageInKB();
    nLastTotalMemoryUsed = totalMemoryUsed;
    nLastUserMemoryUsed = userMemoryUsed;
    json_object_set_number(root, "total_memory_kb", (double)totalMemoryUsed);
    json_object_set_number(root, "user_memory_kb", (double)userMemoryUsed);

    char *payload = json_serialize_to_string(rootValue);
    if (payload != NULL) {
        char topic[] = "avnet_sk2/telemetry";
        if (!MqttClient_Publish(topic, payload, false)) {
            Log_Debug("[MQTT] Failed to publish combined telemetry JSON.\n");
            BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
        } else {
            BlinkAppStatusLedOnce(RgbLedUtility_Colors_Green);
        }
        json_free_serialized_string(payload);
    } else {
        Log_Debug("[MQTT] Failed to serialize telemetry JSON.\n");
        BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
    }
    json_value_free(rootValue);
}

/// @brief Parse an integer MQTT command and validate its inclusive range.
/// @param payload MQTT command payload.
/// @param payloadSize Number of bytes in payload.
/// @param minimum Minimum permitted value.
/// @param maximum Maximum permitted value.
/// @param value Receives the parsed value when parsing succeeds.
/// @returns True if the payload contains a valid integer within the requested range.
static bool ParseIntegerCommand(const char *payload, size_t payloadSize, long minimum, long maximum,
                               long *value)
{
    char buffer[16];
    if (payloadSize == 0 || payloadSize >= sizeof(buffer)) {
        return false;
    }
    memcpy(buffer, payload, payloadSize);
    buffer[payloadSize] = '\0';

    char *end = NULL;
    long parsed = strtol(buffer, &end, 10);
    if (end != buffer + payloadSize || parsed < minimum || parsed > maximum) {
        return false;
    }
    *value = parsed;
    return true;
}

/// @brief Handle an MQTT command or ignore retained command payloads.
/// @param topic MQTT topic that received the message.
/// @param payload MQTT message payload.
/// @param payloadSize Number of bytes in payload.
/// @param retained True if the broker delivered a retained publish.
static void MqttMessageReceived(const char *topic, const char *payload, size_t payloadSize,
                                bool retained)
{
    BlinkAppStatusLedOnce(RgbLedUtility_Colors_Blue);
    if (retained) {
        Log_Debug("[MQTT] Ignoring retained command on %s.\n", topic);
        return;
    }

    if (strcmp(topic, "avnet_sk2/command/blink_rate") == 0) {
        long rate;
        if (ParseIntegerCommand(payload, payloadSize, 0, 2, &rate)) {
            SetLedRate((size_t)rate);
            PublishControlState();
        } else {
            Log_Debug("[MQTT] Invalid blink-rate command.\n");
            BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
        }
    } else if (strcmp(topic, "avnet_sk2/command/led_color") == 0) {
        RgbLedUtility_Colors color =
            RgbLedUtility_GetColorFromString(payload, payloadSize);
        if (color != RgbLedUtility_Colors_Unknown) {
            colBlinkingLedColor = color;
            PublishControlState();
        } else {
            Log_Debug("[MQTT] Invalid LED color command.\n");
            BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
        }
    } else if (strcmp(topic, "avnet_sk2/command/reset") == 0) {
        long resetSeconds;
        if (ParseIntegerCommand(payload, payloadSize, 2, 9, &resetSeconds)) {
            tsResetDelay.tv_sec = (time_t)resetSeconds;
            if (SetTimerFdToSingleExpiry(fdResetTimer, &tsResetDelay) != 0) {
                terminationRequired = true;
            }
            Log_Debug("[MQTT] Restart timer set to %ld seconds.\n", resetSeconds);
        } else {
            Log_Debug("[MQTT] Invalid reset command; expected 2 through 9 seconds.\n");
            BlinkAppStatusLedOnce(RgbLedUtility_Colors_Red);
        }
    }
}

/// @brief Update application MQTT state and configure subscriptions and discovery.
/// @param connected True when connected to the broker; false after disconnection.
static void MqttConnectionChanged(bool connected)
{
    if (!connected) {
        Log_Debug("[MQTT] Broker disconnected.\n");
        SetTimerFdToPeriod(fdTelemetryTimer, &tsNullInterval);
        SetTimerFdToPeriod(fdMqttWorkTimer, &tsNullInterval);
        SetTimerFdToPeriod(fdMqttReconnectTimer, &tsMqttReconnectInterval);
        pstrConnectionStatus = "MQTT disconnected";
        return;
    }

    Log_Debug("[MQTT] Broker connected.\n");
    DebugPrintCurrentlyConnectedWiFiNetwork();
    PublishEvent("connect", strWiFiStatus);
    PublishEvent("connect", pstrConnectionStatus);
    pstrConnectionStatus = "MQTT connected";


    for (size_t i = 0; i < sizeof(apszMqttCommands ) / sizeof(apszMqttCommands[0]); ++i) {
        MqttClient_CreateCommandTopic(apszMqttCommands[i], );
        if (!MqttClient_Subscribe(apszMqttCommands[i])) {
            Log_Debug("[MQTT] Failed to subscribe to %s.\n", apszMqttCommands[i]);
        }
    }

    PublishDiscovery();
    MqttClient_Publish("avnet_sk2/status", "online", true);
    PublishControlState();

    SetTimerFdToPeriod(fdTelemetryTimer, &tsTelemetryInterval);
    SetTimerFdToPeriod(fdMqttWorkTimer, &tsMqttWorkInterval);
    SetTimerFdToPeriod(fdMqttReconnectTimer, &tsNullInterval);
}

///  @brief 
///     Handle the blinking for UserLed.
/// 
/// @param eventData Timer event data containing the timer file descriptor.
static void UserLedUpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdUserLedBlinkTimer) != 0) {
        terminationRequired = true;
        return;
    }

    // Trigger UserLed to blink as appropriate.
    bBlinkingLedState = !bBlinkingLedState;
    RgbLedUtility_Colors color = (bBlinkingLedState ? colBlinkingLedColor : RgbLedUtility_Colors_Off);
    RgbLedUtility_SetLed(&rgbUserLed, color);
}

///  @brief 
///     Handle the blinking for the AppStatus LED.
/// 
/// @param eventData Timer event data containing the timer file descriptor.
static void AppStatusLedUpdateHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdAppStatusLedFlashTimer) != 0) {
        terminationRequired = true;
        return;
    }

    // Clear the send/receive AppStatusLed.
    GPIO_SetValue( fdAppStatusLedGpio, GPIO_Value_High);
}

///  @brief 
///     Check whether a given button has just been pressed.
/// 
/// @param fd The button file descriptor.
/// @param oldState Pointer to the previously observed button state.
/// @returns true if pressed, false otherwise
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


///  @brief 
/// Show network and MQTT broker connectivity status.
///
void NetworkLedUpdateHandler(void)
{
    Networking_IsNetworkingReady(&bIsNetworkReady);
    GPIO_SetValue(fdWifiStatusLedGpio,
                  (bIsNetworkReady && MqttClient_IsConnected()) ? GPIO_Value_Low : GPIO_Value_High);
}


///  @brief 
///     Handle button timer event: if the button is pressed, change the LED blink rate.
/// 
/// @param eventData Timer event data containing the timer file descriptor.
void ButtonPollTimerHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(fdButtonPollTimer) != 0) {
        terminationRequired = true;
        return;
    }

    NetworkLedUpdateHandler();

    // Button A changes the blink rate and publishes the event.
    static GPIO_Value_Type blinkButtonState;
    if (IsButtonPressed(fdBlinkRateButtonGpio, &blinkButtonState)) {
        SetLedRate( nBlinkRateValue + 1 );
        if (MqttClient_IsConnected()) {
            PublishControlState();
            PublishEvent("button_a", cstrMsgPressed);
        }
    }

    // Button B publishes an event and triggers an immediate sensor update.
    static GPIO_Value_Type messageButtonState;
    if (IsButtonPressed(fdSendMessageButtonGpio, &messageButtonState)) {
        if (MqttClient_IsConnected()) {
		    PublishEvent("button_b", cstrMsgPressed);
		    SendTelemetry();
        }
    }
}


///  @brief 
///     Handle telemetry timer event.
/// 
/// @param eventData Timer event data containing the timer file descriptor.
void TelemetryTimerHandler(EventData *eventData)
{
	if (ConsumeTimerFdEvent(eventData->fd) != 0) {
		terminationRequired = true;
		return;
	}

	SendTelemetry();
}

/// @brief Reconnect to the MQTT broker when networking becomes ready.
/// @param eventData Timer event data containing the timer file descriptor.
static void MqttReconnectTimerHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(eventData->fd) != 0) {
        terminationRequired = true;
        return;
    }

    if (!MqttClient_IsConnected())
    {
        bIsNetworkReady = false;
        bIsDeviceAuthReady = false;

        Networking_IsNetworkingReady(&bIsNetworkReady);
        if( bIsNetworkReady )
        {
            Application_IsDeviceAuthReady(&bIsDeviceAuthReady);
            if( bIsDeviceAuthReady )
            {  
                Log_Debug( "[MqttReconnectTimerHandler] Network & Auth ready, attempting MQTT reconnect.\n");
                MqttClient_InitDeviceId();
                MqttClient_Reconnect();
            }
        }
    } else {
        Log_Debug( "[MqttReconnectTimerHandler] MQTT already connected, stopping reconnect timer.\n");
        SetTimerFdToSingleExpiry(fdMqttReconnectTimer, &tsNullInterval);
    }
}

/// @brief Perform MQTT client background work and keepalive processing.
/// @param eventData Timer event data containing the timer file descriptor.
static void MqttWorkTimerHandler(EventData *eventData)
{
    if (ConsumeTimerFdEvent(eventData->fd) != 0) {
        terminationRequired = true;
        return;
    }

    MqttClient_DoWork();
}

// forward declaration to allow reset function to gracefuly close all connections
void ClosePeripheralsAndHandlers(void);
int InitPeripheralsAndHandlers(int argc, char *argv[]);

///  @brief 
///     Handle reset timer event.
/// 
/// @param eventData Timer event data containing the timer file descriptor.
void ResetTimerHandler(EventData* eventData)
{
    if (ConsumeTimerFdEvent(eventData->fd) != 0) {
        terminationRequired = true;
        return;
    }

    Log_Debug("[ResetTimerHandler] Gracefully closing and forcing system reboot.\n");
    ClosePeripheralsAndHandlers();

    if( -1 == PowerManagement_ForceSystemReboot())
    {
        Log_Debug("[ResetTimerHandler] Reboot failed %d (%s).\n", errno, strerror(errno));
    }
}

///  @brief  Initialize peripherals, termination handler, and MQTT
/// @param  argc command line argument count
/// @param  argv command line argument vector
/// @returns 0 on success, or -1 on failure
int InitPeripheralsAndHandlers(int argc, char *argv[])
{
    // Register a SIGTERM handler for termination requests
    struct sigaction action;
    memset(&action, 0, sizeof(struct sigaction));
    action.sa_handler = TerminationHandler;
    sigaction(SIGTERM, &action, NULL);


    // Open button A
    Log_Debug("INFO: Opening AVNET_MT3620_SK_USER_BUTTON_A.\n");
    if (!OpenGpioFdAsInput(AVNET_MT3620_SK_USER_BUTTON_A, &fdBlinkRateButtonGpio)) {
        return -1;
    }

    // Open button B
    Log_Debug("INFO: Opening AVNET_MT3620_SK_USER_BUTTON_B.\n");
    if (!OpenGpioFdAsInput(AVNET_MT3620_SK_USER_BUTTON_B, &fdSendMessageButtonGpio)) {
        return -1;
    }

    // Open Wifi status LED
    Log_Debug("INFO: Opening AVNET_MT3620_SK_WLAN_STATUS_LED_YELLOW.\n");
    fdWifiStatusLedGpio = GPIO_OpenAsOutput(AVNET_MT3620_SK_WLAN_STATUS_LED_YELLOW, GPIO_OutputMode_PushPull, GPIO_Value_High );
    if (fdWifiStatusLedGpio < 0) {
        Log_Debug( "ERROR: cannot open AVNET_MT3620_SK_WLAN_STATUS_LED_YELLOW as output.");
        return -1;
    }

    // Open Wifi status LED
    Log_Debug("INFO: Opening AVNET_MT3620_SK_APP_STATUS_LED_YELLOW.\n");
    fdAppStatusLedGpio = GPIO_OpenAsOutput(AVNET_MT3620_SK_APP_STATUS_LED_YELLOW, GPIO_OutputMode_PushPull, GPIO_Value_High );
    if (fdAppStatusLedGpio < 0) {
        Log_Debug( "ERROR: cannot open AVNET_MT3620_SK_APP_STATUS_LED_YELLOW as output.");
        return -1;
    }

    Log_Debug("INFO: Opening AVNET_MT3620_SK_ISU2_I2C.\n");
    if ((fdSensorI2c = I2CMaster_Open(AVNET_MT3620_SK_ISU2_I2C)) < 0)
    {
        return -1;
    }
    Sensors_Init( fdSensorI2c );
    strLastOrientation = Sensors_GetOrientation( NULL );

    // Open file descriptors for the RGB LEDs and store them in the rgbLeds array (and in turn in
    // the ledBlink, ledMessageEventSentReceived, ledNetworkStatus variables)
    RgbLedUtility_OpenLeds(rgbLeds, nLedCount, gpioLedPins);

#ifdef BME280
    // Initialize I2C sensor(s)
    Log_Debug("INFO: Initializing BME280 I2C sensor on primary address.\n");
    bool bInitSuccessful = BME280_Init(fdSensorI2c, true);
    if (!bInitSuccessful) {
        return -1;
    }
#endif

#ifdef BMP280
    // Initialize I2C sensor(s)
    Log_Debug("INFO: Initializing BMP280 I2C sensor on primary address.\n");
    bool bInitSuccessful = BMP280_Init(fdSensorI2c, true);
    if (!bInitSuccessful) {
        return -1;
    }
#endif

    // Display the currently connected WiFi connection.
    DebugPrintCurrentlyConnectedWiFiNetwork();

    fdEpoll = CreateEpollFd();
    if (fdEpoll < 0) {
        return -1;
    }

    // Set up a timer for UserLed blinking
    fdUserLedBlinkTimer =
        CreateTimerFdAndAddToEpoll(fdEpoll, &tsBlinkingLedInterval, &evtdataUserLedUpdate, EPOLLIN);
    if (fdUserLedBlinkTimer < 0) {
        return -1;
    }

    // Set up a a dis-armed timer for blinking AppStatusLed once.
    fdAppStatusLedFlashTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullInterval, &evtdataAppStatusLedUpdate, EPOLLIN);
    if (fdAppStatusLedFlashTimer < 0) {
        return -1;
    }

    // Set up a timer for buttons status check
    static struct timespec buttonsPressCheckPeriod = {0, 1000000};
    fdButtonPollTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &buttonsPressCheckPeriod,
                                                   &evtdataButtonPollTimer, EPOLLIN);
    if (fdButtonPollTimer < 0) {
        return -1;
    }


	// Set up a timer for telemetry intervals
	fdTelemetryTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullInterval,
		&evtdataTelemetryTimer, EPOLLIN);
	if (fdTelemetryTimer < 0) {
		return -1;
	}

    // Set up a dis-armed timer for the reset interval
    fdResetTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullInterval,
        &evtdataResetTimer, EPOLLIN);
    if (fdResetTimer < 0) {
        return -1;
    }

    // Initialize the MqttClient data structures
    if (!MqttClient_Init(fdEpoll, argc, argv, MqttMessageReceived, MqttConnectionChanged)) {
        Log_Debug("ERROR: Cannot initialize the MQTT client.\n");
        return -1;
    }

    // Create a timer for the MQTT client reconnect attempts. This timer is armed by default to wait until network and authentication are available, 
    // disarmed when the MQTT client connects to the broker and re-armed when the MQTT client disconnects from the broker.
    fdMqttReconnectTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsMqttReconnectInterval,
        &evtdataMqttReconnectTimer, EPOLLIN);
    if (fdMqttReconnectTimer < 0) {
        return -1;
    }

    // Create a disarmed timer for the MQTT client work and keepalive processing. This timer is armed when the MQTT client connects to the broker.
    fdMqttWorkTimer = CreateTimerFdAndAddToEpoll(fdEpoll, &tsNullInterval,
        &evtdataMqttWorkTimer, EPOLLIN);
    if (fdMqttWorkTimer < 0) {
        return -1;
    }

    return 0;
}

///  @brief 
///     Close peripherals and MQTT
/// 
void ClosePeripheralsAndHandlers(void)
{
    Log_Debug("INFO: Closing GPIOs and MQTT client.\n");

    MqttClient_Close();
    // Close timer file descriptors
    CloseFdAndPrintError(fdMqttWorkTimer, "MqttWorkTimer");
    CloseFdAndPrintError(fdMqttReconnectTimer, "MqttReconnectTimer");
    CloseFdAndPrintError(fdResetTimer, "ResetTimer");
    CloseFdAndPrintError(fdTelemetryTimer, "TelemetryTimer");
    CloseFdAndPrintError(fdButtonPollTimer, "ButtonPollTimer");
    CloseFdAndPrintError(fdAppStatusLedFlashTimer, "AppStatusLedBlinkTimer");
    CloseFdAndPrintError(fdUserLedBlinkTimer, "UserLedBlinkTimer");
    CloseFdAndPrintError(fdEpoll, "Epoll");

    // Close IO file descriptors
    CloseFdAndPrintError(fdBlinkRateButtonGpio, "LedBlinkRateButtonGpio");
    CloseFdAndPrintError(fdSendMessageButtonGpio, "SendMessageButtonGpio");
    CloseFdAndPrintError(fdSensorI2c, "I2C ISU3");

    // Close the LEDs and leave then off
    RgbLedUtility_CloseLeds(rgbLeds, nLedCount);

}

///  @brief 
///     Main entry point for this application.
/// 
/// @param argc Number of command-line arguments.
/// @param argv Command-line argument vector.
/// @returns Zero after the application shuts down.
int main(int argc, char *argv[])
{
    Log_Debug("INFO: AVNET Starter Kit MQTT application starting.\n");

    int initResult = InitPeripheralsAndHandlers(argc, argv);
    if (initResult != 0) {
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
