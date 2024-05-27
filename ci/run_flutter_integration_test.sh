#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/..)
PLATFORM=$1 # android/ios/macos/windows/web

if [[ ${PLATFORM} == "web" ]];then
    pushd ${PROJECT_ROOT}/test_shard/fake_test_app

    IRIS_WEB_VERSION_PATH=${PROJECT_ROOT}/scripts/iris_web_version.js
    rm -rf web/iris_web_version.js
    cp -RP ${IRIS_WEB_VERSION_PATH} web/

    echo "Run integration test on web"
    echo "If you want to run integration test on your local machine, please follow the https://docs.flutter.dev/testing/integration-tests#test-in-a-web-browser to setup first."

    flutter packages get

    for filename in integration_test/*.dart; do
        if [[ "$filename" == *.generated.dart  ]]; then
            continue
        fi

        flutter drive \
            --verbose-system-logs \
            -d web-server \
            --driver=test_driver/integration_test.dart \
            --target=${filename}
    done

    popd

elif [[ ${PLATFORM} == "android" || ${PLATFORM} == "ios" ]];then
    echo "Not implemented"
else
    echo "Not implemented"
fi