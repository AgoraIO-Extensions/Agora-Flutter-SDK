#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH="$AGORA_FLUTTER_PROJECT_PATH/../iris"
BUILD_TYPE="SIMULATOR64"

echo "Copying $IRIS_PROJECT_PATH/build/ios/$BUILD_TYPE/output/rtc/Debug/AgoraRtcWrapper.framework $AGORA_FLUTTER_PROJECT_PATH/ios/AgoraRtcWrapper.framework"
cp -r "$IRIS_PROJECT_PATH/build/ios/$BUILD_TYPE/output/rtc/Debug/AgoraRtcWrapper.framework" "$AGORA_FLUTTER_PROJECT_PATH/ios/"

echo "Generating framework"
lipo -create "$IRIS_PROJECT_PATH/build/ios/SIMULATOR64/output/rtc/Debug/AgoraRtcWrapper.framework/AgoraRtcWrapper" "$IRIS_PROJECT_PATH/build/ios/OS64COMBINED/output/rtc/Debug/AgoraRtcWrapper.framework/AgoraRtcWrapper" -output "$AGORA_FLUTTER_PROJECT_PATH/ios/AgoraRtcWrapper.framework/AgoraRtcWrapper"