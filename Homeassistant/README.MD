# AzureSphereSamples for Homeassistant

This path contains sources for Azure Sphere connecting to a local Homeassistant via MQTT.

My original [AvnetSK2 sample](../AvnetSK2/README.MD) was meant to connect to an Azure IoT Central Application and featured a full implementation of Azure IoT Hub and Azure IoT Central capabilities around Telemetry, IoT Hub Device Twins (Device and Cloud Properties), Commands and even supported Azure IoT PnP (Plug&Play) with a public DTDL schema.

Caveat is, that [Azure IoT Central is nearing it's EOL](https://techcommunity.microsoft.com/blog/iotblog/azure-iot-central-is-evolving-what-you-need-to-know/4554570) and you cannot even create new apps anymore now nor [Import my OfficeClimate IoT Central Application Template](../AvnetSK2/README.MD#Import-IoT-Central-Application-Template) to spawn a new instance of the application that I use to monitor my living places spread over two countries. Since the original AvnetSK2 Sphere Sample needs an Azure IoT Central Application as an end point to monitor environmental climate data it was time to find a new end point. The official messaging says: *"The recommended path is Azure IoT Hub with DPS and Microsoft Fabric, with Azure Device Registry where applicable."* but, in all honesty, I didn't want to use a sledgehammer to crack a nut . And last not least, I'm no longer working at MSFT so I can look aside the Azure fence :joy:. I still wated to make use of my Azure Sphere development kits and even though these are nearing their EOL somewhere in 2031 thats a bit further out.

As I'm getting more and more into the depth of home automation and smart home, my [Home Assistant](https://www.home-assistant.io/) became the obvious choice with it's built in charting capabilities. Comparing an Azure IoT Central Application and Home Assistant, there are a lot of similarities when it comes to UI capabilities and both can use MQTT as messaging protocol. 

It isn't quite as simple though as just changing a few endpoint links...

>**Note**: The Azure Sphere SDK already contains a custom Azure IoT Hub (low-level) C SDK that includes it's own MQTT stack. This low-level SDK though obviously implements the  
>specifics for an Azure IoT Hub and it's connection handling and uses the publisher-/subscriber-topics that Azure IoT Hub demands. 
>It also implements the logic around Azure IoT Hub Device Provisioning Service (DPS) for IoT Hub discovery.
>
>However, it can unfortunately not be used to connect to an arbitrary MQTT Broker directly.
>
>To connect Azure Sphere to an arbitrary MQTT Broker you need to fall back to an embedded Linux MQTT implementation, such as Mosquitto or Pahoe MQTT.

A standard MQTT Broker principally only cares about publish-/subscribe-semantics on topic-names and a middle ware layer then translates that into higher level 
concepts such as Telemetry, C2D messaging, Device Twins (Properties), Commands etc (i.e. the Azure IoT C SDK does exactly that for Azure IoT Hub terminology and concepts).
When it comes to data schema, MQTT itself out of the game, in the Azure world e.g. Azure IoT Central implements Azure IoT PnP and adds a [few personal touches](../AvnetSK2/README.MD#Reviewing-the-code).

So, everything that makes your life easier in Azure land needed to be refactored to standard MQTT and some higher level Home Assistant concepts.

### AvnetSK2
The AVNET Starter Kit comes with an assortment of sensors for temperature, humidity, pressure as well as a gyro. It also offers two mikroBUS adapters for [microE Click Boards](https://www.mikroe.com/click) and a Grove connector e.g. for [seeed Studio sensors](https://www.seeedstudio.com/catalogsearch/result?bazaar4_retailer-products%5BrefinementList%5D%5Battribute_product_type%5D%5B0%5D=Module&bazaar4_retailer-products%5BrefinementList%5D%5Bproduct_category%5D%5B0%5D=Sensor): so quite a lot of opportunities for a Maker :joy:


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
