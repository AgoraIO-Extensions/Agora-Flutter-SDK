#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH="$AGORA_FLUTTER_PROJECT_PATH/../iris/"
BUILD_TYPE=$1
ABIS="arm64-v8a armeabi-v7a x86_64"

bash $IRIS_PROJECT_PATH/rtc/ci/build-android.sh

echo "Copying $IRIS_PROJECT_PATH/build/android/arm64-v8a/output/rtc/AgoraRtcWrapper.jar to $AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraRtcWrapper.jar"
cp -r "$IRIS_PROJECT_PATH/build/android/arm64-v8a/output/rtc/AgoraRtcWrapper.jar" "$AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraRtcWrapper.jar"

for ABI in ${ABIS};
do
    echo "Copying $IRIS_PROJECT_PATH/build/android/$ABI/output/rtc/$BUILD_TYPE/libAgoraRtcWrapper.so to $AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/libAgoraRtcWrapper.so"
    mkdir -p "$AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/" && \
    cp -r "$IRIS_PROJECT_PATH/build/android/$ABI/output/rtc/$BUILD_TYPE/libAgoraRtcWrapper.so" \
          "$AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/libAgoraRtcWrapper.so" 
done;