#  Copyright (c) Microsoft Corporation. All rights reserved.
#  Licensed under the MIT License.

CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT( Mt3620AzureIoTHub C)

azsphere_configure_tools(TOOLS_REVISION "22.02")
azsphere_configure_api(TARGET_API_SET "12")
  
# Create executable
ADD_EXECUTABLE(${PROJECT_NAME} main.c parson.c rgbled_utility.c epoll_timerfd_utilities.c azure_iot_utilities.c )
TARGET_COMPILE_DEFINITIONS(${PROJECT_NAME} PRIVATE AZURE_IOT_HUB_CONFIGURED)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} applibs azureiot pthread gcc_s )

# This application targets the Seeed MT3620 Development Board so target for mt3620_rdb
# Target hardware for the sample.
set(TARGET_HARDWARE "mt3620_rdb")
set(TARGET_DEFINITION "mt3620_rdb.json")
azsphere_target_hardware_definition(${PROJECT_NAME} TARGET_DEFINITION "${TARGET_DEFINITION}")

# Add MakeImage post-build command
azsphere_target_add_image_package(${PROJECT_NAME})
 