SET(CMAKE_SYSTEM_NAME Generic)

# Get sdk and cmake dir from environment set from toolchain location
IF(DEFINED CMAKE_TOOLCHAIN_FILE)
    STRING(REPLACE "\\" "/" CMAKE_TOOLCHAIN_FILE ${CMAKE_TOOLCHAIN_FILE})
    STRING(FIND ${CMAKE_TOOLCHAIN_FILE} "/" AZURE_SPHERE_CMAKE_PATH_END REVERSE)
    STRING(SUBSTRING ${CMAKE_TOOLCHAIN_FILE} 0 ${AZURE_SPHERE_CMAKE_PATH_END} AZURE_SPHERE_CMAKE_PATH)
# JSchwert: disabling the 2nd directory traversal as an environment variable contains the SDK path
# JSchwert: this also enables to decouple the toolchain cmakes to adapt them 
#    STRING(FIND ${AZURE_SPHERE_CMAKE_PATH} "/" AZURE_SPHERE_SDK_PATH_END REVERSE)
#    STRING(SUBSTRING ${AZURE_SPHERE_CMAKE_PATH} 0 ${AZURE_SPHERE_SDK_PATH_END} AZURE_SPHERE_SDK_PATH)
    SET(ENV{AzureSphereCMakePath} ${AZURE_SPHERE_CMAKE_PATH})
# jschwert: Use default SDK directory from environment variable
#    SET(ENV{AzureSphereSDKPath} ${AZURE_SPHERE_SDK_PATH})
    SET(SDKPath $ENV{AzureSphereDefaultSDKDir})
	STRING(REPLACE "\\" "/" SDKPath ${SDKPath})
    SET(ENV{AzureSphereSDKPath} ${SDKPath})
ENDIF()
SET(AZURE_SPHERE_CMAKE_PATH $ENV{AzureSphereCMakePath})
SET(AZURE_SPHERE_SDK_PATH $ENV{AzureSphereSDKPath} CACHE INTERNAL "Path to the Azure Sphere SDK")

INCLUDE("${AZURE_SPHERE_CMAKE_PATH}/AzureSphereToolchainBase.cmake")

IF(DEFINED ARM_GNU_PATH)
    STRING(REPLACE "\\" "/" ARM_GNU_PATH ${ARM_GNU_PATH})
    STRING(REGEX REPLACE "/$" "" ARM_GNU_PATH ${ARM_GNU_PATH})
    STRING(REGEX MATCH "bin$" ARM_GNU_PATH_IS_BIN ${ARM_GNU_PATH})
    IF("${ARM_GNU_PATH_IS_BIN}" STREQUAL "")
        SET(ENV{ArmGnuBasePath} ${ARM_GNU_PATH})
        SET(ENV{ArmGnuBinPath} "${ARM_GNU_PATH}/bin")
    ELSE()
        STRING(FIND ${ARM_GNU_PATH} "/" ARM_GNU_PATH_END REVERSE)
        STRING(SUBSTRING ${ARM_GNU_PATH} 0 ${ARM_GNU_PATH_END} ARM_GNU_BASE_PATH)
        SET(ENV{ArmGnuBasePath} ${ARM_GNU_BASE_PATH})
        SET(ENV{ArmGnuBinPath} ${ARM_GNU_PATH})
    ENDIF()
ENDIF()
SET(ARM_GNU_BIN_PATH $ENV{ArmGnuBinPath})
SET(ARM_GNU_BASE_PATH $ENV{ArmGnuBasePath} CACHE INTERNAL "Path to the ARM embedded toolset")

SET(ENV{PATH} "${AZURE_SPHERE_SDK_PATH}/Tools;${ARM_GNU_BIN_PATH};$ENV{PATH}")
SET(CMAKE_FIND_ROOT_PATH "${ARM_GNU_BASE_PATH}")

# Set up compiler and flags
IF(${CMAKE_HOST_WIN32})
    SET(CMAKE_C_COMPILER "${ARM_GNU_BIN_PATH}/arm-none-eabi-gcc.exe" CACHE INTERNAL "Path to the C compiler in the ARM embedded toolset targeting Real-Time Core")
    SET(CMAKE_AR "${ARM_GNU_BIN_PATH}/arm-none-eabi-ar.exe" CACHE INTERNAL "Path to the AR compiler in the ARM embedded toolset targeting Real-Time Core")
ELSE()
    SET(CMAKE_C_COMPILER "${ARM_GNU_BIN_PATH}/arm-none-eabi-gcc" CACHE INTERNAL "Path to the C compiler in the ARM embedded toolset targeting Real-Time Core")
    SET(CMAKE_AR "${ARM_GNU_BIN_PATH}/arm-none-eabi-ar" CACHE INTERNAL "Path to the AR compiler in the ARM embedded toolset targeting Real-Time Core")
    SET(CMAKE_STRIP "${ARM_GNU_BIN_PATH}/arm-none-eabi-strip" CACHE INTERNAL "Path to the strip tool in the ARM embedded toolset targeting Real-Time Core")
ENDIF()

SET(CMAKE_C_FLAGS_INIT "-mcpu=cortex-m4")
#JSchwert: removed hardcoded root-directory linker.ld as I'm adding it as per project as TARGET_LINK_OPTIONS() where needed.
#SET(CMAKE_EXE_LINKER_FLAGS_INIT "-nostartfiles -Wl,--no-undefined -Wl,-n -T \"${CMAKE_SOURCE_DIR}/linker.ld\"")
SET(CMAKE_EXE_LINKER_FLAGS_INIT "-nostartfiles -Wl,--no-undefined -Wl,-n")

FILE(GLOB ARM_GNU_INCLUDE_PATH "${ARM_GNU_BASE_PATH}/lib/gcc/arm-none-eabi/*/include")
SET(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES "${ARM_GNU_INCLUDE_PATH}" "${ARM_GNU_BASE_PATH}/arm-none-eabi/include")
SET(COMPILE_DEBUG_FLAGS $<$<CONFIG:Debug>:-g2> $<$<CONFIG:Debug>:-gdwarf-2> $<$<CONFIG:Debug>:-O0>)
SET(COMPILE_RELEASE_FLAGS $<$<CONFIG:Release>:-g1> $<$<CONFIG:Release>:-O3>)
ADD_COMPILE_OPTIONS(-std=c11 -Wall ${COMPILE_DEBUG_FLAGS} ${COMPILE_RELEASE_FLAGS})
