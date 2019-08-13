# Different commands on Windows
IF(${CMAKE_HOST_WIN32})
    # Force executable to have .out extension for debugging to work
    # This is a requirement of Open Folder infrastructure in Visual Studio
    SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}.out")

#JSchwert: replace source/binary directories with current (project) dir
#	STRING(REPLACE "/" "\\" CMAKE_SOURCE_DIR_WIN ${CMAKE_SOURCE_DIR})
#	STRING(REPLACE "/" "\\" CMAKE_BINARY_DIR_WIN ${CMAKE_BINARY_DIR})
    STRING(REPLACE "/" "\\" CMAKE_SOURCE_DIR_WIN ${CMAKE_CURRENT_SOURCE_DIR})
    STRING(REPLACE "/" "\\" CMAKE_BINARY_DIR_WIN ${CMAKE_CURRENT_BINARY_DIR})
    SET(AZURE_SPHERE_APPROOT_DIR ${CMAKE_BINARY_DIR_WIN}\\approot${PROJECT_NAME})

    # Commands to create image package
    ADD_CUSTOM_COMMAND(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json"
        COMMAND (if not exist "${AZURE_SPHERE_APPROOT_DIR}" (mkdir "${AZURE_SPHERE_APPROOT_DIR}"))
        COMMAND copy /Y "\"${CMAKE_SOURCE_DIR_WIN}\\app_manifest.json\"" "\"${AZURE_SPHERE_APPROOT_DIR}\\app_manifest.json\""
        DEPENDS "${CMAKE_SOURCE_DIR_WIN}\\app_manifest.json")

    ADD_CUSTOM_COMMAND(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        COMMAND (if not exist "${AZURE_SPHERE_APPROOT_DIR}" (mkdir "${AZURE_SPHERE_APPROOT_DIR}"))
        COMMAND (if not exist "${AZURE_SPHERE_APPROOT_DIR}\\bin" (mkdir "${AZURE_SPHERE_APPROOT_DIR}\\bin"))
        COMMAND copy /Y "\"${CMAKE_BINARY_DIR_WIN}\\${PROJECT_NAME}.out\"" "\"${AZURE_SPHERE_APPROOT_DIR}\\bin\\app\""
        COMMAND "${CMAKE_STRIP}" --strip-unneeded "${AZURE_SPHERE_APPROOT_DIR}\\bin\\app"
        DEPENDS "${CMAKE_BINARY_DIR_WIN}\\${PROJECT_NAME}.out")

    # Arguments for the image-package command
    SET(AZURE_SPHERE_PACKAGE_COMMAND_ARG " -v")
    STRING(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG " -i \"${AZURE_SPHERE_APPROOT_DIR}\"")
    STRING(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG " -o \"${CMAKE_BINARY_DIR_WIN}\\${PROJECT_NAME}.imagepackage\"")
    STRING(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG " -s \"${AZURE_SPHERE_SETTINGS_SYSROOT_NUM}\"")

    IF((NOT ("${AZURE_SPHERE_HW_DEFINITION}" STREQUAL "")) AND (NOT ("${AZURE_SPHERE_HW_DIRECTORY}" STREQUAL "")))
        STRING(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG " -h \"${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION}\"")
    ENDIF()

    ADD_CUSTOM_COMMAND(OUTPUT "${CMAKE_BINARY_DIR_WIN}/${PROJECT_NAME}.imagepackage"
            COMMAND "${AZURE_SPHERE_SDK_PATH}/Tools/azsphere.exe" image package-application "${AZURE_SPHERE_PACKAGE_COMMAND_ARG}"
            DEPENDS "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json" "${AZURE_SPHERE_APPROOT_DIR}/bin/app")

# JSchwert: Adding the PROJECT_NAME to the custom target name makes it unique to avoid CMake duplicate name errors
# JSchwert: Also added output to refer to the imagepackage location in the updated output directory  
#    # Add MakeImage target
#    ADD_CUSTOM_TARGET(MakeImage ALL
#        DEPENDS "${CMAKE_BINARY_DIR_WIN}/${PROJECT_NAME}.imagepackage")
#
#    ADD_DEPENDENCIES(MakeImage ${PROJECT_NAME})

    ADD_CUSTOM_TARGET(MakeImage_${PROJECT_NAME} ALL
        DEPENDS "${CMAKE_BINARY_DIR_WIN}/${PROJECT_NAME}.imagepackage")

	message("Project ${PROJECT_NAME} output will be located in ${CMAKE_BINARY_DIR_WIN}/${PROJECT_NAME}.imagepackage" )

    ADD_DEPENDENCIES(MakeImage_${PROJECT_NAME} ${PROJECT_NAME})
ELSE()
    MESSAGE(FATAL_ERROR "Building on non-Windows is not yet supported")
ENDIF()
