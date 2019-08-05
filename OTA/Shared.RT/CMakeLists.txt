#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(Shared.RT C)

# Create executable
ADD_LIBRARY(${PROJECT_NAME} OBJECT "mt3620-baremetal.h" "mt3620-timer.c" "mt3620-timer.h" "mt3620-gpio.c" "mt3620-gpio.h" "mt3620-intercore.c" "mt3620-intercore.h" "guid_utilities.c" "guid_utilities.h" )

TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})
