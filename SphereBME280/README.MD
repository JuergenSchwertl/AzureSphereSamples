## Connecting an I2C sensor (Bosch BME280) and send telemetry to Azure IoT Central

In this example we will connect an I2C based sensor and send telemetry data to **Azure IoT Central**. In this example it is the 
Bosch BME280 temperature/humidity/pressure sensor.

The libBME280 project contains a wrapper library based on the original [Bosch driver](https://github.com/BoschSensortec/BME280_driver) for the 
Bosch BME280 temperature-, humidity- and pressure-sensor.

This sensor is e.g. available as [Seeed Groove BME280 sensor board](http://wiki.seeedstudio.com/Grove-Barometer_Sensor-BME280/) amongst other suppliers.

### Wiring the BME280 sensor

There are multiple sensor boards for the BME280 available (the Seeed Grove BME280 mentioned above looks slightly different but offers to use a Grove connector cable)
but essentially they all have the necessary power supply V(in) & GND and the I2C Pins *SDA* for data and *SCL* for clock called out on the printout.

| Purpose  | MT3620           |  BME280  | Pictured wire below |
|----------|------------------|:--------:|:-------------------:|
|Ground    | Header 3, pin 2  | Gnd      | green               |
|3.3 volts | Header 3, pin 3  | Vin/Vcc  | red                 |
|Data      | Header 4, pin 6  | SDA      | purple              |
|Clock     | Header 4, pin 12 | SCL      | blue                |

![MT3620 with connected DHT11 sensor](./Images/Lab_BME280.png)

In contrast to Azure IoT Hub (being a *Platform as a Service*/PaaS), Azure IoT Central is a complete
*Software as a Service*/SaaS solution. However, it is obviously built using existing PaaS 
services such as Azure IoT Hub, Azure IoT Device Provisioning Service amongst others 
but hides the individual building blocks under the hood.

With Azure Sphere this raises a specific question: **Where do you get the actual IoT Hub DNS-name and the DPS Scope ID to add as 
capability settings in the *appmanifest.json* and provision the app_manifest.json ?**

Fortunately the Azure Sphere product group has a tool available that unveils all that information for you. Please check the 
[Azure IoT Sample github repo](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/AzureIoT) .
In the [Tools directory](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/AzureIoT/Tools) You will find a tool called
`ShowIoTCentralConfig.exe` that nicely extracts all that information from IoT Central similar to the following:

<p style="background-color:black;color:white;left-indent:20px">
<b>ShowIoTCentralConfig.exe</b><br />
Tool to show Azure IoT Central configuration for Azure Sphere applications<br /><br />
Are you using a legacy (2018) IoT Central application (Y/N)<br />
> <b>N</b><br />
Enter the IoT Central App URL (e.g. https://myapp.azureiotcentral.com)<br />
> <b>https://**YOUR_IOTCENTRAL_APP**.azureiotcentral.com/</b><br />
You need to generate an Azure IoT Central application API Token (Adminstration | API tokens), this requires Application administrator rights
Enter your Azure IoT Central application API Token<br />
> <b>**Your API token from Administration -> API tokens ***</b><br />
Enter the ID Scope from the IoT Central App (Administration | Device connection)<br />
> <b>**Your DPS scope ID from Administration -> Device Connection ***</b><br /><br />
Find and modify the CmdArgs, AllowedConnections and DeviceAuthentication lines in your app_manifest.json so each includes the content from the below:<br />
<span style="background:blue">"CmdArgs": [ "--ConnectionType DPS", "--ScopeID 0ne000A5318" ],<br />
"Capabilities": {<br />
    "AllowedConnections": [ "global.azure-devices-provisioning.net", <br />
    "<b>iotc-d51104e7-3071-4dbe-b068-48fbd28598ad.azure-devices.net</b>"],<br />
    "DeviceAuthentication": "--- YOUR AZURE SPHERE TENANT ID---",<br />
}</span><br /><br />
Obtain your Azure Sphere Tenant ID by opening an Azure Sphere Developer Command Prompt/Terminal and typing the following command:<br />
'azsphere tenant show-selected'<br />
</p>

## Seting up Azure IoT Central
Before we get there, we first need to add an application to Azure oT Central. The 
Azure Sphere Documentation has an extensive description on how to set it up under 
[Set up Azure IoT Central to work with Azure Sphere](https://docs.microsoft.com/en-us/azure-sphere/app-development/setup-iot-central
).

Apart from creating the IoT Central application itself, the remaining steps will look fairly familiar: 
Setting up the certificate chain for DPS inside Azure IoT Central.

To setup the telemetry, commands and properties you can import a device template from the provided json here: 
[*Azure Sphere with BME280 Lab.json*](./Azure%20Sphere%20with%20BME280%20Lab.json).

To do this, in your IoT Central application, under *App settings* go to *Device Templates* -> *+New* and under 
*Create a custom device template* select "IoT Device" and press [Next:Review], give it a name and hit [Create] .

On the device template page you can now *Import capabililty model* and import the [*Azure Sphere with BME280 Lab.json*](./Azure%20Sphere%20with%20BME280%20Lab.json) .


To stretch your brain a bit, look at the source code of [*main.c*](./main.c) to see what telemetry
it implements, what events, and what properties it supports (pls. note the different
format of the Device Twin desired property). A couple hints:

Looking at [*main.c* Line 100](./main.c#L100) 
```C
static const char cstrJsonTelemetry[] = "{\"temperature\":%0.2f,\"pressure\":%0.2f,\"humidity\":%0.2f}";
static const char cstrJsonEvent[] = "{\"%s\":\"occurred\"}";
...
static const char cstrEvtConnected[] = "connect";
static const char cstrEvtButtonB[] = "buttonB";
static const char cstrEvtButtonA[] = "buttonA";
```
you can likely deduct the schema for the telemetry data looking like: 
```json
{
	"temperature" : 36.34,
	"pressure" : 1096.35,
	"humidity" : 45.25
}
```
and the three events being called `connect`, `buttonA` and `buttonB`.

To raise an event with Azure IoT Central, you need to send a device-to-cloud message with 
the event-name as property-name and provide some arbitrary value; i.e. to raise 
the `buttonA`-event the json needs to look like: 
```json
{ "buttonA" : "occurred" }
```
and to raise the `buttonB`-event, the json would be
```json
{ "buttonB" : "occurred" }
```

Azure IoT Central also supports properties, that are actually based on Device Twin Desired Properties. 
In the previous examples we've used the short json notation (e.g. `{ "LedBlinkRateProperty" : 1 }` ).  
Azure IoT Central already partially implements Azure IoT Plug&Play. The schema therefore changes to *LedBlinkRateProperty.value*:
```json
{
	"LedBlinkRateProperty" : {	
		"value" : 1
	}
}
```  
which is reflected in the json-path in [*main.c* Line 270](./main.c#L270) 
```C
/// <summary>
///     Device Twin update callback function, called when an update is received from the Azure IoT
///     Hub.
/// </summary>
/// <param name="desiredProperties">The JSON root object containing the desired Device Twin
/// properties received from the Azure IoT Hub.</param>
static void DeviceTwinUpdate(JSON_Object *desiredProperties)
{
	static const char cstrValuePath[] = "LedBlinkRateProperty.value";
	if (json_object_dothas_value_of_type(desiredProperties, cstrValuePath, JSONNumber))

```


Now it's time to get cracking:

Step 1. Create a new Azure IoT Central application

Step 2. Configure the Azure Sphere certificate chain in Azure IoT Central

Step 3. Configure your Azure IoT Central App for Telemetry, Events and Properties

Step 4. Run the  [`ShowIoTCentralConfig.exe`](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/AzureIoT/Tools) 
and copy&paste the settings into your *app_manifest.json*

Step 5. Run the application and see telemetry visualized in the dashboard.

---
[Back to root](../README.MD#connecting-an-i2c-sensor-bosch-bme280-and-send-telemetry-to-azure-iot-central)

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
