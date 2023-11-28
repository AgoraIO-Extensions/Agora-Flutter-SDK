#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

# TODO(littlegnal): Add `--no-enable-impeller` flag to disable impeller at this time.
# https://github.com/flutter/flutter/issues/134852
flutter drive --no-enable-impeller --driver=test_driver/integration_test.dart --target=integration_test/agora_video_view_render_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose

flutter drive --no-enable-impeller --driver=test_driver/integration_test.dart --target=integration_test/agora_video_view_smoke_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose

popd