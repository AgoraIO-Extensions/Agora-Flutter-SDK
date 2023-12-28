#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/rendering_test

export SAVE_DEBUG_GOLDEN="true"

flutter packages get

flutter drive --driver=test_driver/integration_test.dart --target=integration_test/agora_video_view_render_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}"

flutter drive --driver=test_driver/integration_test.dart --target=integration_test/agora_video_view_smoke_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}"

popd