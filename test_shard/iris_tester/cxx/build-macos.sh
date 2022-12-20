#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")
SRC_PATH=$(realpath -e ${MY_PATH})

ARCHS="arm64 x86_64"
BUILD_TYPE="Debug"

# pushd ${MY_PATH}/../../../macos
#     flutter packages get
#     pod install
# popd

if [ ! -d "$SRC_PATH/build/mac" ]; then
    mkdir -p ${SRC_PATH}/build/mac
fi

pushd ${SRC_PATH}/build/mac
cmake \
  -G "Xcode" \
  -DCMAKE_TOOLCHAIN_FILE="${SRC_PATH}/ios.toolchain.cmake" \
  -DPLATFORM="MAC" \
  -DARCHS="$ARCHS" \
  -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
  "$SRC_PATH"
cmake --build . --config "$BUILD_TYPE"
popd

# pushd ${SRC_PATH}/build/mac

# cmake \
#     -G Xcode \
#     -DPLATFORM="MAC" \
#     -DCMAKE_OSX_ARCHITECTURES="x86_64" \
#     -DCMAKE_BUILD_TYPE="Debug" \
#     -DRUN_TEST=1 \
#     "${SRC_PATH}"
# cmake --build . --config "Debug"

# popd

rm -rf ${SRC_PATH}/../macos/iris_tester_handler.framework
cp -RP "${SRC_PATH}/build/mac/Debug/iris_tester_handler.framework" "${SRC_PATH}/../macos"