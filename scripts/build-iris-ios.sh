#!/usr/bin/env bash

set -e
set -x

# e.g., bash scripts/build-iris-ios.sh <iris-project-path> <Debug|Release> Agora_Native_SDK_for_iOS_FULL

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH=$1
ARCH_TYPE="SIMULATOR64"
BUILD_TYPE=$2
NATIVE_SDK_PATH_NAME=$3 # Agora_Native_SDK_for_Mac_rel.v3.8.201.2_39877_full_20220608_2158
SCRIPTS_PATH=$(dirname "$0")

rm -rf "${IRIS_PROJECT_PATH}/build/ios/ALL_ARCHITECTURE/output/dcg/${BUILD_TYPE}/AgoraRtcWrapper.xcframework"

bash $IRIS_PROJECT_PATH/ci/build-ios.sh buildALL $BUILD_TYPE

if [[ -d "${AGORA_FLUTTER_PROJECT_PATH}/ios/libs" ]]; then
    rm -rf "${AGORA_FLUTTER_PROJECT_PATH}/ios/libs"
fi

mkdir -p "${AGORA_FLUTTER_PROJECT_PATH}/ios/libs"

echo "Copying Agora RTC engine frameworks"
cp -RP ${IRIS_PROJECT_PATH}/third_party/agora/dcg/libs/$NATIVE_SDK_PATH_NAME/libs/* "${AGORA_FLUTTER_PROJECT_PATH}/ios/libs/"
rm -rf ${AGORA_FLUTTER_PROJECT_PATH}/ios/libs/ALL_ARCHITECTURE

cp -RP "${IRIS_PROJECT_PATH}/build/ios/DCG/ALL_ARCHITECTURE/output/${BUILD_TYPE}/AgoraRtcWrapper.xcframework" "$AGORA_FLUTTER_PROJECT_PATH/ios/libs"