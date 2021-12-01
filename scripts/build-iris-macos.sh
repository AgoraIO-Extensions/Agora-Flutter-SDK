#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH="$AGORA_FLUTTER_PROJECT_PATH/../iris"

echo "Cleaning build cache..."
rm -rf $IRIS_PROJECT_PATH/build

echo "Building iris for mac..."
bash $IRIS_PROJECT_PATH/rtc/ci/build-mac.sh

echo "Copying $IRIS_PROJECT_PATH/build/mac/MAC/output/rtc/Debug/AgoraRtcWrapper.framework $AGORA_FLUTTER_PROJECT_PATH/macos/AgoraRtcWrapper.framework"
cp -r "$IRIS_PROJECT_PATH/build/mac/MAC/output/rtc/Debug/AgoraRtcWrapper.framework" "$AGORA_FLUTTER_PROJECT_PATH/macos/"

echo "Copying $IRIS_PROJECT_PATH/build/mac/MAC/output/rtc/Debug/AgoraRtcScreenSharing $AGORA_FLUTTER_PROJECT_PATH/macos/AgoraRtcScreenSharing"
cp -r "$IRIS_PROJECT_PATH/build/mac/MAC/output/rtc/Debug/AgoraRtcScreenSharing" "$AGORA_FLUTTER_PROJECT_PATH/macos/"