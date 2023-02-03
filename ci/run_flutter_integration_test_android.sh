#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

DOWNLOAD_IRIS_DEBUGGER=${1:-1}

if [[ ${DOWNLOAD_IRIS_DEBUGGER} == 1 ]];then
    source ${MY_PATH}/../scripts/artifacts_version.sh

    bash ${MY_PATH}/../scripts/download_unzip_iris_cdn_artifacts.sh ${IRIS_CDN_URL_ANDROID} "Android"
fi

pushd ${MY_PATH}/../test_shard/fake_test_app

flutter packages get

flutter test integration_test --verbose

popd

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

flutter test integration_test --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose

popd