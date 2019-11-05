# IoTConnectHL: High-level connectivety application (POSIX)

 
**Build and deploy the high-level connectivety application (IoTConnectHL)**

>**Note:** This high-level app sample is using the CMake toolchain, but there are slight differences in the toolchain to build a realtime capable app vs a high-level app. 
>The realtime capable app(s) are built with the master CMakeLists.txt and CMakeSettings.json in the root-directory of the OTA Multicore sample including the 
>RedSphereRT, GreenSphereRT and BlueSphereRT subdirectories and the SharedRT directory as object sources. The CMakeSettings.json in the root refers to 
>the AzureSphere**RTCore**Toolchain.cmake with the build script for realtime capable applications.  
>        For the IoTConnectHL application we need a seperate CMakeSettings.json that refers to the AzureSphereToolchain.cmake script instead.
1. In Visual Studio, in the Team Explorer Window open the CmakeLists.txt file in the IoTConnectHL directory using **File->Open...->Cmake...**.
2. To prepares your *app_manifest.json* with your Azure IoT Hub settings, a CMake project does not offer the "Connect to Service..." Wizard.
We therefore need to manually copy the settings from the Azure Portal. 
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
3. Open the [Device Provisioning Services page](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Devices%2FProvisioningServices)
select your Device Provisioning service and copy the *"ID Scope"** (if you hover over the ID Scope value, it shows a copy-icon next to it to copy the name to the clipboard). 
Paste the ID Scope value into the "CmdArgs" list as first parameter replacing the *\*\*your DPS Scope ID\*\** content of the string.
4. Go to the <a href="https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Devices%2FIotHubs" target="_blank">IoT Hubs page</a>, 
select your IoT Hub for this lab and copy the *"Hostname"* from the Overview page (if you hover over the IoT Hub Hostname value, it shows a copy-icon next to it to copy the name to the clipboard).
Paste the IoT Hub Hostname into the *"AllowedConnections"* list replacing the *\*\*your Azure IoT Hub\*\*.azure-devices.net* string content.
5. Open a Azure Sphere Command window and run the following command to show your Azure Sphere Tenant ID:
```sh
azsphere tenant show-selected
```
Copy the GUID value and paste it into the *"DeviceAuthentication"* value replacing the *\*\**your Azure Sphere Tenant id\*\** string content.

Looking at *app_manifest.json* you will also have noticed the *AllowedApplicationConnections* list:
```json
    "AllowedApplicationConnections": [ "F4E25978-6152-447B-A2A1-64577582F327", 
        "7E5FAB32-801C-4EDF-A1AA-9263652AA6BD", 
        "07562362-3FEC-46C8-B0AF-DB9507F32748" ],
``` 
This list contains the ComponentIDs of potential real-time partner applications that IoTConnectHL is allowed to connect to.
In our sample, these are the ComponentIDs for the real-time capable RedSphereRT-, GreenSphereRT- and BlueSphereRT-applications.

6. Now open the *launch.vs.json* file. It contains a *"partnerComponents"* list with the same entries. The Component IDs listed instruct the Visual Studio Debugger to 
not delete these applications when deploying the high-level app IoT Connect HL. 
```json
    "partnerComponents": [ "F4E25978-6152-447B-A2A1-64577582F327", 
        "7E5FAB32-801C-4EDF-A1AA-9263652AA6BD", 
        "07562362-3FEC-46C8-B0AF-DB9507F32748" ]
```
7. In the Visual Studio debug toolbar click *"Select Startup Item..."* and select *"GDB Debugger (HLCore)"*. Press F5 to start the application with debugging.

[Go back to "Multi-Core app and OTA deployment lab"](../README.MD)

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
