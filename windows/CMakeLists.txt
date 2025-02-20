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

include(cmake/DownloadSDK.cmake)

message("IRIS_INCLUDE_DIR: ${IRIS_INCLUDE_DIR}")
message("IRIS_LIB_DIR: ${IRIS_LIB_DIR}")
message("NATIVE_INCLUDE_DIR: ${NATIVE_INCLUDE_DIR}")
message("NATIVE_LIB_DIR: ${NATIVE_LIB_DIR}")

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
  "${IRIS_INCLUDE_DIR}"
  "${NATIVE_INCLUDE_DIR}"
)

target_link_libraries(${PLUGIN_NAME} PRIVATE
  flutter
  flutter_wrapper_plugin
  ${IRIS_LIB_DIR}/AgoraRtcWrapper.lib)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4819")

set(BUNDLED_LIBRARIES
  "${IRIS_LIB_DIR}/AgoraRtcWrapper.dll"
  )

file(GLOB NATIVE_DLLS ${NATIVE_LIB_DIR}/*.dll)
foreach (NATIVE_DLL ${NATIVE_DLLS})
    message("Add bundled library: ${NATIVE_DLL}")

    list(APPEND BUNDLED_LIBRARIES ${NATIVE_DLL})
endforeach (NATIVE_DLL ${NATIVE_DLLS})

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
set(agora_rtc_engine_bundled_libraries
  ${BUNDLED_LIBRARIES}
  PARENT_SCOPE
)