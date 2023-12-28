#!/usr/bin/env bash

set -e
set -x

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH=$1
BUILD_TYPE=$2
ABIS="arm64-v8a armeabi-v7a x86_64"
IRIS_TYPE="dcg"
NATIVE_SDK_PATH_NAME=$3 # Agora_Native_SDK_for_Mac_rel.v3.8.201.2_39877_full_20220608_2158
SCRIPTS_PATH=$(dirname "$0")

bash $IRIS_PROJECT_PATH/ci/build-android.sh buildALL $BUILD_TYPE

    # build/android/DCG/ALL_ARCHITECTURE/output/Debug

IRIS_OUTPUT=${IRIS_PROJECT_PATH}/build/android/$IRIS_TYPE/ALL_ARCHITECTURE/output/$BUILD_TYPE

for ABI in ${ABIS};
do
    echo "Copying $IRIS_PROJECT_PATH/build/android/$ABI/output/$IRIS_TYPE/$BUILD_TYPE/libAgoraRtcWrapper.so to $AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/libAgoraRtcWrapper.so"
    # bash $IRIS_PROJECT_PATH/$IRIS_TYPE/ci/build-android.sh build $ABI $BUILD_TYPE
    mkdir -p "$AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/"

    cp -RP "${IRIS_OUTPUT}/$ABI/libAgoraRtcWrapper.so" \
          "$AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/libAgoraRtcWrapper.so" 

    if [ -f "${IRIS_OUTPUT}/${ABI}/libIrisDebugger.so" ]; then
        mkdir -p ${AGORA_FLUTTER_PROJECT_PATH}/test_shard/iris_tester/android/libs/${ABI}
        cp -RP "${IRIS_OUTPUT}/$ABI/libIrisDebugger.so" "${AGORA_FLUTTER_PROJECT_PATH}/test_shard/iris_tester/android/libs/${ABI}/libIrisDebugger.so"
    fi
done;

# echo "Copying $IRIS_PROJECT_PATH/build/android/ALL_ARCHITECTURE/output/$IRIS_TYPE/$BUILD_TYPE/AgoraRtcWrapper.aar to $AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraRtcWrapper.aar"
# cp -r "$IRIS_PROJECT_PATH/build/android/ALL_ARCHITECTURE/output/$IRIS_TYPE/$BUILD_TYPE/AgoraRtcWrapper.aar" "$AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraRtcWrapper.aar"

echo "Copying ${IRIS_OUTPUT}/AgoraRtcWrapper.jar to $AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraRtcWrapper.jar"
cp -r "${IRIS_OUTPUT}/AgoraRtcWrapper.jar" "$AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraRtcWrapper.jar"

for ABI in ${ABIS};
do
    echo "Copying $IRIS_PROJECT_PATH/third_party/agora/$IRIS_TYPE/libs/$NATIVE_SDK_PATH_NAME/libs/$ABI/ to $AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/"
    # third_party/agora/rtc/libs/Agora_Native_SDK_for_Android_FULL
    cp -r "$IRIS_PROJECT_PATH/third_party/agora/$IRIS_TYPE/libs/$NATIVE_SDK_PATH_NAME/rtc/sdk/$ABI/" \
          "$AGORA_FLUTTER_PROJECT_PATH/android/libs/$ABI/" 
done;

if [[ ! -d "$AGORA_FLUTTER_PROJECT_PATH/third_party/include/" ]]; then
    mkdir -p "$AGORA_FLUTTER_PROJECT_PATH/third_party/include/"
fi

echo "Copying $IRIS_PROJECT_PATH/third_party/agora/$IRIS_TYPE/libs/$NATIVE_SDK_PATH_NAME/libs/agora-rtc-sdk.jar to $AGORA_FLUTTER_PROJECT_PATH/android/libs/libs/agora-rtc-sdk.jar"
cp -r "$IRIS_PROJECT_PATH/third_party/agora/$IRIS_TYPE/libs/$NATIVE_SDK_PATH_NAME/rtc/sdk/agora-rtc-sdk.jar" "$AGORA_FLUTTER_PROJECT_PATH/android/libs/agora-rtc-sdk.jar"

# /Users/fenglang/codes/aw/iris/third_party/agora/dcg/libs/Agora_Native_SDK_for_Android_FULL/rtc/sdk/AgoraScreenShareExtension.aar
cp -r "$IRIS_PROJECT_PATH/third_party/agora/$IRIS_TYPE/libs/$NATIVE_SDK_PATH_NAME/rtc/sdk/AgoraScreenShareExtension.aar" "$AGORA_FLUTTER_PROJECT_PATH/android/libs/AgoraScreenShareExtension.aar"
