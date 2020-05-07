#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT( Mt3620DirectDHT C)
message("Project ${PROJECT_NAME}")

azsphere_configure_tools(TOOLS_REVISION "20.04")
azsphere_configure_api(TARGET_API_SET "5")

#Add library for DHT11 sensor
ADD_SUBDIRECTORY(DHT11)
  
# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c parson.c rgbled_utility.c epoll_timerfd_utilities.c azure_iot_utilities.c )
TARGET_LINK_LIBRARIES(${PROJECT_NAME} applibs azureiot pthread gcc_s DHT11)

# This application targets the Seeed MT3620 Development Board so target for mt3620_rdb
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DIRECTORY "../Hardware/mt3620_rdb" TARGET_DEFINITION "mt3620_rdb.json")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
