#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

# flutter/flutter#189192 can leave `flutter test` waiting on desktop logs.
if [[ "${FLUTTER_VERSION:-}" == "3.47.1" ]]; then
    flutter drive -d macos \
        --driver=test_driver/integration_test.dart \
        --target=integration_test/agora_video_view_render_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}"
else
    flutter test integration_test/agora_video_view_render_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d macos
fi

popd
