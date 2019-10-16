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

SET(AZURE_SPHERE_API_SET_DIR "${AZURE_SPHERE_SDK_PATH}/Sysroots/${AZURE_SPHERE_TARGET_API_SET}" CACHE INTERNAL "Path to the selected API set in the Azure Sphere SDK")
SET(ENV{PATH} "${AZURE_SPHERE_SDK_PATH}/Tools;${AZURE_SPHERE_API_SET_DIR}/tools/gcc;$ENV{PATH}")
SET(CMAKE_FIND_ROOT_PATH "${AZURE_SPHERE_API_SET_DIR}")

# Set up compiler and flags
IF(${CMAKE_HOST_WIN32})
    SET(CMAKE_C_COMPILER "${AZURE_SPHERE_API_SET_DIR}/tools/gcc/arm-poky-linux-musleabi-gcc.exe" CACHE INTERNAL "Path to the C compiler in the selected API set targeting High-Level core")
ELSE()
    SET(CMAKE_C_COMPILER "${AZURE_SPHERE_API_SET_DIR}/tools/gcc/arm-poky-linux-musleabi-gcc" CACHE INTERNAL "Path to the C compiler in the selected API set targeting High-Level core")
ENDIF()

SET(CMAKE_C_FLAGS_INIT "-B \"${AZURE_SPHERE_API_SET_DIR}/tools/gcc\" -march=armv7ve -mthumb -mfpu=neon -mfloat-abi=hard \
-mcpu=cortex-a7 --sysroot=\"${AZURE_SPHERE_API_SET_DIR}\"")
SET(CMAKE_EXE_LINKER_FLAGS_INIT "-nodefaultlibs -pie -Wl,--no-undefined -Wl,--gc-sections")

SET(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES "${AZURE_SPHERE_API_SET_DIR}/usr/include")

# Append the hardware definition directory
IF((NOT ("${AZURE_SPHERE_HW_DEFINITION}" STREQUAL "")) AND (IS_DIRECTORY "${AZURE_SPHERE_HW_DIRECTORY}/inc"))
    LIST(APPEND CMAKE_C_STANDARD_INCLUDE_DIRECTORIES "${AZURE_SPHERE_HW_DIRECTORY}/inc")
ENDIF()

ADD_DEFINITIONS(-D_POSIX_C_SOURCE)
SET(COMPILE_DEBUG_FLAGS $<$<CONFIG:Debug>:-ggdb> $<$<CONFIG:Debug>:-O0>)
SET(COMPILE_RELEASE_FLAGS $<$<CONFIG:Release>:-g1> $<$<CONFIG:Release>:-Os>)
ADD_COMPILE_OPTIONS(-std=c11 ${COMPILE_DEBUG_FLAGS} ${COMPILE_RELEASE_FLAGS} -fPIC
                    -ffunction-sections -fdata-sections -fno-strict-aliasing
                    -fno-omit-frame-pointer -fno-exceptions -Wall -Wstrict-prototypes
                    -Wswitch -Wempty-body -Wconversion -Wreturn-type -Wparentheses
                    -Wno-pointer-sign -Wno-format -Wuninitialized -Wunreachable-code
                    -Wunused-function -Wunused-value -Wunused-variable
                    -Werror=implicit-function-declaration -fstack-protector-strong)
