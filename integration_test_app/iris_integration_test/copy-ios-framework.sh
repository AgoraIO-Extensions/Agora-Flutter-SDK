#!/usr/bin/env bash

set -e
set -x

AGORA_RTC_WRAPPER_FRAMEWORK_PATH=$1

ROOT_PATH=$(pwd)
MY_PATH=$(dirname "$0")
IRIS_INTEGRATION_TEST_PATH=$ROOT_PATH/integration_test_app/iris_integration_test

cp -RP $AGORA_RTC_WRAPPER_FRAMEWORK_PATH $IRIS_INTEGRATION_TEST_PATH/AgoraRtcWrapper.xcframework

bash $MY_PATH/to-framework-any.sh $IRIS_INTEGRATION_TEST_PATH

cp -RP $IRIS_INTEGRATION_TEST_PATH/ALL_ARCHITECTURE/AgoraRtcWrapper.framework $IRIS_INTEGRATION_TEST_PATH/AgoraRtcWrapper.framework

rm -rf $IRIS_INTEGRATION_TEST_PATH/AgoraRtcWrapper.xcframework
rm -rf $IRIS_INTEGRATION_TEST_PATH/ALL_ARCHITECTURE