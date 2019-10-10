#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT( DHTlib C)
message("Shared library: ${PROJECT_NAME}")
  
# Create library
ADD_LIBRARY(${PROJECT_NAME} STATIC DHTlib.c )

TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
