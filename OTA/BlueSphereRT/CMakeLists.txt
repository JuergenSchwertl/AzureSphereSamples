#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.12)
PROJECT(BlueSphereRT C)
message("Project ${PROJECT_NAME}")

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} "main.c" )
INCLUDE_DIRECTORIES("${SharedAll_SOURCE_DIR}")

SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES LINK_DEPENDS "${PROJECT_SOURCE_DIR}/linker.ld")
#JSchwert TARGET_LINK_OPTIONS require CMake v3.13 (Visual Studio 2017 only has CMake 3.12)
#TARGET_LINK_OPTIONS(${PROJECT_NAME}  PRIVATE  -T "${PROJECT_SOURCE_DIR}/linker.ld" )
SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES LINK_FLAGS "${PROJECT_SOURCE_DIR}/linker.ld")
TARGET_LINK_LIBRARIES(${PROJECT_NAME} SharedAll SharedRT)


# Add MakeImage post-build command
INCLUDE("${AZURE_SPHERE_MAKE_IMAGE_FILE}")
