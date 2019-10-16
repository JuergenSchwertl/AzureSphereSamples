#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(SharedRT C)
message("Shared sources: ${PROJECT_NAME}")

include_directories("${SharedAll_SOURCE_DIR}")
# Create executable
ADD_LIBRARY(${PROJECT_NAME} OBJECT "mt3620-timer.c" "mt3620-gpio.c" "mt3620-intercore.c" "mt3620-uart-poll.c"  )

TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
TARGET_LINK_LIBRARIES(${PROJECT_NAME} SharedAll )
