#!/usr/bin/env bash

set -e
set -x

ZIP_NAME=iris_0.0.0_RTC_Android_20220506_0255
DOWNLOAD_IRIS_URL=https://download.agora.io/demo/release/${ZIP_NAME}.zip

MY_PATH=$(dirname "$0")
ROOT_PATH=$(pwd)
IRIS_INTEGRATION_TEST_PATH=$ROOT_PATH/integration_test_app/iris_integration_test

if [[ ! -d $ROOT_PATH/integration_test_app/android/libs ]]; then
    mkdir -p $ROOT_PATH/integration_test_app/android/libs
fi

# /Users/fenglang/codes/aw/Agora-Flutter-SDK/integration_test_app/android/libs/x86_64
pushd $ROOT_PATH/integration_test_app/android/libs

curl -o "iris_android.zip" -L $DOWNLOAD_IRIS_URL -v

unzip iris_android.zip -d ./

ABIS="arm64-v8a x86_64"

for ABI in ${ABIS};
do
    mkdir -p $ABI
    cp -RP ${ZIP_NAME}/${ABI}/Release/libAgoraRtcWrapper.so ${ABI}/libAgoraRtcWrapper.so
done;

rm -rf iris_android.zip
rm -rf ${ZIP_NAME}

popd