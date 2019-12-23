#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT( DHTlib C)
message("Shared library: ${PROJECT_NAME}")
  
# This project builds a static library 
ADD_LIBRARY(${PROJECT_NAME} STATIC DHTlib.c )

# this project contains a public header file, so the directory needs to be added to the list of include directories of parent projects
TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
