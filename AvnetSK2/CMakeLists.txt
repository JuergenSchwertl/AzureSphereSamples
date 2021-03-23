#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
PROJECT(AVNET_StarterKit_Telemetry C)

message("Project ${PROJECT_NAME}")

azsphere_configure_tools(TOOLS_REVISION "21.02")
azsphere_configure_api(TARGET_API_SET "8")

# Add the ST Micro LSM6DSO 3D Gyro and Accelerometer sensor lib
ADD_SUBDIRECTORY(LSM6DSO)
# Add the ST MicroLPS22HH Temp/Pressure sensor lib
# ADD_SUBDIRECTORY(LPS22HH)

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c azure_iot_utilities.c epoll_timerfd_utilities.c rgbled_utility.c parson.c)
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} m azureiot applibs pthread gcc_s c LSM6DSO LPS22HH)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} m azureiot applibs pthread gcc_s c LSM6DSO)

# This application targets the AVNET Starter Kit Rev2
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DEFINITION "avnet_mt3620_sk_rev2.json")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
