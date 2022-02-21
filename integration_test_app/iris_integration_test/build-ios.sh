#!/usr/bin/env bash

set -e
set -x

ROOT_PATH=$(pwd)
IRIS_INTEGRATION_TEST_PATH=$ROOT_PATH/integration_test_app/iris_integration_test

if [ ! -d "$IRIS_INTEGRATION_TEST_PATH/build/ios" ]; then
    mkdir -p $IRIS_INTEGRATION_TEST_PATH/build/ios
fi

pushd $IRIS_INTEGRATION_TEST_PATH/build/ios

#   if [[ "$1" == "OS64COMBINED" ]]; then
#     archs="armv7;arm64"
#   fi
  cmake \
    -G "Xcode" \
    -DCMAKE_TOOLCHAIN_FILE="${IRIS_INTEGRATION_TEST_PATH}/ios.toolchain.cmake" \
    -DPLATFORM="SIMULATOR64" \
    -DDEPLOYMENT_TARGET="9.0" \
    -DCMAKE_BUILD_TYPE="Debug" \
    "$IRIS_INTEGRATION_TEST_PATH"
cmake --build . --config "Debug"

popd

# /Users/fenglang/codes/aw/Agora-Flutter/integration_test_app/iris_integration_test/build/ios/Debug-iphonesimulator/iris_integration_test.framework
cp -r "${IRIS_INTEGRATION_TEST_PATH}/build/ios/Debug-iphonesimulator/iris_integration_test.framework" "${IRIS_INTEGRATION_TEST_PATH}/../ios/Runner"