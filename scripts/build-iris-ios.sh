#!/usr/bin/env bash

set -e
set -x

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH=$1
ARCH_TYPE="SIMULATOR64"
BUILD_TYPE=$2
NATIVE_SDK_PATH_NAME=$3 # Agora_Native_SDK_for_Mac_rel.v3.8.201.2_39877_full_20220608_2158
SCRIPTS_PATH=$(dirname "$0")

rm -rf "${IRIS_PROJECT_PATH}/build/ios/ALL_ARCHITECTURE/output/dcg/${BUILD_TYPE}/AgoraRtcWrapper.xcframework"

# bash $IRIS_PROJECT_PATH/rtc/ci/build-ios.sh build SIMULATOR64 $BUILD_TYPE
# bash $IRIS_PROJECT_PATH/rtc/ci/build-ios.sh build OS64COMBINED $BUILD_TYPE
bash $SCRIPTS_PATH/build-ios-arch.sh $IRIS_PROJECT_PATH ALL $BUILD_TYPE

# echo "Copying $IRIS_PROJECT_PATH/build/ios/$ARCH_TYPE/output/rtc/$BUILD_TYPE/AgoraRtcWrapper.framework $AGORA_FLUTTER_PROJECT_PATH/ios/AgoraRtcWrapper.framework"
# cp -RP "$IRIS_PROJECT_PATH/build/ios/$ARCH_TYPE/output/rtc/$BUILD_TYPE/AgoraRtcWrapper.framework" "$AGORA_FLUTTER_PROJECT_PATH/ios/"

if [[ -d "${AGORA_FLUTTER_PROJECT_PATH}/ios/libs" ]]; then
    rm -rf "${AGORA_FLUTTER_PROJECT_PATH}/ios/libs"
fi

mkdir -p "${AGORA_FLUTTER_PROJECT_PATH}/ios/libs"

echo "Copying Agora RTC engine frameworks"
cp -RP ${IRIS_PROJECT_PATH}/third_party/agora/dcg/libs/$NATIVE_SDK_PATH_NAME/libs/* "${AGORA_FLUTTER_PROJECT_PATH}/ios/libs/"
rm -rf ${AGORA_FLUTTER_PROJECT_PATH}/ios/libs/ALL_ARCHITECTURE

# if [ ! -d "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/iris" ]; then
#     mkdir -p "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/iris"
# fi
# cp -RP "$IRIS_PROJECT_PATH/build/ios/ALL_ARCHITECTURE/output/rtc/Release/AgoraRtcWrapper.xcframework/ios-arm64_armv7/AgoraRtcWrapper.framework/Headers/" "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/iris"

# if [ ! -d "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/agora/rtc/include" ]; then
#     mkdir -p "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/agora/rtc/include"
# fi
# cp -RP "$IRIS_PROJECT_PATH/third_party/agora/rtc/include/" "$AGORA_FLUTTER_PROJECT_PATH/integration_test_app/iris_integration_test/third_party/agora/rtc/include"

cp -RP "${IRIS_PROJECT_PATH}/build/ios/ALL_ARCHITECTURE/output/dcg/${BUILD_TYPE}/AgoraRtcWrapper.xcframework" "$AGORA_FLUTTER_PROJECT_PATH/ios/libs"