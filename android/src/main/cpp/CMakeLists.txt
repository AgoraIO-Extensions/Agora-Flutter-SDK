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

# Support Android 15 16k page size
if (${ANDROID_ABI} STREQUAL "arm64-v8a" OR ${ANDROID_ABI} STREQUAL "x86_64")
  target_link_libraries(${LIBRARY_NAME} PRIVATE "-Wl,-z,max-page-size=16384")

  # https://github.com/llvm/llvm-project/pull/66042
  # the default linker is llvm lld since ndk r22, and gnu ld is used before ndk r22
  # so we need to add extra flags for 16K when ANDROID_NDK_MAJOR less than 22 and the linker is not lld
  # coz the ld linker need to set common-page-size=16384 to align all sections to 16K page size
  if(ANDROID_NDK_MAJOR LESS 22 AND NOT CMAKE_SHARED_LINKER_FLAGS MATCHES "-fuse-ld=lld" AND NOT CMAKE_MODULE_LINKER_FLAGS MATCHES "-fuse-ld=lld" AND NOT CMAKE_EXE_LINKER_FLAGS MATCHES "-fuse-ld=lld")
      message(STATUS "ndk version is ${ANDROID_NDK_MAJOR} and use ld linker, add -Wl,-z,common-page-size=16384")
      set_target_properties(${LIBRARY_NAME} PROPERTIES
          LINK_FLAGS "-Wl,-z,common-page-size=16384"
      )
  endif()
endif()

set(THIRD_PARTY_INCLUDE_DIRS
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/include/iris"
  "${CMAKE_CURRENT_SOURCE_DIR}/third_party/include/agora_rtc"
  )

target_include_directories(${LIBRARY_NAME} PRIVATE
  "$<BUILD_INTERFACE:${THIRD_PARTY_INCLUDE_DIRS}>"
  "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>"
  )
