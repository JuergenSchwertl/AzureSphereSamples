#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
PROJECT(AVNET_StarterKit_Telemetry C)

message("Project ${PROJECT_NAME}")

# This application targets the AVNET Starter Kit Rev1
#SET(AVNETSK_REVISION "AVNETSK_REV1")
## This application targets the AVNET Starter Kit Rev2
SET(AVNETSK_REVISION "AVNETSK_REV2")

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
    mqtt_client.c
    rgbled_utility.c 
    get_device_id.c
    get_os_version.c
    parson.c
    strnsplit.c
    main.c)

add_library(mqttc STATIC
    MQTT-C/src/mqtt_pal.c
    MQTT-C/src/mqtt.c)
target_include_directories(mqttc PUBLIC MQTT-C/include)
set_source_files_properties(MQTT-C/src/mqtt.c PROPERTIES COMPILE_FLAGS -Wno-conversion)
set_source_files_properties(MQTT-C/src/mqtt_pal.c PROPERTIES COMPILE_FLAGS -Wno-conversion)
 
# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} ${SOURCE_FILES} )
TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PRIVATE MQTT-C/include)

TARGET_COMPILE_DEFINITIONS(${PROJECT_NAME} 
    PUBLIC ${AVNETSK_REVISION})

TARGET_LINK_LIBRARIES(${PROJECT_NAME} m applibs pthread gcc_s c sensors mqttc wolfssl tlsutils)

# Target hardware for the sample.
SET(TARGET_DEFINITION "${TARGET_HARDWARE}.json")
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DEFINITION "${TARGET_DEFINITION}")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME} )
