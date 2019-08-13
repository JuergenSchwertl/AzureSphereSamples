# Multi-Core app and OTA deployment lab
In this lab we'll look into building an end-to-end scenario with a high-level connectivity application (IoTConnectHL) 
running on the A7 core in the POSIX environment accompanied by one or two real-time capable applications 
running on the M4 cores ( (Color)SphereRT ); each of them communicating with the highlevel app via inter-core communications.

Then we'll setup the Azure Sphere Security Service to deploy different app combinations over the air and we will see how 
moving a device between SKUs and DeviceGroups affects what Feeds it will receive.

## Multi-Core App Overview
First we take a look at the source tree andwhat it contains:
* **CMakeFiles**: contains a copy of the Azure Sphere CMake toolchain usually part of the SDK but with some amendments to build the rather complex setup.
* **IoTConnectHL**: This folder contains the solution for the high-level POSIX connectivety application that connects to IoT Hub, 
communicates through inter-core communication with any of the real-time capable partner apps. Although the intercore communication
is based on the [IntercoreComms sample](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/IntercoreComms) it extends the 
protocol handler so that it automatically adjusts to i.e. manually sideloaded rel-time capable apps. Pressing ButtonA increments a blink index value 
and sends it to active real-time partner applications.
* **RedSphereRT**,  **GreenSphereRT**, **BlueSphereRT**: These directories contain the projects for three very similar real-time capable applications 
for the M4 cores. You can deploy up to two of them at the same time on the MT3620. They receive the blink index value from the high level connectivety app.
RedSphere blinks LED #1 in Red, GreenSphere blinks LED #2 in Green and BlueSphere blinks LED #3 in Blue to visually indicate each app running seperately.
* **[SharedRT](SharedRT/README.MD)**: This directory contains common source files for the real-time capable apps to initialize the GPIO blocks, timer IRQs and for inter-core communications.

### To build and run the sample

1. Ensure that your Azure Sphere device is connected to your PC, and your PC is connected to the internet.
1. Right-click the Azure Sphere Developer Command Prompt shortcut and select **More&gt;Run as administrator**.
1. At the command prompt, issue the following command:
   ```sh
   azsphere dev prep-debug --EnableRTCoreDebugging
   ```

   This command must be run as administrator when you enable real-time capable core debugging because it installs USB drivers for the debugger.
1. Close the window after the command completes because administrator privilege is no longer required.  
    **Note:** As a best practice, you should always use the lowest privilege that can accomplish a task.
1. Open an Azure Sphere Developer Command Prompt change your directory to the OTA-sample directory 
   and keep the window open (we'll need it for later sideloading). 

#### Build and deploy the real-time capable application
1. In Visual Studio, in the Team Explorer Window open the cloned AzureSphereSamples repo. You should see IoTConnectHL.sln listed under the solutions 
section. Double click to open it and also change from teh Team Explorer window over to the Solution Explorer view.
1. To connect your IoT Hub again, Right-Click the Referencec folder and select "Add Connected Service" to run the pre-requisites again. The wizard prepares 
your app_manifest.json with your IoT Hub settings alike
```json
{
  ...
  "CmdArgs": [ "[your DPS Scope ID]" ],
  "Capabilities": {
    "AllowedConnections": [ "global.azure-devices-provisioning.net", "[your Azure IoT Hub].azure-devices.net"],
  ...
}
```
In this sample the main()-function already takes the DPS Scope ID from the supplied command line.

