# CMake functions which user can call from CMakeLists.txt

include_guard()

# Takes an SDK version such as "20.04" and asserts it is supported.
# The only supported value for TOOLS_REVISION is "20.04".  If this function is not called,
# the project is assumed to be from 20.01 or earlier.
function(azsphere_configure_tools)
    set(options)
    set(oneValueArgs TOOLS_REVISION)
    set(multiValueArgs)
    cmake_parse_arguments(ACS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if (NOT (DEFINED ACS_TOOLS_REVISION))
        message(FATAL_ERROR "azsphere_configure_tools requires TOOLS_REVISION argument")
    elseif(DEFINED ACS_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "azsphere_configure_tools received unexpected argument(s) ${ACS_UNPARSED_ARGUMENTS}")
    endif()

    if ("${ACS_TOOLS_REVISION}" STREQUAL "20.04")
        # Ensure pre-20.04 arguments are not supplied on the command line.
        if (DEFINED AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY)
            message(FATAL_ERROR
                "azsphere_configure_tools: Do not specify AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY "
                "external variable if using tools revision 20.04. "
                "Instead, call the azsphere_target_hardware_definition() function from CMakeLists.txt. "
                "See https://aka.ms/AzureSphereHardwareDefinitions.")
        endif()
        if (DEFINED AZURE_SPHERE_TARGET_HARDWARE_DEFINITION)
            message(FATAL_ERROR
                "azsphere_configure_tools: Do not specify AZURE_SPHERE_TARGET_HARDWARE_DEFINITION "
                "external variable if using tools revision 20.04. "
                "Instead, call the azsphere_target_hardware_definition() function from CMakeLists.txt. "
                "See https://aka.ms/AzureSphereHardwareDefinitions.")
        endif()
    else()
        message(FATAL_ERROR
            "azsphere_configure_tools: unsupported tools version \"${ACS_TOOLS_REVISION}\". "
            "Only \"20.04\" can be requested via azsphere_configure_tools.")
    endif()

    set(AS_INT_SELECTED_TOOLS "${ACS_TOOLS_REVISION}" CACHE INTERNAL "Tools version configured from CMakeLists.txt")
endfunction()

# The user specifies an API set by setting the AzureSphereTargetApiSet environment variable, or
# settings AZURE_SPHERE_TARGET_API_SET on the command line. With SDK 20.04, this variables can be omitted,
# in which case the latest LTS API set is selected. This function asserts the supplied API set matches the
# one which was used to build the application.
function(azsphere_configure_api)
    # This function can only be called if the caller has opted into SDK 20.04.
    if (NOT ("${AS_INT_SELECTED_TOOLS}" STREQUAL "20.04"))
        message(FATAL_ERROR "Must call azsphere_configure_tools with TOOLS_REVISION \"20.04\" before calling azsphere_configure_api")
    endif()

    set(options)
    set(oneValueArgs TARGET_API_SET)
    set(multiValueArgs)
    cmake_parse_arguments(ACA "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # Ensure all required arguments, and no unexpected arguments, were supplied.
    if(NOT (DEFINED ACA_TARGET_API_SET))
        message(FATAL_ERROR "azsphere_configure_api missing TARGET_API_SET argument")
    elseif(DEFINED ACA_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "azsphere_configure_api received unexpected argument(s) ${ACA_UNPARSED_ARGUMENTS}")
    endif()

    if(NOT ("${AS_INT_RESOLVED_API_SET}" STREQUAL "${ACA_TARGET_API_SET}"))
        # Target API set which was supplied to azsphere_configure_api.
        if ("${ACA_TARGET_API_SET}" STREQUAL "${AS_INT_ACTUAL_LATEST_LTS}")
            set(cml_latest_text "the latest ")
        elseif ("${ACA_TARGET_API_SET}" STREQUAL "${AS_INT_ACTUAL_LATEST_BETA}")
            set(cml_latest_text "the latest Beta ")
        endif()

        # Resolved target API set which was supplied on command line.
        if ("${AS_INT_RESOLVED_API_SET}" STREQUAL "${AS_INT_ACTUAL_LATEST_LTS}")
            set(cli_latest_text "the latest ")
        elseif ("${AS_INT_RESOLVED_API_SET}" STREQUAL "${AS_INT_ACTUAL_LATEST_BETA}")
            set(cli_latest_text "the latest Beta ")
        endif()

        # Values of AZURE_SPHERE_TARGET_API_SET which would result in ACA_TARGET_API_SET.
        # Use "latest" if "latest-lts" or "latest-beta", or if specific, latest version.
        if ("${ACA_TARGET_API_SET}" STREQUAL "${AS_INT_ACTUAL_LATEST_LTS}")
            set(param_sets "\"latest-lts\" or \"${AS_INT_ACTUAL_LATEST_LTS}\"")
        elseif ("${ACA_TARGET_API_SET}" STREQUAL "${AS_INT_ACTUAL_LATEST_BETA}")
            set(param_sets "\"latest-beta\" or \"${AS_INT_ACTUAL_LATEST_BETA}\"")
        else()
            set(param_sets "\"${ACA_TARGET_API_SET}\"")
        endif()

        message(FATAL_ERROR
            "This app targets ${cml_latest_text}API set '${ACA_TARGET_API_SET}', but this build targets "
            "${cli_latest_text}API set '${AS_INT_RESOLVED_API_SET}'.\n"
            "To configure the app to target API set '${AS_INT_RESOLVED_API_SET}', update CMakeLists.txt with "
            "azsphere_configure_api(TARGET_API_SET \"${AS_INT_RESOLVED_API_SET}\").\n"
            "To configure the build to target API set '${ACA_TARGET_API_SET}', set the AZURE_SPHERE_TARGET_API_SET "
            "parameter to ${param_sets} in CMakeSettings.json (if using Visual Studio), "
            ".vscode/settings.json (if using Visual Studio Code), or via "
            "-DAZURE_SPHERE_TARGET_API_SET=${param_sets} (if using command-line build).\n"
            "Please see https://aka.ms/AzureSphereAPISets")
    endif()

    set(AS_INT_CONFIGURED_API_SET "ON" CACHE INTERNAL "User called azsphere_configure_api.")
endfunction()

function(azsphere_target_hardware_definition target)
    # This function can only be called if the caller has opted into SDK 20.04, otherwise
    # the hardware definition is supplied via the AZURE_SPHERE_TARGET_HARDWARE_DEFINITION_DIRECTORY
    # and AZURE_SPHERE_TARGET_HARDWARE_DEFINITION command-line arguments.

    if (NOT ("${AS_INT_SELECTED_TOOLS}" STREQUAL "20.04"))
        message(FATAL_ERROR "Must call azsphere_configure_tools with TOOLS_REVISION \"20.04\" before calling azsphere_target_hardware_definition")
    endif()

    set(options)
    set(oneValueArgs TARGET_DIRECTORY TARGET_DEFINITION)
    set(multiValueArgs)
    cmake_parse_arguments(PARSE_ARGV 1 ATHD "${options}" "${oneValueArgs}" "${multiValueArgs}")

    # Ensure all required arguments, and no unexpected arguments, were supplied.
    if(NOT (DEFINED ATHD_TARGET_DIRECTORY))
        message(FATAL_ERROR "azsphere_target_hardware_definition missing TARGET_DIRECTORY argument")
    elseif(NOT (DEFINED ATHD_TARGET_DEFINITION))
        message(FATAL_ERROR "azsphere_target_hardware_definition missing TARGET_DEFINITION argument")
    elseif(DEFINED ATHD_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "azsphere_target_hardware_definition received unexpected argument(s) ${ATHD_UNPARSED_ARGUMENTS}")
    endif()

    if (IS_ABSOLUTE "${ATHD_TARGET_DIRECTORY}")
        set(ATHD_TARGET_DIRECTORY_ABS ${ATHD_TARGET_DIRECTORY})
    else()
        get_filename_component(ATHD_TARGET_DIRECTORY_ABS ${ATHD_TARGET_DIRECTORY} ABSOLUTE BASE_DIR ${CMAKE_SOURCE_DIR})
    endif()

    # Ensure the hardware definition directory exists and really is a directory.
    if (NOT (EXISTS "${ATHD_TARGET_DIRECTORY_ABS}"))
        message(FATAL_ERROR "azsphere_target_hardware_definition: TARGET_DIRECTORY ${ATHD_TARGET_DIRECTORY_ABS} does not exist.")
    endif()
    if (NOT (IS_DIRECTORY "${ATHD_TARGET_DIRECTORY_ABS}"))
        message(FATAL_ERROR "azsphere_target_hardware_definition: TARGET_DIRECTORY ${ATHD_TARGET_DIRECTORY_ABS} is not a directory.")
    endif()

    # Ensure the hardware definition file exists and really is a file.
    # CMake doesn't have an IS_FILE operator, so approximate by failing if it is a directory.
    set(defn_file "${ATHD_TARGET_DIRECTORY_ABS}/${ATHD_TARGET_DEFINITION}")
    if (NOT (EXISTS "${defn_file}"))
        message(FATAL_ERROR "azsphere_target_hardware_definition: TARGET_DEFINITION file ${defn_file} does not exist.")
    endif()
    if (IS_DIRECTORY "${defn_file}")
        message(FATAL_ERROR "azsphere_target_hardware_definition: TARGET_DEFINITION file ${defn_file} is a directory.")
    endif()
    string(REGEX MATCH "\.[jJ][sS][oO][nN]$" is_json "${defn_file}")
    if ("${is_json}" STREQUAL "")
        message(FATAL_ERROR "azsphere_target_hardware_definition: TARGET_DEFINITION file ${defn_file} is not a JSON file.")
    endif()

    # Let C code see definition header file
    target_include_directories(${target} SYSTEM PUBLIC "${ATHD_TARGET_DIRECTORY_ABS}/inc")

    # Supply JSON file to azsphere image-package pack-application.
    # This property is used in _azsphere_target_add_image_package_common.
    set_target_properties(${target} PROPERTIES AS_PKG_HWD_ARGS "-h;\"${ATHD_TARGET_DIRECTORY_ABS}/${ATHD_TARGET_DEFINITION}\"")
endfunction()

function(azsphere_target_add_image_package target)
    # This function can only be called if the caller has opted into SDK 20.04.
    if (NOT ("${AS_INT_SELECTED_TOOLS}" STREQUAL "20.04"))
        message(FATAL_ERROR "Must call azsphere_configure_tools with TOOLS_REVISION \"20.04\" before calling azsphere_target_add_image_package")
    endif()

    set(options)
    set(oneValueArgs)
    set(multiValueArgs RESOURCE_FILES)
    cmake_parse_arguments(PARSE_ARGV 1 ATAIP "${options}" "${oneValueArgs}" "${multiValueArgs}")

    # Ensure all required arguments, and no unexpected arguments, were supplied.
    # RESOURCE_FILES is optional
    if(DEFINED ATAIP_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "azsphere_target_add_image_package received unexpected argument(s) ${ATAIP_UNPARSED_ARGUMENTS}")
    endif()

    _azsphere_target_add_image_package_common(${target} RESOURCE_FILES ${ATAIP_RESOURCE_FILES})
endfunction()

