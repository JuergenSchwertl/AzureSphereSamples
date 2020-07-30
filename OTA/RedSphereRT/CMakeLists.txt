#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.12)
PROJECT(RedSphereRT C)
message("Project ${PROJECT_NAME}")

azsphere_configure_tools(TOOLS_REVISION "20.04")
azsphere_configure_api(TARGET_API_SET "5+Beta2004")


# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c )
INCLUDE_DIRECTORIES("${SharedAll_SOURCE_DIR}")

TARGET_LINK_LIBRARIES(${PROJECT_NAME} SharedAll SharedRT)

set_target_properties(${PROJECT_NAME} PROPERTIES LINK_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/linker.ld)

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
 