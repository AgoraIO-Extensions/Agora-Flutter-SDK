# The Flutter tooling requires that developers have a version of Visual Studio
# installed that includes CMake 3.14 or later. You should not increase this
# version, as doing so will cause the plugin to fail to compile for some
# customers of the plugin.
cmake_minimum_required(VERSION 3.14)

# Project-level configuration.
set(PROJECT_NAME "agora_rtc_engine")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "agora_rtc_engine_plugin")

set(IRIS_SDK_DOWNLOAD_URL "https://download.agora.io/sdk/release/iris_4.3.2-build.1_DCG_Windows_Video_20240604_0456_441.zip")
set(IRIS_SDK_DOWNLOAD_NAME "iris_4.3.2-build.1_DCG_Windows")
set(RTC_SDK_DOWNLOAD_NAME "Agora_Native_SDK_for_Windows_FULL")
set(IRIS_SDK_VERSION "v3_6_2_fix.1")

# Add this project's cmake/ directory to the module path.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

message("CMAKE_CURRENT_SOURCE_DIR: ${CMAKE_CURRENT_SOURCE_DIR}")

set(IRIS_DOWNLOAD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third_party/iris")

set(IRIS_SDK_PATH "${IRIS_DOWNLOAD_PATH}/${IRIS_SDK_DOWNLOAD_NAME}/x64")
set(IRIS_SDK_BIN_PATH "${IRIS_SDK_PATH}/Release")
set(RTC_SDK_PATH "${IRIS_DOWNLOAD_PATH}/${IRIS_SDK_DOWNLOAD_NAME}/DCG/${RTC_SDK_DOWNLOAD_NAME}/sdk")
set(RTC_SDK_BIN_PATH "${RTC_SDK_PATH}/x86_64")

message("RTC_SDK_PATH: ${RTC_SDK_PATH}")

if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.plugin_dev")
    # Download and extract the SDK binary distribution (executes DownloadSDK.cmake).
    include(DownloadSDK)
    DOWNLOAD_SDK_BY_URL("${IRIS_SDK_DOWNLOAD_URL}" "${IRIS_DOWNLOAD_PATH}")
endif()

# Any new source files that you add to the plugin should be added here.
list(APPEND PLUGIN_SOURCES
  "agora_rtc_engine_plugin.cpp"
  "texture_render.cc"
  "video_view_controller.cc"
)

# Define the plugin library target. Its name must not be changed (see comment
# on PLUGIN_NAME above).
add_library(${PLUGIN_NAME} SHARED
  ${PLUGIN_SOURCES}
)

# Apply a standard set of build settings that are configured in the
# application-level CMakeLists.txt. This can be removed for plugins that want
# full control over build settings.
apply_standard_settings(${PLUGIN_NAME})

# Symbols are hidden by default to reduce the chance of accidental conflicts
# between plugins. This should not be removed; any symbols that should be
# exported should be explicitly exported with the FLUTTER_PLUGIN_EXPORT macro.
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

# Source include directories and library dependencies. Add any plugin-specific
# dependencies here.
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  PRIVATE
  "${IRIS_DOWNLOAD_PATH}/${IRIS_SDK_DOWNLOAD_NAME}/include"
)

target_link_libraries(${PLUGIN_NAME} PRIVATE
  flutter
  flutter_wrapper_plugin
  ${IRIS_SDK_BIN_PATH}/AgoraRtcWrapper.lib)

set(BUNDLED_LIBRARIES
  "${IRIS_SDK_BIN_PATH}/AgoraRtcWrapper.dll"
  )

file(GLOB RTC_DLLS ${RTC_SDK_BIN_PATH}/*.dll)
foreach (RTC_DLL ${RTC_DLLS})
    message("Add bundled library: ${RTC_DLL}")

    list(APPEND BUNDLED_LIBRARIES ${RTC_DLL})
endforeach (RTC_DLL ${RTC_DLLS})

file(GLOB RTC_LIBS ${RTC_SDK_BIN_PATH}/*.lib)
foreach (RTC_LIB ${RTC_LIBS})
    message("Add bundled library: ${RTC_LIB}")

    list(APPEND BUNDLED_LIBRARIES ${RTC_LIB})
endforeach (RTC_LIB ${RTC_LIBS})

message("include dir: ${IRIS_DOWNLOAD_PATH}/${IRIS_SDK_DOWNLOAD_NAME}/include")
file(GLOB HEADERS ${IRIS_DOWNLOAD_PATH}/${IRIS_SDK_DOWNLOAD_NAME}/include/*.h)
foreach (HEADER ${HEADERS})
    message("Dir: ${IRIS_DOWNLOAD_PATH}/${IRIS_SDK_DOWNLOAD_NAME}/include")
    message("Header: ${HEADER}")
endforeach (HEADER ${HEADERS})

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
set(agora_rtc_engine_bundled_libraries
  ${BUNDLED_LIBRARIES}
  PARENT_SCOPE
)