#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/..)
PLATFORM=$1 # android/ios/macos/windows/web

pushd ${PROJECT_ROOT}/test_shard/rendering_test

flutter packages get

if [[ ${PLATFORM} == "web" ]];then

    IRIS_WEB_VERSION_PATH=${PROJECT_ROOT}/scripts/iris_web_version.js
    rm -rf web/iris_web_version.js
    cp -RP ${IRIS_WEB_VERSION_PATH} web/

    echo "Run rendering test on web"

    flutter drive \
        --verbose-system-logs \
        -d web-server \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/agora_video_view_smoke_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}"

elif [[ ${PLATFORM} == "android" || ${PLATFORM} == "ios" ]];then
    echo "Run rendering test on ${PLATFORM}"

    flutter drive \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/agora_video_view_render_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}"

    flutter drive \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/agora_video_view_smoke_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}"

else
    echo "Run rendering test on ${PLATFORM}"

    # macos/windows
    flutter test \
        integration_test/agora_video_view_render_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}" \
        -d macos

fi

popd