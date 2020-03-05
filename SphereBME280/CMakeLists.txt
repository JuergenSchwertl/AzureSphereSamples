#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.8)
PROJECT(SphereBME280 C)

message("Project ${PROJECT_NAME}")

ADD_SUBDIRECTORY(BME280)

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c azure_iot_utilities.c epoll_timerfd_utilities.c rgbled_utility.c parson.c)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} m azureiot applibs pthread gcc_s c BME280)

# Add MakeImage post-build command
INCLUDE("${AZURE_SPHERE_MAKE_IMAGE_FILE}")
