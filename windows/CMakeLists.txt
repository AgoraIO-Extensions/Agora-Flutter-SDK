cmake_minimum_required(VERSION 3.15)
set(PROJECT_NAME "agora_rtc_engine")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "agora_rtc_engine_plugin")

set(IRIS_SDK_DOWNLOAD_SDK_BY_URL "https://download.agora.io/sdk/release/iris_3.7.0.3_RTC_Windows_Video_20220628_1047.zip")
set(IRIS_SDK_DOWNLOAD_NAME "iris_3.7.0.3_RTC_Windows_20220628_1047")
set(IRIS_SDK_VERSION "v3_7_0_3")

# Add this project's cmake/ directory to the module path.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(IRIS_DOWNLOAD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third_party/iris")

set(IRIS_SDK_PATH "${IRIS_DOWNLOAD_PATH}/${IRIS_SDK_DOWNLOAD_NAME}/x64")
set(IRIS_SDK_BIN_PATH "${IRIS_SDK_PATH}/Release")
set(RTC_SDK_PATH "${IRIS_DOWNLOAD_PATH}/${IRIS_SDK_DOWNLOAD_NAME}/RTC")
set(RTC_SDK_BIN_PATH "${RTC_SDK_PATH}/Agora_Native_SDK_for_Windows_FULL/libs/x86_64")

if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.plugin_dev")
    # Download and extract the SDK binary distribution (executes DownloadSDK.cmake).
    include(DownloadSDK)
    DOWNLOAD_SDK_BY_URL("${IRIS_SDK_DOWNLOAD_SDK_BY_URL}" "${IRIS_DOWNLOAD_PATH}")
endif()

add_library(${PLUGIN_NAME} SHARED
  "agora_rtc_channel_plugin.cc"
  "agora_rtc_device_manager_plugin.cc"
  "agora_rtc_engine_plugin.cc"
  "agora_texture_view_factory.cc"
  "call_api_method_call_handler.cc"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  PRIVATE
  "${IRIS_SDK_PATH}/include"
  )
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin ${IRIS_SDK_BIN_PATH}/AgoraRtcWrapper.lib)

set(BUNDLED_LIBRARIES
  "${IRIS_SDK_BIN_PATH}/AgoraRtcScreenSharing.exe"
  "${IRIS_SDK_BIN_PATH}/AgoraRtcWrapper.dll"
  "${RTC_SDK_BIN_PATH}/agora_rtc_sdk.lib"
  )

file(GLOB RTC_DLLS ${RTC_SDK_BIN_PATH}/*.dll)
foreach (RTC_DLL ${RTC_DLLS})
    message("Add bundled library: ${RTC_DLL}")
    
    list(APPEND BUNDLED_LIBRARIES ${RTC_DLL})
endforeach (RTC_DLL ${RTC_DLLS})

# List of absolute paths to libraries that should be bundled with the plugin
set(agora_rtc_engine_bundled_libraries
  ${BUNDLED_LIBRARIES}
  PARENT_SCOPE
)
