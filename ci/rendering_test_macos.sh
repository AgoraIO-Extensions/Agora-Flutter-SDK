#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

flutter test integration_test/agora_video_view_render_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d macos

popd