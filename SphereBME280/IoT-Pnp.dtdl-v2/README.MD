## Azure IoT Plug & Play

This folder contains pointers to the 
[GitHub : Digital Twins Definition Language v2 (DTDL)](https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v2/dtdlv2.md) 
schema for IoT Central and Azure Digital Twins:

The forked working repository for the IoT PnP v2 models you can find on [GitHub : JuergenSchwertl/iot-plugandplay-models](https://github.com/JuergenSchwertl/iot-plugandplay-models) 
under the path [dtmi/azsphere/spherettt](https://github.com/JuergenSchwertl/iot-plugandplay-models/tree/main/dtmi/azsphere/spherettt)

The schema is certified and available on the public repo by now [GitHub : Azure/iot-plugandplay-models](https://github.com/Azure/iot-plugandplay-models/tree/main/dtmi/azsphere/spherettt). 


For further info on how to implement a DTDL v2 schema in your code please refer to 
[IoT Plug and Play conventions](https://docs.microsoft.com/en-us/azure/iot-develop/concepts-convention) 
that has examples on how to frame your messages/properties correctly. 

### Azure IoT Central 
> **Note:** Azure IoT Central does fully support Azure IoT Plug&Play, but it requires some special handling:

For **properties**, the writeable property (*desired property*) in Azure IoT Central needs to be aknowledged 
using a mirrored *reported property* with acknowledgement metadata.
See [Azure IoT Central: Writeable property types](https://docs.microsoft.com/en-us/azure/iot-central/core/concepts-telemetry-properties-commands#writable-property-types) 

For localizable text, Azure IoT Central requires all localizable properties to be in object notation:
```json
    "displayName" : {
        "en" : "english display name",
        "de" : "deutscher Anzeigename"
    }
``` 
