
# The following internal cache variables are used.
#
# AS_INT_SELECTED_TOOLS      - which SDK the user opts into by calling azsphere_configure_tools.  This will be
#                              undefined if the user does not call azsphere_configure_tools.
# AS_INT_USER_API_SET        - which API set the user selected, via the AzureSphereTargetApiSet environment
#                              variable, or the AZURE_SPHERE_TARGET_API_SET command-line argument.  Does not
#                              resolve "latest-lts" or "latest-beta".  Undefined if no API set explicitly selected.
# AS_INT_RESOLVED_API_SET    - final API set.  The user can set an explicit version, e.g. "5+Beta2004",
#                              on the command line, "latest-lts", or "latest-beta", or omit the API set
#                              altogether, in which case it resolves to latest-lts.
# AS_INT_IMPLICIT_LATEST_LTS - If the user did not supply a target API set on the command line, records
#                              the fact that latest-lts was used by default.
# AS_INT_ACTUAL_LATEST_LTS   - The target API set, e.g. "5", which corresponds to latest-lts.
# AS_INT_ACTUAL_LATEST_BETA  - The target API set, e.g. "5+Beta2004", which corresponds to latest-beta.
# AS_INT_CONFIGURED_API_SET  - The user called azsphere_configure_api to configure which target API
#                              set was expected.

set(CMAKE_SYSTEM_NAME Generic)

# Get sdk and cmake dir from environment set from toolchain location
set(AZURE_SPHERE_CMAKE_PATH ${CMAKE_CURRENT_LIST_DIR})
string(FIND ${AZURE_SPHERE_CMAKE_PATH} "/" AZURE_SPHERE_SDK_PATH_END REVERSE)
string(SUBSTRING ${AZURE_SPHERE_CMAKE_PATH} 0 ${AZURE_SPHERE_SDK_PATH_END} AZURE_SPHERE_SDK_PATH)
set(ENV{AzureSphereCMakePath} ${AZURE_SPHERE_CMAKE_PATH})
set(ENV{AzureSphereSDKPath} ${AZURE_SPHERE_SDK_PATH})
set(AZURE_SPHERE_CMAKE_PATH $ENV{AzureSphereCMakePath})
set(AZURE_SPHERE_SDK_PATH $ENV{AzureSphereSDKPath} CACHE INTERNAL "Path to the Azure Sphere SDK")

include("${AZURE_SPHERE_CMAKE_PATH}/AzureSphereToolchainBase.cmake")

set(AZURE_SPHERE_API_SET_DIR "${AZURE_SPHERE_SDK_PATH}/Sysroots/${AS_INT_RESOLVED_API_SET}" CACHE INTERNAL "Path to the selected API set in the Azure Sphere SDK")
set(CMAKE_FIND_ROOT_PATH "${AZURE_SPHERE_API_SET_DIR}")

# Set up compiler and flags
if(${CMAKE_HOST_WIN32})
    set(GCC_ROOT_DIR "${AZURE_SPHERE_API_SET_DIR}/tools/gcc")
    set(CMAKE_C_COMPILER "${GCC_ROOT_DIR}/arm-poky-linux-musleabi-gcc.exe" CACHE INTERNAL "Path to the C compiler in the selected API set targeting High-Level core")
    set(CMAKE_CXX_COMPILER "${GCC_ROOT_DIR}/arm-poky-linux-musleabi-g++.exe" CACHE INTERNAL "Path to the C++ compiler in the selected API set targeting High-Level core")
    set(CMAKE_AR "${GCC_ROOT_DIR}/arm-poky-linux-musleabi-ar.exe" CACHE INTERNAL "Path to the archiver in the selected API set targeting High-Level core")

    set(ENV{PATH} "${AZURE_SPHERE_SDK_PATH}/Tools;${GCC_ROOT_DIR};$ENV{PATH}")

    # Set CPath to tell compiler the default include path, workaround for bad default include path in compiler
    set(ENV{CPATH} "${AZURE_SPHERE_API_SET_DIR}/usr/include;$ENV{CPATH}")
else()
    set(GCC_ROOT_DIR "${AZURE_SPHERE_API_SET_DIR}/tools/sysroots/x86_64-pokysdk-linux/usr/bin/arm-poky-linux-musleabi")
    set(CMAKE_C_COMPILER "${GCC_ROOT_DIR}/arm-poky-linux-musleabi-gcc" CACHE INTERNAL "Path to the C compiler in the selected API set targeting High-Level core")
    set(CMAKE_CXX_COMPILER "${GCC_ROOT_DIR}/arm-poky-linux-musleabi-g++" CACHE INTERNAL "Path to the C++ compiler in the selected API set targeting High-Level core")
    set(CMAKE_AR "${GCC_ROOT_DIR}/arm-poky-linux-musleabi-ar" CACHE INTERNAL "Path to the archiver in the selected API set targeting High-Level core")
    set(CMAKE_STRIP "${GCC_ROOT_DIR}/arm-poky-linux-musleabi-strip" CACHE INTERNAL "Path to the strip tool in the selected API set targeting High-Level core")

    set(ENV{PATH} "${AZURE_SPHERE_SDK_PATH}/Tools:${GCC_ROOT_DIR}:$ENV{PATH}")

    # Set CPath to tell compiler the default include path, workaround for bad default include path in compiler
    set(ENV{CPATH} "${AZURE_SPHERE_API_SET_DIR}/usr/include:$ENV{CPATH}")
endif()

set(CMAKE_C_FLAGS_INIT "-B \"${GCC_ROOT_DIR}\" -march=armv7ve -mthumb -mfpu=neon -mfloat-abi=hard \
-mcpu=cortex-a7 --sysroot=\"${AZURE_SPHERE_API_SET_DIR}\"")
set(CMAKE_CXX_FLAGS_INIT "-B \"${GCC_ROOT_DIR}\" -march=armv7ve -mthumb -mfpu=neon -mfloat-abi=hard \
-mcpu=cortex-a7 --sysroot=\"${AZURE_SPHERE_API_SET_DIR}\"")
set(CMAKE_EXE_LINKER_FLAGS_INIT "-nodefaultlibs -pie -Wl,--no-undefined -Wl,--gc-sections")

set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES "${AZURE_SPHERE_API_SET_DIR}/usr/include")
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES "${AZURE_SPHERE_API_SET_DIR}/usr/include")

# Append the hardware definition directory
if((NOT ("${AZURE_SPHERE_HW_DEFINITION}" STREQUAL "")) AND (IS_DIRECTORY "${AZURE_SPHERE_HW_DIRECTORY}/inc"))
    list(APPEND CMAKE_C_STANDARD_INCLUDE_DIRECTORIES "${AZURE_SPHERE_HW_DIRECTORY}/inc")
    list(APPEND CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES "${AZURE_SPHERE_HW_DIRECTORY}/inc")
endif()

add_definitions(-D_POSIX_C_SOURCE)
set(COMPILE_DEBUG_FLAGS $<$<CONFIG:Debug>:-ggdb> $<$<CONFIG:Debug>:-O0>)
set(COMPILE_RELEASE_FLAGS $<$<CONFIG:Release>:-g1> $<$<CONFIG:Release>:-Os>)
set(COMPILE_C_FLAGS $<$<COMPILE_LANGUAGE:C>:-std=c11> $<$<COMPILE_LANGUAGE:C>:-Wstrict-prototypes> $<$<COMPILE_LANGUAGE:C>:-Wno-pointer-sign>)
add_compile_options(${COMPILE_C_FLAGS} ${COMPILE_DEBUG_FLAGS} ${COMPILE_RELEASE_FLAGS} -fPIC
                    -ffunction-sections -fdata-sections -fno-strict-aliasing
                    -fno-omit-frame-pointer -fno-exceptions -Wall
                    -Wswitch -Wempty-body -Wconversion -Wreturn-type -Wparentheses
                    -Wno-format -Wuninitialized -Wunreachable-code
                    -Wunused-function -Wunused-value -Wunused-variable
                    -Werror=implicit-function-declaration -fstack-protector-strong)
