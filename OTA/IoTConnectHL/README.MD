# IoTConnectHL: High-level connectivety application (POSIX)

 
**Build and deploy the high-level connectivety application (IoTConnectHL)**
1. In Visual Studio, in the Team Explorer Window open the cloned AzureSphereSamples repository. You should see IoTConnectHL.sln listed under the solutions 
section. Double-Click to open it and change from the Team Explorer window over to the Solution Explorer view.
1. To connect your IoT Hub again, Right-Click the Referencec folder and select "Add Connected Service" to run the pre-requisites again. The wizard prepares 
your *app_manifest.json* with your Azure IoT Hub settings alike 
```json
{
  ...
  "CmdArgs": [ "**your DPS Scope ID**" ],
  "Capabilities": {
    "AllowedConnections": [ "global.azure-devices-provisioning.net", "**your Azure IoT Hub**.azure-devices.net"],
    "DeviceAuthentication": "**your Azure Sphere Tenant id**"
  }  
}
```
Looking at *app_manifest.json* you will also have noticed the *AllowedApplicationConnections* list:
```json
    "AllowedApplicationConnections": [ "F4E25978-6152-447B-A2A1-64577582F327", "7E5FAB32-801C-4EDF-A1AA-9263652AA6BD", "07562362-3FEC-46C8-B0AF-DB9507F32748" ],
``` 
This list contains the ComponentIDs of potential real-time partner applications that IoTConnectHL is allowed to connect to.
In our sample, these are the ComponentIDs for the real-time capable RedSphereRT-, GreenSphereRT- and BlueSphereRT-applications.

1. Right-Click the "IoTConnectHL (Azure Sphere)" project in the Solution Explorer window, select "Properties" and open the "Configuration Properties->Debugging" tree.
You will see that the property "PartnerComponents" has the same list of ComponentIDs 

In this sample the main()-function already takes the DPS Scope ID from the *CmdArgs* supplied command line so no other code changes are required.
1. Press F5 to start the application with debugging.



