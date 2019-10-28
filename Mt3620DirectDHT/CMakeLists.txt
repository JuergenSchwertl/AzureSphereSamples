#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT( Mt3620DirectDHT C)
message("Project ${PROJECT_NAME}")

ADD_SUBDIRECTORY(DHTlib)
  
# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c parson.c rgbled_utility.c epoll_timerfd_utilities.c azure_iot_utilities.c )
TARGET_COMPILE_DEFINITIONS(${PROJECT_NAME} PRIVATE AZURE_IOT_HUB_CONFIGURED)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} applibs azureiot pthread gcc_s DHTlib)

# Add MakeImage post-build command
INCLUDE("${AZURE_SPHERE_MAKE_IMAGE_FILE}")
 