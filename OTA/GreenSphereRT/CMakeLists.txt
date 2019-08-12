#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.13)
PROJECT(GreenSphereRT C)
message("Project ${PROJECT_NAME}")

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} "main.c" )

SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES LINK_DEPENDS "${PROJECT_SOURCE_DIR}/linker.ld")
TARGET_LINK_OPTIONS(${PROJECT_NAME}  PRIVATE -T "${PROJECT_SOURCE_DIR}/linker.ld" )
TARGET_LINK_LIBRARIES(${PROJECT_NAME} "Shared.RT")

# Add MakeImage post-build command
INCLUDE("${AZURE_SPHERE_MAKE_IMAGE_FILE}")
