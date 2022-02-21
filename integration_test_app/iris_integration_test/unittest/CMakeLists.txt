set(LIBRARY_NAME iris_integration_test_ut)

add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../third_party/googletest" googletest)

message(status adsdsdsds)

# Add test cpp file
add_executable(${LIBRARY_NAME}
        iris_rtc_engine_integration_test_helpers_unittest.cc
        main.cc
        )

set_target_properties(${LIBRARY_NAME} PROPERTIES
        LINK_FLAGS "-Wl -F ${LIBS_DIR} -rpath ${LIBS_DIR} -rpath ${CMAKE_CURRENT_SOURCE_DIR}/../../macos/Pods/AgoraRtcEngine_macOS"
    )

# Link test executable against gtest & gtest_main
target_link_libraries(${LIBRARY_NAME}
        PRIVATE
        gtest
        gtest_main
        gmock
        gmock_main
        iris_integration_test
        )

add_test(
        NAME ${LIBRARY_NAME}
        COMMAND ${LIBRARY_NAME}
)


