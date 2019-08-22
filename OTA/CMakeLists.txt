#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.
#set( CMAKE_VERBOSE_MAKEFILE ON )

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(MultiCoreRT C)
message("CMake generating environment for multiple Azure Sphere RT apps...")

# Create executables
ADD_SUBDIRECTORY("Shared.All") 
ADD_SUBDIRECTORY("Shared.RT")
ADD_SUBDIRECTORY("RedSphereRT")
ADD_SUBDIRECTORY("GreenSphereRT")
ADD_SUBDIRECTORY("BlueSphereRT")
