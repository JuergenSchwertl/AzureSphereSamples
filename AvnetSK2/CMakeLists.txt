#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
PROJECT(AVNET_StarterKit_Telemetry C)

message("Project ${PROJECT_NAME}")

azsphere_configure_tools(TOOLS_REVISION "21.10")
azsphere_configure_api(TARGET_API_SET "11")

## This application targets the AVNET Starter Kit Rev2
#SET(TARGET_HARDWARE "avnet_mt3620_sk_rev2")
# This application targets the AVNET Starter Kit Rev2
SET(TARGET_HARDWARE "avnet_mt3620_sk")


# Add the ST Micro LSM6DSO 3D Gyro and Accelerometer sensor lib
# Add the ST MicroLPS22HH Temp/Pressure sensor lib (connected to LSM6DSO)
ADD_SUBDIRECTORY(sensors)


set( SOURCE_FILES 
    epoll_timerfd_utilities.c 
    parson.c 
    azure_iot.c 
    azure_iot_dps.c 
    azure_iot_json.c 
    azure_iot_pnp.c 
    azure_iot_central.c
    rgbled_utility.c 
    main.c)
 
# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} ${SOURCE_FILES} )

TARGET_LINK_LIBRARIES(${PROJECT_NAME} m azureiot applibs pthread gcc_s c sensors)

# Target hardware for the sample.
SET(TARGET_DEFINITION "${TARGET_HARDWARE}.json")
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DEFINITION "${TARGET_DEFINITION}")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})