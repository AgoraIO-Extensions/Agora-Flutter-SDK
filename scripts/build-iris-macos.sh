#!/usr/bin/env bash

set -e
set -x

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH=$1
BUILD_TYPE=$2
NATIVE_SDK_PATH_NAME=$3 # Agora_Native_SDK_for_Mac_rel.v3.8.201.2_39877_full_20220608_2158
IRIS_TYPE="dcg"
SCRIPTS_PATH=$(dirname "$0")

echo "Cleaning build cache..."
rm -rf $IRIS_PROJECT_PATH/build

echo "Building iris for mac..."
bash $SCRIPTS_PATH/build-iris-macos-arch.sh $IRIS_PROJECT_PATH MAC $BUILD_TYPE

if [[ -d "$AGORA_FLUTTER_PROJECT_PATH/macos/AgoraRtcWrapper.framework" ]]; then
    rm -rf $AGORA_FLUTTER_PROJECT_PATH/macos/AgoraRtcWrapper.framework
fi

echo "Copying $IRIS_PROJECT_PATH/build/mac/MAC/output/$IRIS_TYPE/$BUILD_TYPE/AgoraRtcWrapper.framework $AGORA_FLUTTER_PROJECT_PATH/macos/AgoraRtcWrapper.framework"
cp -RP "$IRIS_PROJECT_PATH/build/mac/MAC/output/$IRIS_TYPE/$BUILD_TYPE/AgoraRtcWrapper.framework" "$AGORA_FLUTTER_PROJECT_PATH/macos/"
cp -RP "$IRIS_PROJECT_PATH/build/mac/MAC/output/$IRIS_TYPE/$BUILD_TYPE/$BUILD_TYPE/IrisDebugger.framework" "$AGORA_FLUTTER_PROJECT_PATH/test_shard/iris_tester/macos/"

rm -rf $AGORA_FLUTTER_PROJECT_PATH/third_party/include
mkdir -p $AGORA_FLUTTER_PROJECT_PATH/third_party/include
cp -RP $IRIS_PROJECT_PATH/build/mac/MAC/output/$IRIS_TYPE/$BUILD_TYPE/AgoraRtcWrapper.framework/Headers/* $AGORA_FLUTTER_PROJECT_PATH/third_party/include/

if [[ -d "${AGORA_FLUTTER_PROJECT_PATH}/macos/libs" ]]; then
    rm -rf "${AGORA_FLUTTER_PROJECT_PATH}/macos/libs"
fi

mkdir -p "${AGORA_FLUTTER_PROJECT_PATH}/macos/libs"

echo "Copying Agora RTC engine frameworks"
cp -RP ${IRIS_PROJECT_PATH}/third_party/agora/$IRIS_TYPE/libs/$NATIVE_SDK_PATH_NAME/libs/* "${AGORA_FLUTTER_PROJECT_PATH}/macos/libs/"