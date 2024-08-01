#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
PROJECT(AVNET_StarterKit_Telemetry C)

message("Project ${PROJECT_NAME}")

#   no longer supported since 24.03
#azsphere_configure_tools(TOOLS_REVISION "23.05")
#azsphere_configure_api(TARGET_API_SET "16")

# This application targets the AVNET Starter Kit Rev1
#SET(AVNETSK_REVISION "AVNETSK_REV1")
## This application targets the AVNET Starter Kit Rev2
SET(AVNETSK_REVISION "AVNETSK_REV2")

string(TIMESTAMP APPVERSION)

IF( ${AVNETSK_REVISION} STREQUAL "AVNETSK_REV2")
    ## This application targets the AVNET Starter Kit Rev2
    SET(TARGET_HARDWARE "avnet_mt3620_sk_rev2")
ELSE()
    # This application targets the original AVNET Starter Kit (Rev1)
    SET(TARGET_HARDWARE "avnet_mt3620_sk")
ENDIF()

# Add the ST Micro LSM6DSO 3D Gyro and Accelerometer sensor libs
# Add the ST Micro LPS22HH Temp/Pressure sensor lib (connected to LSM6DSO)
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

TARGET_COMPILE_DEFINITIONS(${PROJECT_NAME} 
    PUBLIC ${AVNETSK_REVISION} 
    PUBLIC APPVERSION="${APPVERSION}")

TARGET_LINK_LIBRARIES(${PROJECT_NAME} m azureiot applibs pthread gcc_s c sensors)

# Target hardware for the sample.
SET(TARGET_DEFINITION "${TARGET_HARDWARE}.json")
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DEFINITION "${TARGET_DEFINITION}")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME} )
