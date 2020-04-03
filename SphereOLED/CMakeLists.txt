#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.8)
PROJECT(SphereOLED C)

message("Project ${PROJECT_NAME}")

ADD_SUBDIRECTORY(SSD1308)

# this project contains a public header file, so the directory needs to be added to the list of include directories of parent projects
# TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PUBLIC ../Hardware/mt3620_rdb/inc)

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c epoll_timerfd_utilities.c )
TARGET_LINK_LIBRARIES(${PROJECT_NAME} m applibs pthread gcc_s c SSD1308)

# Add MakeImage post-build command
INCLUDE("${AZURE_SPHERE_MAKE_IMAGE_FILE}")
