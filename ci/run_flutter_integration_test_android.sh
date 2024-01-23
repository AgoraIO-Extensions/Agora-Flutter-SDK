#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")
PROJECT_ROOT=${MY_PATH}/..

DOWNLOAD_IRIS_DEBUGGER=${1:-1}

if [[ ${DOWNLOAD_IRIS_DEBUGGER} == 1 ]];then
    source ${MY_PATH}/../scripts/artifacts_version.sh

    bash ${MY_PATH}/../scripts/download_unzip_iris_cdn_artifacts.sh ${IRIS_CDN_URL_ANDROID} "Android"
fi

pushd ${MY_PATH}/../test_shard/fake_test_app

flutter packages get

flutter test integration_test --verbose

# If the integration test failed, get the iris logs
if [ $? -ne 0 ]; then
    echo "Some of integration test failed..."
    echo "Dump iris logs..."

    OUT_LOG_DIR=${PROJECT_ROOT}/iris-logs-android

    mkdir ${OUT_LOG_DIR}
    adb exec-out run-as com.example.fake_test_app cat app_flutter/agora-iris.log > ${OUT_LOG_DIR}/agora-iris-fake-test.log
    adb exec-out run-as io.agora.integration_test_app.integration_test_app cat app_flutter/agora-iris.log > ${OUT_LOG_DIR}/agora-iris-integration-test.log
    adb exec-out run-as com.example.rendering_test cat app_flutter/agora-iris.log > ${OUT_LOG_DIR}/agora-iris-rendering-test.log
fi

popd

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

flutter test integration_test --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose

popd

# # If the integration test failed, get the iris logs
# if [ $? -ne 0 ]; then
#     echo "Some of integration test failed..."
#     echo "Dump iris logs..."

#     mkdir iris-logs-android
#     adb exec-out run-as com.example.fake_test_app cat app_flutter/agora-iris.log > ./iris-logs-android/agora-iris-fake-test.log
#     adb exec-out run-as io.agora.integration_test_app.integration_test_app cat app_flutter/agora-iris.log > ./iris-logs-android/agora-iris-integration-test.log
#     adb exec-out run-as com.example.rendering_test cat app_flutter/agora-iris.log > ./iris-logs-android/agora-iris-rendering-test.log
# fi