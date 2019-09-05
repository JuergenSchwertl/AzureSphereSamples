# Multi-Core app and OTA deployment lab
In this lab we'll look into building an end-to-end scenario with a high-level connectivity application (IoTConnectHL) 
running on the A7 core in the POSIX environment accompanied by one or two real-time capable applications 
running on the M4 cores ( (Color)SphereRT ); each of them communicating with the highlevel app via inter-core communications.

Then we'll setup the Azure Sphere Security Service to deploy different app combinations over the air and we will see how 
moving a device between SKUs and DeviceGroups affects what Feeds it will receive.

## Part 1: Multi-Core App Overview
First we take a look at the source tree and what it contains:
* **CMakeFiles**: contains a copy of the Azure Sphere CMake toolchain usually part of the SDK but with some amendments to build the rather complex setup.
* **[IoTConnectHL](./IoTConnectHL/README.MD)**: This folder contains the solution for the high-level POSIX connectivety application that connects to IoT Hub, 
communicates through inter-core communication with any of the real-time capable partner apps. Although the intercore communication
is based on the [IntercoreComms sample](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/IntercoreComms) it extends the 
protocol handler so that it automatically adjusts to i.e. manually sideloaded real-time capable apps. Pressing ButtonA increments a blink index value 
and sends it to active real-time partner applications.
* **[RedSphereRT](./RedSphereRT/README.MD)**,  **[GreenSphereRT](./GreenSphereRT/README.MD)**, **[BlueSphereRT](BlueSphereRT/README.MD)**: These directories contain the projects for three very similar real-time capable applications 
for the M4 cores. You can deploy up to two of them at the same time on the MT3620. They receive the blink index value from the high level connectivety app.
RedSphere blinks LED #1 in Red, GreenSphere blinks LED #2 in Green and BlueSphere blinks LED #3 in Blue to visually indicate each app running seperately.
* **[SharedRT](./Shared.RT/README.MD)**: This directory contains common source files for the real-time capable apps to initialize the GPIO blocks, timer IRQs and for inter-core communications.

### To build and run the multi-core sample

**Prep your device**
1. Ensure that your Azure Sphere device is connected to your PC, and your PC is connected to the internet.
1. Right-click the Azure Sphere Developer Command Prompt shortcut and select **More&gt;Run as administrator**.
1. At the administrative command prompt, prepare the connected device for RTCore-Debugging :
   ```sh
   azsphere dev prep-debug --EnableRTCoreDebugging
   ```
   This command must be run as administrator when you enable real-time capable core debugging because it installs USB drivers for the debugger.
1. Close the window after the command completes because administrator privilege is no longer required.  
    **Note:** As a best practice, you should always use the lowest privilege that can accomplish a task.
1. Open an Azure Sphere Developer Command Prompt
1. Change your directory to the OTA-sample directory and keep the window open (we'll need it for later sideloading). 
    **Tip:** To easily get the path, Right-Click the root in the Solution Explorer window and click "Copy path" and paste it into the 
    Azure Sphere command shell after a CD command.

**Build and deploy the high-level connectivety application (IoTConnectHL)**

Follow the instructions in [IoTConnectHL: High-level connectivety application (POSIX)](IoTConnectHL/README.MD) to build and deploy the first
application. Keep the Visual Studio instance open running the IoTConnectHL application under the debugger.

**Build and deploy the real-time capable application(s)**
1. Start a new Visual Studio instance. (The other Visual Studio Window should still run the debugger with the IoTConnectHL app)
1. From the **File** menu, select **Open > CMake...** and navigate to the folder that contains the sample.
1. Select the file CMakeLists.txt and then click **Open**.
1. Open Solution Explorer, right-click the *CMakeLists.txt* file, and select **Build**. This step automatically performs the manual packaging steps. 
The output locations of the real-time capable Azure Sphere applications appears in the Output window.
1. From the **Select Startup Item** menu, on the tool bar, select **RedSphereRT (GDB RTCore)**.
1. Press F5 to start the application with debugging. LED1 will blink red.

>**Note**
>To enable multiple debugging targets, I've applied some amendments to the default *lauch.vs.json* file:
>```json
>      "name": "RedSphereRT (RTCore GDB)",
>      "workingDirectory": "${workspaceRoot}\\RedSphereRT",
>      "applicationPath": "${cmake.buildRoot}\\RedSphereRT\\RedSphereRT.out",
>      "imagePath": "${cmake.buildRoot}\\RedSphereRT\\RedSphereRT.imagepackage",
>      "partnerComponents": [ "33e04e8f-a020-4af8-80d0-8064343e0616" ]
>```
>For each real-time capable application I've added a seperate *configurations* list entry with
>* **name** giving it a unique name that is going to be listed in the **Select Startup Menu**
>* **workingDirectory** points to the source directory of the individual app.
>* **applicationPath** points to the output file in the output tree derived from the *buildRoot* property defined in *CMakeSettings.json* (prefixed by *cmake.*).
>* **imagePath**: points to the imagepackage of the real-time capable application  to be deployed to the Azure Sphere device. The MakeImage post build command packages it in the same directory as above.
>* **partnerComponents**: lists the ComponentId of the high-level connectivety app ( IoTConnectHL  ). This setting is required for the debugger to not remove 
>the previously sideloaded high-level application (the one we have running in the other Visual Studio instance debugging session). 


Now change back to the Visual Studio instance running IoTConnectHL. The debug output window should show it 
connecting to Azure IoT Hub and then show output alike
```
    [InterCore] Found F4E25978-6152-447B-A2A1-64577582F327.
    [InterCore] Sending: PING
    [Azure IoT Hub client] INFO: AzureIoT_DoPeriodicTasks calls in progress...
    [InterCore]: Received 'recv' from F4E25978-6152-447B-A2A1-64577582F327
```
indicating that IoTConnectHL has found the RedSphereRT real-time capable app (it shows its ComponentId). 
IoTConnectHL then repeatedly sends a *"PING"* message downstream which is acknowledged by a *"recv"* message.

If you now press ButtonA, you should see the blink frequency changing and at the same time the output window will
show 
```
    [InterCore] Sending: BLNK
    [Azure IoT] INFO: Set reported property 'LedBlinkRateProperty' to value 1.
    [InterCore]: Received 'recv' from F4E25978-6152-447B-A2A1-64577582F327
    [Azure IoT] INFO: Device Twin reported properties update result: HTTP status code 204
```
indicating that it had sent a *"Blink"* message and at the same time updated the Azure IoT Hub device twin *'LedBlinkRateProperty'* property.

**Congratulations**, you have now successfully deployed a highlevel application together with a real-time capable application
and they are happily working together. And you are now remotely debugging two applications at the same time.

If you now change to the Visual Studio instance running the RedSphereRT app, open the RedSphereRT/main.c and place a breakpoint 
at line #149.  It should immediately hit the breakpoint. Wait for a few seconds, remove the breakpoint and hit **Continue**.
Back in the Visual Studio instance running IoTConnectHL you should see the *"PING"* messages stacking up followed by a number of
*"recv"* messages indicating that RedSphereRT has emptied the mailslots once it was continued in the debugger. 

## Manual deployment using AZSPHERE.EXE
Let's now take a look at the Azure Sphere Command Window and enter
```
azsphere dev sideload show-status
```

It should show both apps deployed and indicate debugging the high-level app
```
    33e04e8f-a020-4af8-80d0-8064343e0616: App state   : debugging
    GDB port    : 2345
    Output port : 2342
    f4e25978-6152-447b-a2a1-64577582f327: App state: running
    Command completed successfully in 00:00:02.4453023.
```
Now manually deploy another applications to get the second M4 core some work as well. 
```
azsphere dev sideload deploy -p out\ARM-Debug-2Beta1905\GreenSphereRT\GreenSphereRT.imagepackage
azsphere dev sideload show-status
```
It should show all three applications running side by side and have LED1 blinking red and LED2 blinking green
```
    33e04e8f-a020-4af8-80d0-8064343e0616: App state   : debugging
    GDB port    : 2345
    Output port : 2342
    f4e25978-6152-447b-a2a1-64577582f327: App state: running
    7e5fab32-801c-4edf-a1aa-9263652aa6bd: App state: running
    Command completed successfully in 00:00:02.6309285.
```
At the same time the debug output of IoTConnectHL will now indicate that it found GreenSphereRT 
*(ComponentID: 7E5FAB32-801C-4EDF-A1AA-9263652AA6BD)* and started sending *"PING"*
messages to both real-time capable applications:
```
    [InterCore] Found 7E5FAB32-801C-4EDF-A1AA-9263652AA6BD.
    [Azure IoT Hub client] INFO: AzureIoT_DoPeriodicTasks calls in progress...
    [InterCore]: Received 'recv' from F4E25978-6152-447B-A2A1-64577582F327
    [InterCore] Sending: PING
    [InterCore] Sending: PING
    [Azure IoT Hub client] INFO: AzureIoT_DoPeriodicTasks calls in progress...
    [InterCore]: Received 'recv' from F4E25978-6152-447B-A2A1-64577582F327
    [InterCore]: Received 'recv' from 7E5FAB32-801C-4EDF-A1AA-9263652AA6BD
```
 ## Part2: OTA deployment

Now it's time to look at how to [deploy the apps over the air (OTA)](./AS3Scripts/README.MD).


