# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

set(LIBRARY_NAME iris_rendering_android)

set(LIBRARY_VERSION "0.1.0")

project(${LIBRARY_NAME} VERSION ${LIBRARY_VERSION})

set(SOURCES 
    "${CMAKE_CURRENT_SOURCE_DIR}/vm_util.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/iris_rtc_rendering_android.cc"
     )

add_library(${LIBRARY_NAME} SHARED
  ${SOURCES}
)

find_library(log-lib log)
find_library(android-lib android)
target_link_libraries(${LIBRARY_NAME}
        PRIVATE
        ${log-lib}
        ${android-lib}
        GLESv2
        EGL
        )

set(THIRD_PARTY_INCLUDE_DIRS
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/include/iris"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/include/agora_rtc"
  )

target_include_directories(${LIBRARY_NAME} PRIVATE
  "$<BUILD_INTERFACE:${THIRD_PARTY_INCLUDE_DIRS}>"
  "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>"
  )
