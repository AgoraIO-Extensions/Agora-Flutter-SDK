#!/usr/bin/env bash

set -e
set -x

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH="$AGORA_FLUTTER_PROJECT_PATH/../iris"
BUILD_TYPE=$1

echo "Cleaning build cache..."
rm -rf $IRIS_PROJECT_PATH/build

echo "Building iris for mac..."
bash $IRIS_PROJECT_PATH/rtc/ci/build-mac.sh

if [[ -d "$AGORA_FLUTTER_PROJECT_PATH/macos/AgoraRtcWrapper.framework" ]]; then
    rm -rf $AGORA_FLUTTER_PROJECT_PATH/macos/AgoraRtcWrapper.framework
fi

echo "Copying $IRIS_PROJECT_PATH/build/mac/MAC/output/rtc/$BUILD_TYPE/AgoraRtcWrapper.framework $AGORA_FLUTTER_PROJECT_PATH/macos/AgoraRtcWrapper.framework"
cp -RP "$IRIS_PROJECT_PATH/build/mac/MAC/output/rtc/$BUILD_TYPE/AgoraRtcWrapper.framework" "$AGORA_FLUTTER_PROJECT_PATH/macos/"

if [[ -d "${AGORA_FLUTTER_PROJECT_PATH}/macos/libs" ]]; then
    rm -rf "${AGORA_FLUTTER_PROJECT_PATH}/macos/libs"
fi

mkdir -p "${AGORA_FLUTTER_PROJECT_PATH}/macos/libs"

echo "Copying Agora RTC engine frameworks"
cp -RP ${IRIS_PROJECT_PATH}/third_party/agora/rtc/libs/Agora_Native_SDK_for_Mac_FULL/libs/* "${AGORA_FLUTTER_PROJECT_PATH}/macos/libs/"