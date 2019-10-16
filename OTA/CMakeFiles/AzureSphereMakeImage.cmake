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
        DEPENDS "${CMAKE_SOURCE_DIR_WIN}\\app_manifest.json" "${CMAKE_BINARY_DIR}\\${PROJECT_NAME}.out")

    ADD_CUSTOM_COMMAND(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        COMMAND (if not exist "${AZURE_SPHERE_APPROOT_DIR}" (mkdir "${AZURE_SPHERE_APPROOT_DIR}"))
        COMMAND (if not exist "${AZURE_SPHERE_APPROOT_DIR}\\bin" (mkdir "${AZURE_SPHERE_APPROOT_DIR}\\bin"))
        COMMAND copy /Y "\"${CMAKE_BINARY_DIR_WIN}\\${PROJECT_NAME}.out\"" "\"${AZURE_SPHERE_APPROOT_DIR}\\bin\\app\""
        COMMAND "${CMAKE_STRIP}" --strip-unneeded "${AZURE_SPHERE_APPROOT_DIR}\\bin\\app"
        DEPENDS "${CMAKE_BINARY_DIR_WIN}\\${PROJECT_NAME}.out")

    # Arguments for the image-package command
    SET(AZURE_SPHERE_PACKAGE_COMMAND_ARG "-v")
    LIST(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-i;\"${AZURE_SPHERE_APPROOT_DIR}\"")
    LIST(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-o;\"${CMAKE_BINARY_DIR_WIN}\\${PROJECT_NAME}.imagepackage\"")
    LIST(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-s;\"${AZURE_SPHERE_TARGET_API_SET}\"")

    IF((NOT ("${AZURE_SPHERE_HW_DEFINITION}" STREQUAL "")) AND (NOT ("${AZURE_SPHERE_HW_DIRECTORY}" STREQUAL "")))
        LIST(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-h;\"${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION}\"")
    ENDIF()

    ADD_CUSTOM_COMMAND(OUTPUT "${CMAKE_BINARY_DIR_WIN}/${PROJECT_NAME}.imagepackage"
        COMMAND "${AZURE_SPHERE_SDK_PATH}/Tools/azsphere.exe" image package-application "${AZURE_SPHERE_PACKAGE_COMMAND_ARG}"
        DEPENDS "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json" "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        COMMAND_EXPAND_LISTS)

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
    # Force executable to have .out extension for debugging to work
    SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}.out")

    SET(AZURE_SPHERE_APPROOT_DIR ${CMAKE_BINARY_DIR}/approot${PROJECT_NAME})

    # Commands to create image package
    ADD_CUSTOM_COMMAND(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json"
        COMMAND mkdir -p "${AZURE_SPHERE_APPROOT_DIR}"
        COMMAND cp "${CMAKE_SOURCE_DIR}/app_manifest.json" "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json"
        DEPENDS "${CMAKE_SOURCE_DIR}/app_manifest.json" "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.out")

    ADD_CUSTOM_COMMAND(OUTPUT "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        COMMAND mkdir -p "${AZURE_SPHERE_APPROOT_DIR}/bin"
        COMMAND cp "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.out" "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        COMMAND "${CMAKE_STRIP}" --strip-unneeded "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        DEPENDS "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.out")

    # Arguments for the image-package command
    SET(AZURE_SPHERE_PACKAGE_COMMAND_ARG "-v")
    LIST(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-i;${AZURE_SPHERE_APPROOT_DIR}")
    LIST(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-o;${CMAKE_BINARY_DIR}/${PROJECT_NAME}.imagepackage")
    LIST(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-s;${AZURE_SPHERE_TARGET_API_SET}")

    IF((NOT ("${AZURE_SPHERE_HW_DEFINITION}" STREQUAL "")) AND (NOT ("${AZURE_SPHERE_HW_DIRECTORY}" STREQUAL "")))
        LIST(APPEND AZURE_SPHERE_PACKAGE_COMMAND_ARG "-h;${AZURE_SPHERE_HW_DIRECTORY}/${AZURE_SPHERE_HW_DEFINITION}")
    ENDIF()

    ADD_CUSTOM_COMMAND(OUTPUT "${CMAKE_BINARY_DIR}/${PROJECT_NAME}.imagepackage"
        COMMAND "${AZURE_SPHERE_SDK_PATH}/Tools/azsphere" image package-application "${AZURE_SPHERE_PACKAGE_COMMAND_ARG}"
        DEPENDS "${AZURE_SPHERE_APPROOT_DIR}/app_manifest.json" "${AZURE_SPHERE_APPROOT_DIR}/bin/app"
        COMMAND_EXPAND_LISTS)

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
ENDIF()
