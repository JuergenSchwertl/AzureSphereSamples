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
You may want to install the [Azure IoT SDK Device Explorer] tool

![MT3620 GPIO-Ports and UARTS](./Images/MT3620_GPIO_UART.png)

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
