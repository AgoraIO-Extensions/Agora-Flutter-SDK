cmake_minimum_required(VERSION 3.15)
set(PROJECT_NAME "agora_rtc_engine")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "agora_rtc_engine_plugin")

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
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin ${CMAKE_CURRENT_SOURCE_DIR}/third_party/iris/iris-rtc.lib)

# List of absolute paths to libraries that should be bundled with the plugin
set(agora_rtc_engine_bundled_libraries
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/iris/iris-rtc.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/agora_rtc_sdk.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/av1.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/libagora_ai_denoise_extension.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/libagora_dav1d_extension.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/libagora-core.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/libagora-fdkaac.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/libagora-ffmpeg.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/libagora-mpg123.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/libagora-soundtouch.dll"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/rtc/libhwcodec.dll"
  PARENT_SCOPE
)
