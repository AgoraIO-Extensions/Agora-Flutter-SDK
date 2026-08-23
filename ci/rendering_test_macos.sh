#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

flutter_test_args=()
if flutter test -v --help | grep -Fq -- '--[no-]enable-impeller'; then
    flutter_test_args+=(--no-enable-impeller)
fi

flutter test "${flutter_test_args[@]}" integration_test/agora_video_view_render_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d macos

popd
