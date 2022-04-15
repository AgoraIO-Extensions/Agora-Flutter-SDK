#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH=$1
BUILD_TYPE=$2
ABIS="arm64-v8a armeabi-v7a x86_64"

for ABI in ${ABIS};
do
    echo "Copying $IRIS_PROJECT_PATH/build/android/$ABI/output/rtc/$BUILD_TYPE/libAgoraRtcWrapper.so to $AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/libAgoraRtcWrapper.so"
    bash $IRIS_PROJECT_PATH/rtc/ci/build-android.sh build $ABI $BUILD_TYPE
    mkdir -p "$AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/" && \
    cp -r "$IRIS_PROJECT_PATH/build/android/$ABI/output/rtc/$BUILD_TYPE/libAgoraRtcWrapper.so" \
          "$AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/libAgoraRtcWrapper.so" 
done;

echo "Copying $IRIS_PROJECT_PATH/build/android/arm64-v8a/output/rtc/AgoraRtcWrapper.jar to $AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraRtcWrapper.jar"
cp -r "$IRIS_PROJECT_PATH/build/android/arm64-v8a/output/rtc/AgoraRtcWrapper.jar" "$AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraRtcWrapper.jar"

for ABI in ${ABIS};
do
    echo "Copying $IRIS_PROJECT_PATH/third_party/agora/rtc/libs/Agora_Native_SDK_for_Android_FULL/libs/$ABI/ to $AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/"
    # third_party/agora/rtc/libs/Agora_Native_SDK_for_Android_FULL
    cp -r "$IRIS_PROJECT_PATH/third_party/agora/rtc/libs/Agora_Native_SDK_for_Android_FULL/libs/$ABI/" \
          "$AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/" 
done;

echo "Copying "$IRIS_PROJECT_PATH/third_party/agora/rtc/include/"" to "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/agora/rtc/include/"
cp -r "$IRIS_PROJECT_PATH/third_party/agora/rtc/include/" "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/agora/rtc/include/"

echo "Copying $IRIS_PROJECT_PATH/third_party/agora/rtc/libs/Agora_Native_SDK_for_Android_FULL/libs/agora-rtc-sdk.jar to $AGORA_FLUTTER_PROJECT_PATH/android/libs/libs/agora-rtc-sdk.jar"
cp -r "$IRIS_PROJECT_PATH/third_party/agora/rtc/libs/Agora_Native_SDK_for_Android_FULL/libs/agora-rtc-sdk.jar" "$AGORA_FLUTTER_PROJECT_PATH/android/libs/agora-rtc-sdk.jar"

# echo "Copying $IRIS_PROJECT_PATH/third_party/agora/rtc/libs/Agora_Native_SDK_for_Android_FULL/libs/agora-screensharing.aar to $AGORA_FLUTTER_PROJECT_PATH/android/libs/libs/agora-screensharing.aar"
# cp -r "$IRIS_PROJECT_PATH/third_party/agora/rtc/libs/Agora_Native_SDK_for_Android_FULL/libs/agora-screensharing.aar" "$AGORA_FLUTTER_PROJECT_PATH/android/libs/agora-screensharing.aar"
