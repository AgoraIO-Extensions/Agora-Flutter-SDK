#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")
PLATFORM=$1 # android/ios/macos/windows/web

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

if [[ ${PLATFORM} == "web" ]];then
    flutter drive \
        --verbose-system-logs \
        -d web-server \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/agora_video_view_smoke_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}"

elif [[ ${PLATFORM} == "android" || ${PLATFORM} == "ios" ]];then

    flutter drive \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/agora_video_view_render_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}"

    flutter drive \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/agora_video_view_smoke_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}"

else
    # macos/windows
    flutter test \
        integration_test/agora_video_view_render_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}" \
        -d macos

fi

popd