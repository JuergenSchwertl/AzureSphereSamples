# RedSphereRT sample: MT3620 real-time capability application - Bare Metal

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).
  
## Prerequisites

- [Seeed MT3620 Development Kit](https://aka.ms/azurespheredevkits) or other hardware that implements the [MT3620 Reference Development Board (RDB)](https://docs.microsoft.com/azure-sphere/hardware/mt3620-reference-board-design) design.

## To build and run the sample

**Prep your device**

1. Ensure that your Azure Sphere device is connected to your PC, and your PC is connected to the internet.
1. Even if you've performed this set up previously, ensure that you have Azure Sphere SDK version 20.07 or above. In an Azure Sphere Developer Command Prompt, run **azsphere show-version** to check. Download and install the [latest SDK](https://aka.ms/AzureSphereSDKDownload) as needed.
1. Right-click the Azure Sphere Developer Command Prompt shortcut and select **More > Run as administrator**.
1. At the command prompt issue the following command:

   ```
   azsphere device enable-development --EnableRTCoreDebugging
   ```
    or in short
   ```
   azsphere dev edv -r
   ```

   This command must be run as administrator when you enable real-time core debugging because it installs USB drivers for the debugger.
1. Close the window after the command completes because administrator privilege is no longer required.  
    **Note:** As a best practice, you should always use the lowest privilege that can accomplish a task.

**Build and deploy the application**

1. Start Visual Studio.
1. From the **File** menu, select **Open > CMake...** and navigate to the *RedSphereRT*-folder.
1. Select the file CMakeLists.txt and then click **Open**.
1. From the **CMake** menu (if present), select **Build All**. If the menu is not present, open Solution Explorer, 
right-click the CMakeLists.txt file, and select **Build**. This step automatically performs the manual packaging steps. 
The output location of the Azure Sphere application appears in the Output window.
1. From the **Select Startup Item** menu, on the tool bar, select **RedSphereRT (RTCore GDB)**.
1. Press F5 to start the application with debugging. LED1 will blink red. Press button A to change the blink rate.

**Note:** The *app_manifest.json* differs between the real-time capable applications obviously 
on the *"Name"*, *"ComponentId"* properties and most notably in the used "Gpio".

```json
{
  "SchemaVersion": 1,
  "Name": "RedSphereRT",
  "ComponentId": "F4E25978-6152-447B-A2A1-64577582F327",
  "EntryPoint": "/bin/app",
  "CmdArgs": [ "RedSphere" ],
  "Capabilities": {
    "AllowedApplicationConnections": [ "33e04e8f-a020-4af8-80d0-8064343e0616" ],
    "Gpio": [ 8 ]
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
