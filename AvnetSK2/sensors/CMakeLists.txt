#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(sensors C)
message("Shared library: ${PROJECT_NAME}")
  
# This project builds a static library 
ADD_LIBRARY(${PROJECT_NAME} STATIC 
    ./lsm6dso/lsm6dso_reg.c 
    ./lps22hh/lps22hh_reg.c  
    lsm6dso.c
    lps22hh.c
    sensors.c
    )

# this project contains a public header file, so the directory needs to be added to the list of include directories of parent projects
TARGET_INCLUDE_DIRECTORIES(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/Inc)
