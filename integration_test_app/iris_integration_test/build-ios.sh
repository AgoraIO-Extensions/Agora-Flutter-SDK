#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")
ROOT_PATH=$1
IRIS_INTEGRATION_TEST_PATH=$ROOT_PATH/integration_test_app/iris_integration_test
IRIS_NAME="AgoraIrisRTC_iOS_Beta"

if [[ -f $ROOT_PATH/ios/AgoraRtcWrapper.podspec ]]; then
    bash $MY_PATH/copy-ios-framework.sh $ROOT_PATH/ios/AgoraRtcWrapper.xcframework
else
    pushd $ROOT_PATH/integration_test_app/ios
      flutter packages get
      pod install
    popd

    bash $MY_PATH/copy-ios-framework.sh $ROOT_PATH/integration_test_app/ios/Pods/$IRIS_NAME/AgoraRtcWrapper.xcframework
fi

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