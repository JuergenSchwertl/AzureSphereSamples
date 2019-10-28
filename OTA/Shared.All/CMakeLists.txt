#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(SharedAll C)
message("Shared sources: ${PROJECT_NAME}")

# Create executable
ADD_LIBRARY(${PROJECT_NAME} STATIC guid_utilities.c intercore_messages.c)

TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
