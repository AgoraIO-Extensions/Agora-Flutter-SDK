#!/usr/bin/env bash

set -e
set -x

ZIP_NAME=iris_3.7.1_RTC_Android_Video_20220821_0245
IRIS_ARCHIVE_NAME="${ZIP_NAME/Video_/}"
DOWNLOAD_IRIS_URL=https://download.agora.io/sdk/release/${ZIP_NAME}.zip

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
    echo $(pwd)
    cp -RP ${IRIS_ARCHIVE_NAME}/${ABI}/Release/libAgoraRtcWrapper.so ${ABI}/libAgoraRtcWrapper.so
    cp -RP ${IRIS_ARCHIVE_NAME}/${ABI}/Release/libAgoraRtcWrapperSymbol.so ${ABI}/libAgoraRtcWrapperSymbol.so
done;

rm -rf iris_android.zip
rm -rf ${IRIS_ARCHIVE_NAME}

popd