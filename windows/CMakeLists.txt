cmake_minimum_required(VERSION 3.15)
set(PROJECT_NAME "agora_rtc_engine")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "agora_rtc_engine_plugin")

# Add this project's cmake/ directory to the module path.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(IRIS_SDK_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third_party/iris")
set(RTC_SDK_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc")
set(RTC_DLL_PATH "${RTC_SDK_PATH}/Agora_Native_SDK_for_Windows_FULL/libs/x86_64")

# Download and extract the SDK binary distribution (executes DownloadSDK.cmake).
include(DownloadSDK)
DownloadSDK("Windows" "v3_3_2" "${RTC_SDK_PATH}")

add_library(${PLUGIN_NAME} SHARED
  "agora_rtc_channel_plugin.cc"
  "agora_rtc_engine_plugin.cc"
  "agora_texture_view_factory.cc"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin ${IRIS_SDK_PATH}/AgoraRtcWrapper.lib)

# List of absolute paths to libraries that should be bundled with the plugin
set(agora_rtc_engine_bundled_libraries
  "${IRIS_SDK_PATH}/AgoraRtcWrapper.dll"
  "${RTC_DLL_PATH}/agora_rtc_sdk.dll"
  "${RTC_DLL_PATH}/av1.dll"
  "${RTC_DLL_PATH}/libagora_ai_denoise_extension.dll"
  "${RTC_DLL_PATH}/libagora_dav1d_extension.dll"
  "${RTC_DLL_PATH}/libagora-core.dll"
  "${RTC_DLL_PATH}/libagora-fdkaac.dll"
  "${RTC_DLL_PATH}/libagora-ffmpeg.dll"
  "${RTC_DLL_PATH}/libagora-mpg123.dll"
  "${RTC_DLL_PATH}/libagora-soundtouch.dll"
  "${RTC_DLL_PATH}/libhwcodec.dll"
  PARENT_SCOPE
)
