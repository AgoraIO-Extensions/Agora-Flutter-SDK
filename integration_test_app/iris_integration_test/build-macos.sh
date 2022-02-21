#!/usr/bin/env bash

set -e
set -x

ROOT_PATH=$(pwd)
IRIS_INTEGRATION_TEST_PATH=$ROOT_PATH/integration_test_app/iris_integration_test

if [ ! -d "$IRIS_INTEGRATION_TEST_PATH/build/mac" ]; then
    mkdir -p $IRIS_INTEGRATION_TEST_PATH/build/mac
fi

pushd $IRIS_INTEGRATION_TEST_PATH/build/mac

cmake \
    -G Xcode \
    -DPLATFORM="MAC" \
    -DCMAKE_OSX_ARCHITECTURES="x86_64" \
    -DCMAKE_BUILD_TYPE="Debug" \
    -DRUN_TEST=1 \
    "$IRIS_INTEGRATION_TEST_PATH"
cmake --build . --config "Debug"

popd

cp -r "${IRIS_INTEGRATION_TEST_PATH}/build/mac/Debug/iris_integration_test.framework" "${IRIS_INTEGRATION_TEST_PATH}/../macos/Runner"