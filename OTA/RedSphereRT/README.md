# RedSphereRT sample: MT3620 real-time capability application - Bare Metal GPIO

This directory is part of the Multi-Core OTA sample. On information how build, run and deploy the sample OTA please refer 
to the documentation in the [master directory](../README.MD).
  
## Prerequisites

- [Seeed MT3620 Development Kit](https://aka.ms/azurespheredevkits) or other hardware that implements the [MT3620 Reference Development Board (RDB)](https://docs.microsoft.com/azure-sphere/hardware/mt3620-reference-board-design) design.

## To build and run the sample

**Prep your device**

1. Ensure that your Azure Sphere device is connected to your PC, and your PC is connected to the internet.
1. Even if you've performed this set up previously, ensure that you have Azure Sphere SDK version 19.05 or above. In an Azure Sphere Developer Command Prompt, run **azsphere show-version** to check. Download and install the [latest SDK](https://aka.ms/AzureSphereSDKDownload) as needed.
1. Right-click the Azure Sphere Developer Command Prompt shortcut and select **More > Run as administrator**.
1. At the command prompt issue the following command:

   ```
   azsphere dev prep-debug --EnableRTCoreDebugging
   ```

   This command must be run as administrator when you enable real-time core debugging because it installs USB drivers for the debugger.
1. Close the window after the command completes because administrator privilege is no longer required.  
    **Note:** As a best practice, you should always use the lowest privilege that can accomplish a task.

**Build and deploy the application**

1. Start Visual Studio.
1. From the **File** menu, select **Open > CMake...** and navigate to the folder that contains the sample.
1. Select the file CMakeLists.txt and then click **Open**.
1. From the **CMake** menu (if present), select **Build All**. If the menu is not present, open Solution Explorer, right-click the CMakeLists.txt file, and select **Build**. This step automatically performs the manual packaging steps. The output location of the Azure Sphere application appears in the Output window.
1. From the **Select Startup Item** menu, on the tool bar, select **GDB Debugger (RTCore)**.
1. Press F5 to start the application with debugging. LED1 will blink red. Press button A to change the blink rate.
