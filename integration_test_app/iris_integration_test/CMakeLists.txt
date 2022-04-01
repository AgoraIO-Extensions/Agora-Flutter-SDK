cmake_minimum_required(VERSION 3.10.2)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
# set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO")

project(iris_integration_test)

set(LIBRARY_NAME iris_integration_test)

file(GLOB SOURCES 
     "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h"
     "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cc"
     )

add_library(${LIBRARY_NAME} SHARED
            ${SOURCES}
            )

target_include_directories(${LIBRARY_NAME} PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/src"
    "${CMAKE_CURRENT_SOURCE_DIR}/third_party/agora/rtc/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/third_party/iris"
)

if (CMAKE_SYSTEM_NAME STREQUAL "Android") 
# if(UNIX AND NOT APPLE)
# if (PLATFORM STREQUAL "ANDROID") 
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../../android/libs/${ANDROID_ABI}")
    set(LIBS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../android/libs/${ANDROID_ABI}")
    else()
        set(LIBS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../android/libs/${ANDROID_ABI}")
    endif()

    find_library(
        log-lib 
        log
    )

    add_library(libAgoraRtcWrapper SHARED IMPORTED)
    set_target_properties(
        libAgoraRtcWrapper
        PROPERTIES IMPORTED_LOCATION
        ${LIBS_DIR}/libAgoraRtcWrapper.so
    )

    target_link_libraries(${LIBRARY_NAME}
        PRIVATE
        libAgoraRtcWrapper
        ${log-lib}
        )
elseif (CMAKE_SYSTEM_NAME STREQUAL "iOS")
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../../ios/AgoraRtcWrapper.podspec")
        set(LIBS_DIR
            "${CMAKE_CURRENT_SOURCE_DIR}/../../ios/"
            )
        else()
        # set(LIBS_DIR
        #     "<Pods path>"
        #     )

        # /Users/fenglang/codes/aw/Agora-Flutter-SDK/integration_test_app/ios/Pods/AgoraIrisRTC_iOS/AgoraRtcWrapper.framework
        set(LIBS_DIR
        "${CMAKE_CURRENT_SOURCE_DIR}/../ios/Pods/AgoraIrisRTC_iOS"
        )
    endif()

    set(FRAMEWORKS
        "-framework AgoraRtcWrapper"
        )

    set_target_properties(${LIBRARY_NAME} PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION A
        MACOSX_FRAMEWORK_IDENTIFIER io.agora.iris.it
        CXX_VISIBILITY_PRESET hidden
        LINK_FLAGS "-Wl -F ${LIBS_DIR} -rpath ${CMAKE_CURRENT_SOURCE_DIR}/../../ios/Pods/AgoraRtcEngine_macOS"
        )

    target_link_libraries(${LIBRARY_NAME}
        PUBLIC
        "${FRAMEWORKS}"
    )
elseif (CMAKE_SYSTEM_NAME STREQUAL "Darwin")

    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../../macos/AgoraRtcWrapper.podspec")
        set(LIBS_DIR
            "${CMAKE_CURRENT_SOURCE_DIR}/../../macos/"
            )
    else()
        set(LIBS_DIR
                "${CMAKE_CURRENT_SOURCE_DIR}/../macos/Pods/AgoraIrisRTC_macOS"
                )
    endif()

    set(FRAMEWORKS
        "-framework AgoraRtcWrapper"
    )

    set_target_properties(${LIBRARY_NAME} PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION A
        MACOSX_FRAMEWORK_IDENTIFIER io.agora.iris.it
        CXX_VISIBILITY_PRESET hidden
        LINK_FLAGS "-Wl -F ${LIBS_DIR} -rpath ${CMAKE_CURRENT_SOURCE_DIR}/../../macos/Pods/AgoraRtcEngine_macOS"
    )

    target_link_libraries(${LIBRARY_NAME}
        PUBLIC
        "${FRAMEWORKS}"
        )
else()
    # /Users/fenglang/codes/aw/Agora-Flutter/integration_test_app/
    set(LIBS_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/../../windows/third_party/iris/Agora_Native_SDK_for_Windows_IRIS/x64/Release/AgoraRtcWrapper.lib"
        )
    target_link_libraries(${LIBRARY_NAME} PUBLIC 
                          ${LIBS_DIR}
                          )

endif()

if (APPLE)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/unittest)
endif()
