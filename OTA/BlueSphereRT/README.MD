# BlueSphereRT sample: MT3620 real-time capability application - Bare Metal GPIO

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).
  
If you followed the instructions in the [master directory](../README.MD), all applications should have been built already and you can skip the build step.

**Build the BlueSphereRT application**
 
If you chose to build the IoTConnectHL and RedSphereRT apps manually, you first need to run Visual Studio 
(or Visual Studio Code respectively) to build the BlueSphere App as well.

1. Start Visual Studio.
1. From the **File** menu, select **Open > CMake...** and navigate to the *BlueSphereRT*-folder.
1. Select the file CMakeLists.txt and then click **Open**.
1. From the **CMake** menu (if present), select **Build All**. If the menu is not present, open Solution Explorer, 
right-click the CMakeLists.txt file, and select **Build**. This step automatically performs the manual packaging steps. 
The output location of the Azure Sphere application appears in the Output window.

**Manually deploy the BlueSphereRT application**

1. Open an Azure Sphere Developer Command Prompt and navigate to the *./OTA/BlueSphereRT* folder. 
1. Deploy the application using 
```sh
 azsphere dev sl deploy -p "out\ARM-Debug\BlueSphereRT.imagepackage" 
```
You will see that Led3 starts blinking in blue at a fast rate, likely at a different frequency than Led1 in red.
1. Once you press Button A both will start blinking at the same frequency as both have received the 'BLNK' message 
1. Stop the application using
```sh
 azsphere dev app stop -i 07562362-3FEC-46C8-B0AF-DB9507F32748
```
You will see that the high-level application gracefully recovers and starts sending *PING* messages to the remaining RedSphereRT app.
1. Remove the application manually using
```sh
azsphere dev sl delete -i 07562362-3FEC-46C8-B0AF-DB9507F32748
```


**Note:** The *app_manifest.json* differs between the real-time capable applications obviously 
on the *"Name"*, *"ComponentId"* properties and most notably in the used "Gpio".

```json
{
  "SchemaVersion": 1,
  "Name": "BlueSphereRT",
  "ComponentId": "07562362-3FEC-46C8-B0AF-DB9507F32748",
  "EntryPoint": "/bin/app",
  "CmdArgs": [ "BlueSphere" ],
  "Capabilities": {
    "AllowedApplicationConnections": [ "33e04e8f-a020-4af8-80d0-8064343e0616" ],
    "Gpio": [ 20 ]
  },
  "ApplicationType": "RealTimeCapable"
}
```

---
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
