#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.8)
PROJECT(SphereOLED C)

message("Project ${PROJECT_NAME}")

azsphere_configure_tools(TOOLS_REVISION "21.02")
azsphere_configure_api(TARGET_API_SET "8")

# Add the OLED display driver
ADD_SUBDIRECTORY(SSD1308)

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c epoll_timerfd_utilities.c )
TARGET_LINK_LIBRARIES(${PROJECT_NAME} m applibs pthread gcc_s c SSD1308)

# This application targets the Seeed MT3620 Development Board so target for mt3620_rdb
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DIRECTORY "../Hardware/mt3620_rdb" TARGET_DEFINITION "mt3620_rdb.json")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
