#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(Shared.All C)
message("Shared sources: ${PROJECT_NAME}")

# Create executable
ADD_LIBRARY(${PROJECT_NAME} OBJECT "guid_utilities.c" "intercore_messages.c")

TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})
