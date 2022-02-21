#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH="$AGORA_FLUTTER_PROJECT_PATH/../iris"
ARCH_TYPE="SIMULATOR64"
BUILD_TYPE=$1

bash $IRIS_PROJECT_PATH/rtc/ci/build-ios.sh

echo "Copying $IRIS_PROJECT_PATH/build/ios/$ARCH_TYPE/output/rtc/$BUILD_TYPE/AgoraRtcWrapper.framework $AGORA_FLUTTER_PROJECT_PATH/ios/AgoraRtcWrapper.framework"
cp -r "$IRIS_PROJECT_PATH/build/ios/$ARCH_TYPE/output/rtc/$BUILD_TYPE/AgoraRtcWrapper.framework" "$AGORA_FLUTTER_PROJECT_PATH/ios/"

if [ ! -d "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/iris" ]; then
    mkdir -p "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/iris"
fi
cp -r "$IRIS_PROJECT_PATH/build/ios/OS64COMBINED/output/rtc/Release/AgoraRtcWrapper.framework/Headers/" "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/iris"

if [ ! -d "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/agora/rtc/include" ]; then
    mkdir -p "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/agora/rtc/include"
fi
cp -r "$IRIS_PROJECT_PATH/third_party/agora/rtc/include/" "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/agora/rtc/include"

echo "Generating framework"
lipo -create "$IRIS_PROJECT_PATH/build/ios/SIMULATOR64/output/rtc/$BUILD_TYPE/AgoraRtcWrapper.framework/AgoraRtcWrapper" "$IRIS_PROJECT_PATH/build/ios/OS64COMBINED/output/rtc/$BUILD_TYPE/AgoraRtcWrapper.framework/AgoraRtcWrapper" -output "$AGORA_FLUTTER_PROJECT_PATH/ios/AgoraRtcWrapper.framework/AgoraRtcWrapper"