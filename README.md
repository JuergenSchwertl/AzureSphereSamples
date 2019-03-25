# AzureSphereSamples
This repo contains sources and links for Azure Sphere Bootcamp labs, amongst others 
Azure Sphere Samples for connected MCU and DHT sensor.

Prerequisites:
Please make sure to have a Windows 10 laptop capable of running Visual Studio 2017 (at least Visual Studio 
CS Community Edition v15.7, most current version is 15.9.7) with Azure Sphere SDK already installed and a free
USB port available. 
* Visual Studio 2017 Download: https://visualstudio.microsoft.com/vs/
* Azure Sphere SDK: https://aka.ms/azurespheresdkdownload

Although the SDK package is ~100MB, during the installation it may download up to 1GB of Visual Studio 
Components, so we strongly recommend to have the SDK preinstalled.

You will also need an active Azure subscription and a user account with subscription admin rights to add 
Enterprise Application entries to your Azure Active Directory and create Azure Resources such as 
* Azure Resource Groups 
* [Azure IoT Hub](https://docs.microsoft.com/en-us/azure/iot-hub/about-iot-hub) 
* [Azure IoT Hub Device Provisioning Service](https://docs.microsoft.com/en-us/azure/iot-dps/about-iot-dps)
amongst others potentially.

To follow the code samples please clone the following GitHub repositories:
* [This repo](https://github.com/JuergenSchwertl/AzureSphereSamples)
* [The Azure Sphere Samples Repo](https://github.com/Azure/azure-sphere-samples/)


## Lab Getting started
Please follow the steps as outlined in [Install Azure Sphere](https://docs.microsoft.com/en-us/azure-sphere/install/overview)
* [Install the Azure Sphere SDK](https://docs.microsoft.com/en-us/azure-sphere/install/install) and set up your development board
* [Install the 18.11 OS release](https://docs.microsoft.com/en-us/azure-sphere/install/install-1811-os)
* [Set up an account](https://docs.microsoft.com/en-us/azure-sphere/install/azure-directory-account) to authenticate with Microsoft Azure
* [Claim your device](https://docs.microsoft.com/en-us/azure-sphere/install/claim-device)
* [Configure Wi-Fi](https://docs.microsoft.com/en-us/azure-sphere/install/configure-wifi)

## Lab #1: Setup Azure IoT Hub and Azure IoT Hub Device Provisioning Service
Please follow the steps as outlined in [Set up an IoT Hub for Azure Sphere](https://docs.microsoft.com/en-us/azure-sphere/app-development/setup-iot-hub).

## Lab #2: Azure IoT Hub connected Azure Sphere Application
Please follow the steps outlined in [Quickstart: Build the Blink sample application](https://docs.microsoft.com/en-us/azure-sphere/quickstarts/qs-blink-application) 
to prepare your Azure Sphere Board for development sideloading and build your first application.

Once you've verified that your Azure Sphere board runs your first application, you're ready to go to connect Azure Sphere to Azure IoT Hub:
* Create a new Visual Studio Solution using the "Azure IoT Hub Sample for Mt3620 RDB (Azure Sphere)"
* In the "Solution Explorer" in Visual Studio, RightClick on the "References"-folder in your project and select "Add Connected Service"
* Press "Device Connectivity with Azure Sphere"
* In the "Device Connectivity with Azure Sphere"-wizard, select your Subscription, 
* Connection Type: "Device Provisioning Service" and your previously created Device provisioning service from the list
* Hit F5 to build, deploy the application to your Azure Sphere DEvice and run the application. 
The Debug window should show the application starting, authenticating against Device Provisioning Service and then connecting to Azure IoT Hub.

Check the main.c comments on interactions with Azure IoT Hub Device Twins, telemetry being send and available Azure IoT Hub Direct Methods.
You may want to install the [Azure IoT SDK Device Explorer](https://github.com/Azure/azure-iot-sdk-csharp/releases/download/2019-1-4/SetupDeviceExplorer.msi) tool.

## Lab #3: Connecting a DHT sensor and send telemetry to Azure IoT Hub
For the next lab we'll need [this repo](https://github.com/JuergenSchwertl/AzureSphereSamples) cloned.
Please follow the steps as outlined in [Mt3620DirectDHT.pdf](https://github.com/JuergenSchwertl/AzureSphereSamples/blob/master/Mt3620DirectDHT/MT3620DirectDHT.pdf)
to connect the DHT sensor and send telemetry data. It also contains hints to extend the ePoll event_data_t structure to enable event context handling.

## Lab #4: Connecting another MCU through UART
In this lab we'll connect a NodeMCU sending telemetry data through UART to Azure Sphere acting as a cloud gateway.

Please follow the steps as outlined in [MCUtoMt3620ToAzure.pdf](https://github.com/JuergenSchwertl/AzureSphereSamples/blob/master/MCUtoMT3620toAzure/MCUtoMT3620toAzure.pdf) to run this lab.

## Lab #5: Bluetooth provisioning of WiFi Credentials
For this lab you'll need the Azure Sphere Teams [Azure Sphere Samples repo](https://github.com/Azure/azure-sphere-samples/) cloned.

Please follow the steps as outlined in [BLE-based Wi-Fi setup](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/WifiConfigViaBle) 
to connect the [Nordic Semiconductor nRF52 Development Kit](https://www.nordicsemi.com/Software-and-Tools/Development-Kits/nRF52-DK)

## Lab #6: Updating an external MCU Firmware
For this lab you'll need the Azure Sphere Teams [Azure Sphere Samples repo](https://github.com/Azure/azure-sphere-samples/) cloned.

Please follow the steps as outlined in [External MCU Update](https://github.com/Azure/azure-sphere-samples/tree/master/Samples/ExternalMcuUpdateNrf52) 
which uses the same [Nordic Semiconductor nRF52 Development Kit](https://www.nordicsemi.com/Software-and-Tools/Development-Kits/nRF52-DK).


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

# Disclaimer

## Sample code – No Warranties
THE SAMPLE CODE SOFTWARE IS PROVIDED “AS IS” AND WITHOUT WARRANTY.TO THE MAXIMUM EXTENT 
PERMITTED BY LAW, MICROSOFT DISCLAIMS ANY AND ALL OTHER WARRANTIES, WHETHER EXPRESS OR 
IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OF MERCHANTABILITY, 
NON - INFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE, WHETHER ARISING BY A COURSE 
OF DEALING, USAGE OR TRADE PRACTICE OR COURSE OF PERFORMANCE.
In no event shall Microsoft, its licensors, the authors or copyright holders be liable 
for any claim, damages or other liability, whether in an action of contract, tort or 
otherwise, arising from, out of or in connection with the software or the use thereof.

This code may contain errors and/or may not operate correctly. Microsoft undertakes no 
duty to correct any errors or update the software.Your use of this code is optional and 
subject to any license provided therewith or referenced therein, if any.Microsoft does 
not provide you with any license or other rights to any Microsoft product or service 
through the code provided to you.
