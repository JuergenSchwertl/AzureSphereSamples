# AzureSphereSamples for 20.07 Azure Sphere SDK Version

This repo contains sources and links for Azure Sphere Bootcamp labs, amongst other Azure Sphere Samples for 
connected MCUs, sensors and other peripherals.

Prerequisites:
Please make sure to have a Windows 10 laptop capable of running Visual Studio 2019 or Visual Studio Code with the Azure Sphere SDK 
already installed and a free USB port available. 
* Visual Studio 2019 Download: https://visualstudio.microsoft.com/vs/ <br>
In Visual Studio please go to *Extensions* -> *Manage Extensions* and download the **Azure Sphere** Extension for Visual Studio. 
* alternatively Visual Studio Code Download: https://code.visualstudio.com/ <br>
In Visual Studio Code, please also download the **Azure Sphere** extension (which will also download the **C/C++** and **CMake Tools** Extensions). 
Please also follow the instructions on the Extension page to configure your settings.json!
>**Note**: If you run Visual Studio 2019 and Visual Studio Code side by side, you actually don't need to install the CMake tools and Ninja seperately 
>but can refer to the VS2019 versions in settings.json alike:
>```json
>    "AzureSphere.SdkPath": "C:\\Program Files (x86)\\Microsoft Azure Sphere SDK\\",
>    "AzureSphere.ArmGnuPath": "C:\\Program Files (x86)\\Microsoft Azure Sphere SDK\\Sysroots\\6\\tools\\gcc",
>    "cmake.cmakePath": "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\Common7\\IDE\\CommonExtensions\\Microsoft\\CMake\\CMake\\bin\\cmake.exe",
>    "cmake.configureSettings": {
>        "CMAKE_MAKE_PROGRAM" : "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\Common7\\IDE\\CommonExtensions\\Microsoft\\CMake\\Ninja\\ninja.exe"
>    }
>```

* Azure Sphere SDK (for Windows): https://aka.ms/azurespheresdkdownload/Windows <br>
This download package installs the AzSphere.Exe command line tool as well as the network & FTDI drivers 

Although you may be able to follow the labs also using Visual Studio Code running on Linux, your milage may vary (i.e. I have only tested the 
lab projects on Windows).

Although the SDK package is ~150MB, during the installation it may download up to 1GB of Visual Studio 
Components, so I strongly recommend to have the SDK preinstalled.

You will also need an active Azure subscription and a user account with sufficient rights to create Azure Resources such as 
* Azure Resource Groups 
* [Azure IoT Hub](https://docs.microsoft.com/en-us/azure/iot-hub/about-iot-hub) 
* [Azure IoT Hub Device Provisioning Service](https://docs.microsoft.com/en-us/azure/iot-dps/about-iot-dps)
amongst others potentially.

To follow the code samples please clone the following GitHub repositories:
* [This AzureSphereSamples repo](https://github.com/JuergenSchwertl/AzureSphereSamples)
* The Azure Sphere Product Team [Azure Sphere Samples Repo](https://github.com/Azure/azure-sphere-samples/)

## Azure Sphere Bootcamp labs

### Lab Getting started
Please follow the steps as outlined in [Install Azure Sphere](https://docs.microsoft.com/en-us/azure-sphere/install/overview)
* [Install the Azure Sphere SDK](https://docs.microsoft.com/en-us/azure-sphere/install/install) and set up your development board
* Make sure your device runs the latest Azure Sphere OS version `` azsphere device show-os-version ``. If your OS version is <19.11 
please first "recover" your device with `` azsphere device recover ``  
* [Claim your device](https://docs.microsoft.com/en-us/azure-sphere/install/claim-device)
* [Configure networking and update the device OS](https://docs.microsoft.com/en-us/azure-sphere/install/configure-wifi)

Please follow the steps outlined in [Quickstart: Building your first high-level application](https://docs.microsoft.com/en-us/azure-sphere/install/qs-overview) 
to prepare your Azure Sphere Board for development sideloading and build your first application.

### Lab #1: Setup Azure IoT Hub and Azure IoT Hub Device Provisioning Service
Please follow the steps as outlined in [Set up an IoT Hub for Azure Sphere](https://docs.microsoft.com/en-us/azure-sphere/app-development/setup-iot-hub) 
to create and link an Azure IoT Hub and an Azure IoT Hub Device Provisioning Service as well as to configure the Certificate chain 
using the Certificate Authority (CA) provided by your Azure Sphere tenant.

### Lab #2: Azure IoT Hub connected Azure Sphere Application
**Pls note**
> Some older versions of the Azure Sphere SDK contained the "Azure IoT Hub Sample for Mt3620 RDB (Azure Sphere)" application template. Since this 
> application template is no longer available in more recent versions of the SDK I've thus included it here as a starting point.
> For this lab you'll therefore need [this repo](https://github.com/JuergenSchwertl/AzureSphereSamples) cloned.

This lab covers typical IoT scenarios: 
* device-to-could messaging
* Azure IoT Hub Device Twins to report device properties and receive desired property states
* command & control scenarios using Azure IoT Hub Direct Methods

Please follow the steps outlined in [Mt3620AzureIoTHub](./Mt3620AzureIoTHub/README.MD) to connect Azure Sphere to Azure IoT Hub.

### Lab #3: Connecting a DHT sensor and send telemetry to Azure IoT Hub
Please follow the steps as outlined in [Mt3620DirectDHT](./Mt3620DirectDHT/README.MD)
to connect the DHT sensor and send telemetry data. It also contains hints to extend the ePoll event_data_t structure to enable event 
context handling and shows some of the intricacies of running time-sensitive bit-banging protocols in a high-level (POSIX) app.

### Lab #4: Connecting an I2C sensor (Bosch BME280) and send telemetry to Azure IoT Central
In this example we will connect an I2C based sensor and send telemetry data to **Azure IoT Central**. In this example it is the 
Bosch BME280 temperature/humidity/pressure sensor. For this sensor, Bosch provides a platform independent library on the
[Bosch Sensortec GitHub](https://github.com/BoschSensortec/BME280_driver) .
This sensor offer I2C as well as SPI connectivety options and depending on your module it may or may not offer both of them. As all modules I 
have at hand offer I2C and this has some cost saving advantages over SPI (i.e. less wiring, multiple sensors on I2C bus) this examples is using I2C.

Please follow the steps as outlined in [SphereBME280](./SphereBME280/README.MD) to run this example.


### Lab #5: Connecting another MCU through UART
In this lab we'll connect a NodeMCU sending telemetry data through UART to Azure Sphere acting as a secure cloud connectivety option,
often also referred to as Guardian Device scenario.

Please follow the steps as outlined in [MCUtoMt3620ToAzure](./MCUtoMT3620toAzure/README.MD) to run this lab.

### Lab #6: Multi-Core app and OTA deployment lab
This lab is split into several parts as it covers a variety of topics in an end-to-end scenario.

It starts with the development of multi-core applications with a high-level (POSIX) connectivety app that is acompanied by 
one or more real-time capable applications that use the mailbox-based inter-core communication mechanism to exchange messages.

We'll also touch on debugging multicore applications and reveal some helpful tips to enable Visual Studio to cope with multiple applications.

In the last part we'll start creating application combinations and deploy them for over-the-air (OTA). This includes setting up the infrastructue in the 
Azure Sphere Security Service. To showcase how this can be automated, you'll find examples of PowerShell scripts, that wrap the AzSphere.exe tool
and allow to build a fully automated CI/CD pipeline.

Please follow the steps as outlined in [OTA](./OTA/README.MD) to run this lab.

### Lab #7: Bluetooth provisioning of WiFi Credentials
This lab covers WiFi provisioning as well as a command & control scenario via Bluetooth, in this example using 
the [Nordic Semiconductor nRF52 Series](https://www.nordicsemi.com/-/media/Software-and-other-downloads/Product-Briefs/nRF52-Series-SoC-product-brief.pdf?la=en&hash=03B936AFAD39A624150FC9C5C17C6A3823DFE3F8) Bluetooth SoC.
Together with a Windows or Smart Phone App it allows to provision the WiFi settings for Azure Sphere as well as showcases 
how to control actions on Azure Sphere via Bluetooth. 

To run this lab you'll need the [Nordic Semiconductor nRF52 DK Development Kit](https://www.nordicsemi.com/Software-and-tools/Development-Kits/nRF52-DK) 
available and the  Azure Sphere Product Team [Azure Sphere Samples repo](https://github.com/Azure/azure-sphere-samples/) cloned.

Please follow the steps as outlined in [WifiSetupAndDeviceControlViaBle](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/WifiSetupAndDeviceControlViaBle) 
to connect the [Nordic Semiconductor nRF52 Development Kit](https://www.nordicsemi.com/Software-and-Tools/Development-Kits/nRF52-DK)

### Lab #8: Updating an external MCU Firmware
As Lab #7 already involves the Nordic Semiconductor nRF 52 Development Kit, this lab re-uses it to showcase how to update the firmware of another Micro Controller.
This covers scenarios, where Azure Sphere is retro-fit as a Guardian Module to an existing MCU-based controller board.
 
For this lab you'll need the Azure Sphere Product Team [Azure Sphere Samples repo](https://github.com/Azure/azure-sphere-samples/) cloned
and the [Nordic Semiconductor nRF52 DK Development Kit](https://www.nordicsemi.com/Software-and-tools/Development-Kits/nRF52-DK) available .

Please follow the steps as outlined in [External MCU Update](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/ExternalMcuUpdateNrf52).


## Other samples
This concludes the labs for the Azure Sphere Train-the-Trainer Bootcamp. 

In customer workshops we're typically looking at specific customer scenarios and for commercial applications you'd obviously want to rely on 
commercial peripherals. Where in the labs I on purpose used a cheap sensor with one-wire protocol to show how to port software from other platforms
as well as the intricacies of bit-banging in a (non-realtime) POSIX app, here is a selection of examples on how to connect other peripherals:
 


### Using an OLED Display with Azure Sphere
Although a micro-controller is typically a headless device and the MT3620 misses graphics capabilities, in many cases you'd at least want to
show some kind of textual or numeric information. Typically these are small displays that come with their own driver chip and in this  
example we will connect an OLED display based on the [Solomon Systech SSD130x](http://www.solomon-systech.com/en/product/...ic/oled-driver-controller/ssd1308/) 
through I2C. One example is the [Grove - OLED Display 0.96 Inch](http://wiki.seeedstudio.com/Grove-OLED_Display_0.96inch/) 
available through SeeedStudio.

Please follow the steps as outlined in [SphereOLED](./SphereOLED/README.MD) to run this example.


# Mt3620 Development Board pinouts
Most of the IO options on Azure Sphere are multiplexed between different functions.
For reference pls. find the different functional pinouts below:

## GPIOs
[![MT3620 GPIO-Ports](./Images/MT3620_DVB_GPIO_sm.png)](./Images/MT3620_DVB_GPIO.png)

## ISU blocks
Azure Sphere has 4 so called ISU-Blocks (**I**2C, **S**PI, **U**ART) for serial communication with peripherals.

For your reference pls. find the pinouts of the I2C, SPI and UART for the Azure Sphere Development Board below:

### UART pinout
Azure Sphere allows Universal asynchronous receiver-transmitter communication either in software 
flow control using a three-wire connection (TX->RX & RX<-TX crossed, Gnd) or with hardware flow control 
additionally using RTS/CTS.

Pls. keep in mind that Azure Sphere runs on 3.3V ! 

To raise voltage levels to standard RS232 levels (+/-15V) or when connecting to a 5V based 
MCU such as the Arduino UNO you'll need level shifters, otherwise you'll eventually fry the Sphere chip.  
[![MT3620 UARTS](./Images/MT3620_DVB_UART_sm.png)](./Images/MT3620_DVB_UART.png)

### I2C pinout
[![MT3620 I2C Ports](./Images/MT3620_DVB_I2C_sm.png)](./Images/MT3620_DVB_I2C.png)
### SPI pinout
[![MT3620 SPI-Ports](./Images/MT3620_DVB_SPI_sm.png)](./Images/MT3620_DVB_SPI.png)

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
