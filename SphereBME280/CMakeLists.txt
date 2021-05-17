#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
PROJECT(SphereBME280 C)

# set the used sensor type (uncomment the line as appropriate)
#SET(SENSOR_TYPE BME280)
SET(SENSOR_TYPE BMP280)

message("Project ${PROJECT_NAME} with sensor ${SENSOR_TYPE}")

azsphere_configure_tools(TOOLS_REVISION "21.04")
azsphere_configure_api(TARGET_API_SET "9")

# Add the Bosch sensor lib
Add_SUBDIRECTORY(${SENSOR_TYPE})

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c azure_iot_utilities.c epoll_timerfd_utilities.c rgbled_utility.c parson.c)

TARGET_COMPILE_DEFINITIONS(${PROJECT_NAME} PUBLIC ${SENSOR_TYPE})

TARGET_LINK_LIBRARIES(${PROJECT_NAME} m azureiot applibs pthread gcc_s c ${SENSOR_TYPE})

# This application targets the Seeed MT3620 Development Board so target for mt3620_rdb
# Target hardware for the sample.
SET(TARGET_HARDWARE "mt3620_rdb")
SET(TARGET_DEFINITION "mt3620_rdb.json")
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DEFINITION "${TARGET_DEFINITION}")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
