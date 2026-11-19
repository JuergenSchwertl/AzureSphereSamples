## Connect an AVNET Starter Kit Rev2 to Home Assistant over MQTT

This application publishes sensor readings to an MQTT broker and uses Home Assistant MQTT
discovery to create entities automatically. It does not use Azure IoT Hub, DPS, or IoT Central.

### Broker setup

Enable the Home Assistant MQTT integration and configure a broker reachable from the device.
The default broker is `homeassistant.local` on TCP port `1883`; this matches the manifest's
`AllowedConnections` entry. If your broker uses a different host, update that entry in
`app_manifest.json` and pass the new broker host to the application.

The client supports the following arguments:

| Argument | Default | Description |
| --- | --- | --- |
| `--Broker` | `homeassistant.local` | MQTT broker hostname or IP address |
| `--Port` | `1883` | MQTT TCP port |
| `--Password` | empty | MQTT password. The Azure Sphere Device ID is always used as the MQTT username. |
| `--ClientId` | Azure Sphere Device ID | Optional MQTT client identifier |

Azure Sphere passes application arguments from the manifest's `CmdArgs` array. For example,
to configure an authenticated broker, use:

```json
"CmdArgs": [
  "--Broker", "homeassistant.local",
  "--Port", "1883",
  "--Password", "mqtt-password"
]
```

**Security:** this client uses plain MQTT over TCP; it does not support TLS. MQTT credentials
are sent unencrypted and arguments embedded in `CmdArgs` are included in the application
package. Use only on a trusted network with an appropriately isolated broker; do not use
this configuration over an untrusted network.

### Home Assistant entities and MQTT topics

Home Assistant discovery creates temperature, pressure, acceleration, orientation, memory,
LED blink-rate, LED color, and restart entities. Sensor state is published every 30 seconds
and immediately after connecting or pressing button B. Button events are published on
`avnet_sk2/event/button_a` and `avnet_sk2/event/button_b`.

Sensor telemetry is combined into a single JSON payload on `avnet_sk2/telemetry`, containing
temperature, pressure, acceleration, orientation, and memory values. This minimizes MQTT
packet traffic compared with publishing each sensor value separately.

The blink-rate number accepts `0` through `2`, and the color select accepts `white`, `blue`,
`cyan`, `green`, `red`, `yellow`, `magenta`, or `off`. These command topics are subscribed:

* `avnet_sk2/command/blink_rate`
* `avnet_sk2/command/led_color`
* `avnet_sk2/command/reset` (a value from `2` through `9` seconds)

Commands should not be retained. Retained commands are ignored to prevent old commands from
being replayed after a reconnect. Discovery and state values are retained; broker availability
is reported on `avnet_sk2/status`.

### Building

Build this project using the Azure Sphere SDK and the ARM-Debug or ARM-Release CMake
configuration. The MQTT-C library is included as the `MQTT-C` Git submodule. Initialize submodules after
checkout and build the project with the Azure Sphere SDK.




---
[Back to root](../README.MD)

---

### Disclaimer

#### Sample code - No Warranties
THE SAMPLE CODE SOFTWARE IS PROVIDED "AS IS" AND WITHOUT WARRANTY.TO THE MAXIMUM EXTENT 
PERMITTED BY LAW, MICROSOFT DISCLAIMS ANY AND ALL OTHER WARRANTIES, WHETHER EXPRESS OR 
IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OF MERCHANTABILITY, 
NON - INFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE, WHETHER ARISING BY A COURSE 
OF DEALING, USAGE OR TRADE PRACTICE OR COURSE OF PERFORMANCE.
In no event shall Microsoft, its licensors, the authors or copyright holders be liable 
for any claim, damages or other liability, whether in an action of contract, tort or 
otherwise, arising from, out of or in connection with the software or the use thereof.

This code may contain errors and/or may not operate correctly. Microsoft undertakes no 
duty to correct any errors or update the software. Your use of this code is optional and 
subject to any license provided therewith or referenced therein, if any. Microsoft does 
not provide you with any license or other rights to any Microsoft product or service 
through the code provided to you.
