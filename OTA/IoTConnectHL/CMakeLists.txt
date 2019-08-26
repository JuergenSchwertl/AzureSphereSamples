#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(IoTConnectHL C)
  
ADD_SUBDIRECTORY("../Shared.ALL" "${CMAKE_CURRENT_BINARY_DIR}/Shared.All")
# Create executable
INCLUDE_DIRECTORIES("${SharedAll_SOURCE_DIR}")
ADD_EXECUTABLE(${PROJECT_NAME} main.c parson.c epoll_timerfd_utilities.c intercore_utilities.c azure_iot_utilities.c )
TARGET_COMPILE_DEFINITIONS(${PROJECT_NAME} PRIVATE AZURE_IOT_HUB_CONFIGURED)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} applibs azureiot pthread gcc_s SharedAll)

# Add MakeImage post-build command
INCLUDE("${AZURE_SPHERE_MAKE_IMAGE_FILE}")
 