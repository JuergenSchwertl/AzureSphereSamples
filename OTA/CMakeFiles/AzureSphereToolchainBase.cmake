if(NOT ${CMAKE_GENERATOR} STREQUAL "Ninja")
    message(FATAL_ERROR "Azure Sphere CMake projects must use the Ninja generator")
endif()

# Force CMake to generate paths with forward slashes to work around response file generation errors
set(CMAKE_COMPILER_IS_MINGW 1)

set(AZURE_SPHERE_MAKE_IMAGE_FILE "${AZURE_SPHERE_CMAKE_PATH}/AzureSphereMakeImage.cmake" CACHE INTERNAL "Path to the MakeImage CMake target")

include("${AZURE_SPHERE_CMAKE_PATH}/AzureSphereInternal.cmake")
include("${AZURE_SPHERE_CMAKE_PATH}/AzureSphere.cmake")

# Get available API sets
file(GLOB AZURE_SPHERE_AVAILABLE_API_SETS RELATIVE "${AZURE_SPHERE_SDK_PATH}/Sysroots" "${AZURE_SPHERE_SDK_PATH}/Sysroots/*")

if (NOT (DEFINED AS_INT_RESOLVED_API_SET))
    _azsphere_get_selected_api_set()
endif()

# Set include paths and check if given API set is valid
set(AZURE_SPHERE_API_SET_VALID 0)
foreach(AZURE_SPHERE_API_SET ${AZURE_SPHERE_AVAILABLE_API_SETS})
    set(ENV{INCLUDE} "${AZURE_SPHERE_SDK_PATH}/Sysroots/${AZURE_SPHERE_API_SET}/usr/include;$ENV{INCLUDE}")
    if("${AS_INT_RESOLVED_API_SET}" STREQUAL "${AZURE_SPHERE_API_SET}")
        set(AZURE_SPHERE_API_SET_VALID 1)
    endif()
endforeach()

if(NOT AZURE_SPHERE_API_SET_VALID)
    # Create API set list
    set(AZURE_SPHERE_API_SET_LIST "['${AZURE_SPHERE_AVAILABLE_API_SETS}']")
    string(REPLACE ";" "', '" AZURE_SPHERE_API_SET_LIST "${AZURE_SPHERE_API_SET_LIST}")

    message(
        FATAL_ERROR
        "Target API set '${AS_INT_RESOLVED_API_SET}' is not supported by this SDK. "
        "Please update your SDK at http://aka.ms/AzureSphereSDKDownload. "
        "Supported API sets are ${AZURE_SPHERE_API_SET_LIST}. For 20.04 or later projects, "
        "'latest-lts' and 'latest-beta' can also be specified.")
endif()

set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Get hardware definition directory
if(DEFINED AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY)
    if (IS_ABSOLUTE "${AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY}")
        set(ENV{AzureSphereTargetHardwareDefinitionDirectory} ${AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY})
    else()
        get_filename_component(AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY_ABS ${AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY} ABSOLUTE BASE_DIR ${CMAKE_SOURCE_DIR})
        set(ENV{AzureSphereTargetHardwareDefinitionDirectory} ${AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY_ABS})
    endif()
endif()
set(AZURE_SPHERE_HW_DIRECTORY $ENV{AzureSphereTargetHardwareDefinitionDirectory})

# Get hardware definition json
if(DEFINED AZURE_SPHERE_TARGET_HARDWARE_DEFINITION)
    set(ENV{AzureSphereTargetHardwareDefinition} ${AZURE_SPHERE_TARGET_HARDWARE_DEFINITION})
endif()
set(AZURE_SPHERE_HW_DEFINITION $ENV{AzureSphereTargetHardwareDefinition})

# Check if the hardware definition file exists at the specified path
if((NOT ("${AZURE_SPHERE_HW_DEFINITION}" STREQUAL "")) AND (NOT ("${AZURE_SPHERE_HW_DIRECTORY}" STREQUAL "")))
    set(GENERIC_HW_MESSAGE_ERROR "The target hardware is not valid. To resolve this, you'll need to update the CMake build. The necessary steps vary depending on if you are building in Visual Studio, in Visual Studio Code or via the command line. See https://aka.ms/AzureSphereHardwareDefinitions for more details. ")
    if(NOT EXISTS "${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION}")
        message(FATAL_ERROR "${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION} does not exist. ${GENERIC_HW_MESSAGE_ERROR}")
    elseif(EXISTS "${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION}" AND IS_DIRECTORY "${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION}")
        message(FATAL_ERROR "${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION} is a directory, not a .json file. ${GENERIC_HW_MESSAGE_ERROR}")
    endif()
endif()

# Disable linking during try_compile since our link options cause the generation to fail
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY CACHE INTERNAL "Disable linking for try_compile")

# Add ComponentId to app_manifest if necessary
if(EXISTS "${CMAKE_SOURCE_DIR}/app_manifest.json")
    file(READ "${CMAKE_SOURCE_DIR}/app_manifest.json" AZURE_SPHERE_APP_MANIFEST_CONTENTS)
    string(REGEX MATCH "\"ComponentId\": \"([^\"]*)\"" AZURE_SPHERE_COMPONENTID "${AZURE_SPHERE_APP_MANIFEST_CONTENTS}")
    set(AZURE_SPHERE_COMPONENTID_VALUE "${CMAKE_MATCH_1}")
    # CMake Regex doesn't support syntax for matching exact number of characters, so we get to do guid matching the fun way
    set(AZURE_SPHERE_GUID_REGEX "[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]")
    set(AZURE_SPHERE_GUID_REGEX_2 "[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]")
    set(AZURE_SPHERE_GUID_REGEX_3 "[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]")
    set(AZURE_SPHERE_GUID_REGEX_4 "[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]")
    set(AZURE_SPHERE_GUID_REGEX_5 "[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]")
    string(APPEND AZURE_SPHERE_GUID_REGEX "-" ${AZURE_SPHERE_GUID_REGEX_2} "-" ${AZURE_SPHERE_GUID_REGEX_3} "-" ${AZURE_SPHERE_GUID_REGEX_4} "-" ${AZURE_SPHERE_GUID_REGEX_5})
    string(REGEX MATCH "${AZURE_SPHERE_GUID_REGEX}" AZURE_SPHERE_COMPONENTID_GUID "${AZURE_SPHERE_COMPONENTID_VALUE}")
    if("${AZURE_SPHERE_COMPONENTID_GUID}" STREQUAL "")
        # Generate random GUID
        string(RANDOM LENGTH 8 ALPHABET "0123456789abcdef" AZURE_SPHERE_GUID)
        string(RANDOM LENGTH 4 ALPHABET "0123456789abcdef" AZURE_SPHERE_GUID_2)
        string(RANDOM LENGTH 4 ALPHABET "0123456789abcdef" AZURE_SPHERE_GUID_3)
        string(RANDOM LENGTH 4 ALPHABET "0123456789abcdef" AZURE_SPHERE_GUID_4)
        string(RANDOM LENGTH 12 ALPHABET "0123456789abcdef" AZURE_SPHERE_GUID_5)
        string(APPEND AZURE_SPHERE_GUID "-" ${AZURE_SPHERE_GUID_2} "-" ${AZURE_SPHERE_GUID_3} "-" ${AZURE_SPHERE_GUID_4} "-" ${AZURE_SPHERE_GUID_5})
        # Write GUID to ComponentId
        string(REGEX REPLACE "\"ComponentId\": \"[^\"]*\"" "\"ComponentId\": \"${AZURE_SPHERE_GUID}\"" AZURE_SPHERE_APP_MANIFEST_CONTENTS "${AZURE_SPHERE_APP_MANIFEST_CONTENTS}")
        file(WRITE "${CMAKE_SOURCE_DIR}/app_manifest.json" ${AZURE_SPHERE_APP_MANIFEST_CONTENTS})
    endif()
endif()

if (DEFINED AZURE_SPHERE_LTO)
    if(${CMAKE_HOST_WIN32})
        set(STATIC_LIBRARY_OPTIONS "--plugin liblto_plugin-0.dll")
    else()
        set(STATIC_LIBRARY_OPTIONS "--plugin liblto_plugin-0")
    endif()
    add_compile_options(-flto)
    add_link_options(-flto)
endif()