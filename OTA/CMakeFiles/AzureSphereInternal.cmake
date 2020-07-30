
# On return the cache variable AS_INT_ACTUAL_LATEST_LTS is set to the target API set
# which corresponds to latest-lts.
function(_get_actual_latest_lts)
    set(lts_api_sets ${AZURE_SPHERE_AVAILABLE_API_SETS})
    list(FILTER lts_api_sets INCLUDE REGEX "^[0-9]+$")

    set(highest_lts_api_set -1)
    foreach(api_set ${lts_api_sets})
        if(${api_set} GREATER ${highest_lts_api_set})
            set(highest_lts_api_set ${api_set})
        endif()
    endforeach()

    set(AS_INT_ACTUAL_LATEST_LTS "${highest_lts_api_set}" CACHE INTERNAL "API set corresponding to latest-lts.")
endfunction()

# On return the cache variable AS_INT_ACTUAL_LATEST_BETA is set to the target API set
# which corresponds to latest-beta.
function(_get_actual_latest_beta)
    set(beta_api_sets ${AZURE_SPHERE_AVAILABLE_API_SETS})
    list(FILTER beta_api_sets INCLUDE REGEX "^[0-9]+\\+Beta[0-9]+$")

    set(highest_beta_arv -1)
    set(highest_beta_release -1)
    foreach(api_set ${beta_api_sets})
        string(REGEX REPLACE "^([0-9]+)\\+Beta([0-9]+)$" "\\1" arv_part "${api_set}")
        string(REGEX REPLACE "^([0-9]+)\\+Beta([0-9]+)$" "\\2" release_part "${api_set}")

        if(${arv_part} GREATER ${highest_beta_arv})
            set(highest_beta_arv ${arv_part})
            set(highest_beta_release ${release_part})
        elseif((${arv_part} EQUAL ${highest_beta_arv}) AND (${release_part} GREATER ${highest_beta_release}))
            set(highest_beta_release ${release_part})
        endif()
    endforeach()

    set(AS_INT_ACTUAL_LATEST_BETA "${highest_beta_arv}+Beta${highest_beta_release}" CACHE INTERNAL "API set corresponding to latest-beta.")
endfunction()

# Takes a logical API set, which can be a specific API set, latest-lts,
# or latest-beta, and works out the actual API set to which it corresponds.
#
# Result is placed in ARAS_RESOLVED_API_SET in the parent scope.
function(_azsphere_resolve_api_set logical_api_set)
    if ("${logical_api_set}" STREQUAL "latest-lts")
        message(STATUS "Auto-selected latest LTS API set \"${AS_INT_ACTUAL_LATEST_LTS}\"")
        set(ARAS_RESOLVED_API_SET "${AS_INT_ACTUAL_LATEST_LTS}" PARENT_SCOPE)
    elseif ("${logical_api_set}" STREQUAL "latest-beta")
        message(STATUS "Auto-selected latest Beta API set \"${AS_INT_ACTUAL_LATEST_BETA}\"")
        set(ARAS_RESOLVED_API_SET "${AS_INT_ACTUAL_LATEST_BETA}" PARENT_SCOPE)
    else()
        # Neither "latest-lts" nor "latest-beta", so interpret literally.
        set(ARAS_RESOLVED_API_SET "${logical_api_set}" PARENT_SCOPE)
    endif()
endfunction()

function(_azsphere_get_selected_api_set)
    _get_actual_latest_lts()
    _get_actual_latest_beta()

    # Fallback - API set is set in environment variable.  This includes the "AzureSphere"
    # environment in Visual Studio CMakeSettings.json.
    if(DEFINED ENV{AzureSphereTargetApiSet})
        set(logical_api_set $ENV{AzureSphereTargetApiSet})
    endif()

    # 20.01 - If the user has set the AZURE_SPHERE_TARGET_API_SET variable, use that.
    if (DEFINED AZURE_SPHERE_TARGET_API_SET)
        set(logical_api_set ${AZURE_SPHERE_TARGET_API_SET})
    endif()

    # If the user has defined neither ENV{AzureSphereTargetApiSet} nor AZURE_SPHERE_TARGET_API_SET,
    # then default to latest-lts.  Record the fact that defaulted, because this is only supported with
    # SDK 20.04.  If the user does not opt into 20.04 by calling azsphere_configure_tools, the
    # generation will fail with an error when the image package is built.

    if (DEFINED logical_api_set)
        set(AS_INT_USER_API_SET "${logical_api_set}" CACHE INTERNAL "API set explicitly requested by the user.")
    else()
        set(AS_INT_IMPLICIT_LATEST_LTS "ON" CACHE INTERNAL "Whether defaulted to latest-lts because no API set was specified.")
        set(logical_api_set "latest-lts")
    endif()

    _azsphere_resolve_api_set("${logical_api_set}")
    set(AS_INT_RESOLVED_API_SET "${ARAS_RESOLVED_API_SET}" CACHE INTERNAL "API set used to build the application.")
endfunction()

set(AZURE_SPHERE_APPROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/approot${PROJECT_NAME}")

function(_azsphere_copy_manifest_into_approot)
    add_custom_command(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${AZURE_SPHERE_APPROOT_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/app_manifest.json" "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json"

        DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/app_manifest.json" "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.out")
endfunction()

function(_azsphere_copy_resource_files_into_approot)
    get_target_property(res_files ${PROJECT_NAME} AS_RESOURCE_FILES)

    foreach(res_file ${res_files})
        string(REPLACE "\\" "/" res_file_fwd_slash ${res_file})
        string(FIND ${res_file_fwd_slash} "/" res_file_last_fwd_slash REVERSE)

        if(NOT ${res_file_last_fwd_slash} EQUAL -1)
            # Get directory leading up to source resource file
            string(SUBSTRING ${res_file_fwd_slash} 0 ${res_file_last_fwd_slash} res_file_src_dir)
            add_custom_command(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/${res_file}"
                COMMAND ${CMAKE_COMMAND} -E make_directory "${AZURE_SPHERE_APPROOT_DIR}/${res_file_src_dir}"
                COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/${res_file_fwd_slash}" "${AZURE_SPHERE_APPROOT_DIR}/${res_file_fwd_slash}"
                DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${res_file_fwd_slash}")
        else()
            add_custom_command(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/${res_file}"
                COMMAND ${CMAKE_COMMAND} -E make_directory "${AZURE_SPHERE_APPROOT_DIR}"
                COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/${res_file_fwd_slash}" "${AZURE_SPHERE_APPROOT_DIR}/${res_file_fwd_slash}"
                DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${res_file_fwd_slash}")
        endif()
    endforeach()
endfunction()

function(_azsphere_copy_executable_into_approot)
    add_custom_command(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${AZURE_SPHERE_APPROOT_DIR}/bin"
        COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.out" "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        COMMAND "${CMAKE_STRIP}" --strip-unneeded "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.out")
endfunction()

function(_azsphere_target_add_image_package_common target)
    # If the API set was chosen implicitly, fail here unless SDK 20.04 was selected.
    # This is not an obvious place to perform the check, but it may be the only time that
    # CMakeLists.txt calls into the toolchain.
    if ((DEFINED AS_INT_IMPLICIT_LATEST_LTS) AND (NOT ("${AS_INT_SELECTED_TOOLS}" STREQUAL "20.04")))
        message(
            FATAL_ERROR
            "Did not supply a target API set with AZURE_SPHERE_TARGET_API_SET. "
            "Either supply a target API set, or call azsphere_configure_tools(TOOLS_REVISION \"20.04\") "
            "to select latest LTS API set by default.")
    endif()

    set(logical_latest "latest-lts" "latest-beta")
    if (("${AS_INT_USER_API_SET}" IN_LIST logical_latest) AND (NOT ("${AS_INT_SELECTED_TOOLS}" STREQUAL "20.04")))
        message(
            FATAL_ERROR
            "Cannot set the AZURE_SPHERE_TARGET_API_SET parameter to \"latest-lts\" or \"latest-beta\" "
            "when using the deprecated Azure Sphere tools revision 20.01 or earlier. Update the app's "
            "CMakeLists.txt to call azsphere_configure_tools(TOOLS_REVISION \"20.04\") and "
            "azsphere_configure_api(TARGET_API_SET <target value>). For more details, see "
            "aka.ms/AzureSphereToolsRevisions.")
    endif()

    # If user did not opt into SDK 20.04, print a non-fatal warning.
    if(NOT ("${AS_INT_SELECTED_TOOLS}" STREQUAL "20.04"))
        message(
            WARNING
            "This app uses the deprecated Azure Sphere tools revision 20.01 or earlier. "
            "To upgrade, update the app's CMakeLists.txt with "
            "azsphere_configure_tools(TOOLS_REVISION \"20.04\") and see aka.ms/AzureSphereToolsRevisions.")
    endif()

    # If the user called azsphere_configure_tools but did not call azsphere_configure_api then print
    # a fatal error message.
    if ((DEFINED AS_INT_SELECTED_TOOLS) AND (NOT (DEFINED AS_INT_CONFIGURED_API_SET)))
        message(
            FATAL_ERROR
            "The target API set was not configured. Call azsphere_configure_api(TARGET_API_SET <target value>). "
            "For more details, see aka.ms/AzureSphereToolsRevisions.")
    endif()

    set(options)
    set(oneValueArgs)
    set(multiValueArgs RESOURCE_FILES)
    cmake_parse_arguments(PARSE_ARGV 1 ATAIP "${options}" "${oneValueArgs}" "${multiValueArgs}")

    set_target_properties(${target} PROPERTIES AS_RESOURCE_FILES "${ATAIP_RESOURCE_FILES}")

    # Force executable to have .out extension for debugging to work
    # This is a requirement of Open Folder infrastructure in Visual Studio
    set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}.out")

    _azsphere_copy_manifest_into_approot()
    _azsphere_copy_resource_files_into_approot()
    _azsphere_copy_executable_into_approot()

    # Arguments for the image-package command
    set(AZURE_SPHERE_PACKAGE_COMMAND_ARG "-v")
    list(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-i;\"${AZURE_SPHERE_APPROOT_DIR}\"")
    # JSchwert: need to use CMAKE_CURRENT_BINARY_DIR instead of CMAKE_BINARY_DIR
    list(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-o;\"${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.imagepackage\"")
    list(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-s;\"${AS_INT_RESOLVED_API_SET}\"")

    # If the user has selected a hardware definition by calling azsphere_target_set_hardware_definition
    # then use the project-specific property which was set there.  Otherwise, use the command-line arguments.
    get_target_property(pkg_hwd_args ${PROJECT_NAME} AS_PKG_HWD_ARGS)
    if (NOT("${pkg_hwd_args}" STREQUAL "pkg_hwd_args-NOTFOUND"))
        list(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "${pkg_hwd_args}")
    elseif((NOT ("${AZURE_SPHERE_HW_DEFINITION}" STREQUAL "")) AND (NOT ("${AZURE_SPHERE_HW_DIRECTORY}" STREQUAL "")))
        list(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-h;\"${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION}\"")
    endif()

    # Build list of files on which the image package depends, namely the app manifest, executable,
    # and resource files.
    set(pkg_deps "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json;${AZURE_SPHERE_APPROOT_DIR}/bin/app")
    foreach(res_file ${ATAIP_RESOURCE_FILES})
        list(APPEND pkg_deps "${AZURE_SPHERE_APPROOT_DIR}/${res_file}")
    endforeach()

    # Get azsphere executable which packages the approot directory into an image package.
    if(${CMAKE_HOST_WIN32})
        set(azsphere_path "${AZURE_SPHERE_SDK_PATH}/Tools/azsphere.exe")
    else()
        set(azsphere_path "${AZURE_SPHERE_SDK_PATH}/Tools/azsphere")
    endif()

    # JSchwert: need to use CMAKE_CURRENT_BINARY_DIR instead of CMAKE_BINARY_DIR
    add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.imagepackage"
        COMMAND "${azsphere_path}" image-package pack-application "${AZURE_SPHERE_PACKAGE_COMMAND_ARG}"
        DEPENDS ${pkg_deps}
        COMMAND_EXPAND_LISTS)

    # Add MakeImage target
    # JSchwert: Adding the PROJECT_NAME to the custom target name makes it unique to avoid CMake duplicate name errors
    # JSchwert: Also added output to refer to the imagepackage location in the updated output directory
    add_custom_target(MakeImage_${PROJECT_NAME} ALL
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.imagepackage")

    add_dependencies(MakeImage_${PROJECT_NAME} ${PROJECT_NAME})
    
    message("Project ${PROJECT_NAME} output will be located in ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.imagepackage" )

endfunction()

