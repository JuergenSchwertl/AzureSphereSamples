#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(IoTConnectHL C)

azsphere_configure_tools(TOOLS_REVISION "20.10")
azsphere_configure_api(TARGET_API_SET "7")

ADD_SUBDIRECTORY("../Shared.ALL" "${CMAKE_CURRENT_BINARY_DIR}/Shared.All")

# Create executable
INCLUDE_DIRECTORIES("${SharedAll_SOURCE_DIR}")
ADD_EXECUTABLE(${PROJECT_NAME} main.c parson.c epoll_timerfd_utilities.c intercore_utilities.c azure_iot_utilities.c )

TARGET_LINK_LIBRARIES(${PROJECT_NAME} applibs azureiot pthread gcc_s SharedAll)

# This app uses MT3620_RDB_BUTTON_A so target for mt3620_rdb
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DIRECTORY "../../Hardware/mt3620_rdb" TARGET_DEFINITION "mt3620_rdb.json")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
 