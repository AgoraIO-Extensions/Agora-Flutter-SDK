#!/usr/bin/env bash

set -e
set -x

ROOT_PATH=$(pwd)
IRIS_INTEGRATION_TEST_PATH=$ROOT_PATH/integration_test_app/iris_integration_test

if [ ! -d "$IRIS_INTEGRATION_TEST_PATH/build/android" ]; then
    mkdir -p $IRIS_INTEGRATION_TEST_PATH/build/android
fi

cd $IRIS_INTEGRATION_TEST_PATH/build/android
echo "$IRIS_INTEGRATION_TEST_PATH"
cmake \
    -G "Ninja" \
    -DANDROID_ABI="x86_64" \
    -DANDROID_NDK="$ANDROID_NDK" \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK"/build/cmake/android.toolchain.cmake \
    -DANDROID_TOOLCHAIN=clang \
    -DANDROID_PLATFORM=android-16 \
    -DCMAKE_BUILD_TYPE="Debug" \
    -DIRIS_SDK_TYPE=RTC \
    -DPLATFORM="ANDROID" \
    "$IRIS_INTEGRATION_TEST_PATH"

cmake --build . --config "Debug"

# cmake \
#     -G Xcode \
#     -DPLATFORM="MAC" \
#     -DCMAKE_OSX_ARCHITECTURES="x86_64" \
#     -DCMAKE_BUILD_TYPE="Debug" \
#     -DRUN_TEST=1 \
#     "$IRIS_INTEGRATION_TEST_PATH"
# cmake --build . --config "Debug"
# 
# popd

# cp -r "${IRIS_INTEGRATION_TEST_PATH}/build/mac/Debug/iris_integration_test.framework" "${IRIS_INTEGRATION_TEST_PATH}/../macos/Runner"