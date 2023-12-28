#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

DOWNLOAD_IRIS_DEBUGGER=${1:-1}

if [[ ${DOWNLOAD_IRIS_DEBUGGER} == 1 ]];then
    source ${MY_PATH}/../scripts/artifacts_version.sh

    bash ${MY_PATH}/../scripts/download_unzip_iris_cdn_artifacts.sh ${IRIS_CDN_URL_MACOS} "MAC"
fi

pushd ${MY_PATH}/../test_shard/fake_test_app

flutter packages get

# It's a little tricky that you should run integration test one by one on flutter macOS/Windows
for filename in integration_test/*.dart; do
    if [[ "$filename" == *.generated.dart  ]]; then
        continue
    fi
    flutter test $filename -d macos
done

popd

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

# It's a little tricky that you should run integration test one by one on flutter macOS/Windows
for filename in integration_test/*.dart; do
    if [[ "$filename" == *.generated.dart  ]]; then
        continue
    fi
    
    flutter test $filename --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d macos
done

popd