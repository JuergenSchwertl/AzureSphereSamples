#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
PROJECT(RedSphereRT C)
message("[JSchwert] Project ${PROJECT_NAME}")

#   no longer supported since 24.03
#azsphere_configure_tools(TOOLS_REVISION "23.05")
# real-time capable apps didn't need the API-set
   
ADD_SUBDIRECTORY("../Shared.All" "${CMAKE_CURRENT_BINARY_DIR}/Shared.All")
INCLUDE_DIRECTORIES("${SharedAll_SOURCE_DIR}")

ADD_SUBDIRECTORY("../Shared.RT" "${CMAKE_CURRENT_BINARY_DIR}/Shared.RT")
INCLUDE_DIRECTORIES("${SharedRT_SOURCE_DIR}")

# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c )
TARGET_LINK_LIBRARIES(${PROJECT_NAME} SharedAll SharedRT)

set_target_properties(${PROJECT_NAME} PROPERTIES LINK_DEPENDS ${CMAKE_SOURCE_DIR}/linker.ld)

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
 