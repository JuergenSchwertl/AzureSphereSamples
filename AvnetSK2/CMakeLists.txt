#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
PROJECT(AVNET_StarterKit_Telemetry C)

message("Project ${PROJECT_NAME}")

azsphere_configure_tools(TOOLS_REVISION "21.10")
azsphere_configure_api(TARGET_API_SET "11")

# Add the ST Micro LSM6DSO 3D Gyro and Accelerometer sensor lib
# Add the ST MicroLPS22HH Temp/Pressure sensor lib (connected to LSM6DSO)
ADD_SUBDIRECTORY(sensors)

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} 
    epoll_timerfd_utilities.c 
    rgbled_utility.c 
    parson.c
    azure_iot_utilities.c 
    main.c 
)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} m azureiot applibs pthread gcc_s c LSM6DSO LPS22HH)
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} m azureiot applibs pthread gcc_s c LSM6DSO)

# This application targets the AVNET Starter Kit Rev2
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DEFINITION "avnet_mt3620_sk_rev2.json")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
