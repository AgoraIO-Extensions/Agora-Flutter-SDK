#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(cd "$(dirname "$0")" && pwd)

export SAVE_DEBUG_GOLDEN="true"

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

# TODO(littlegnal): Add `--no-enable-impeller` flag to disable impeller at this time.
# https://github.com/flutter/flutter/issues/134852
# TODO(littlegnal): Temporily disable the `agora_video_view_render_test.dart` https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1580
# flutter drive --no-enable-impeller --driver=test_driver/integration_test.dart --target=integration_test/agora_video_view_render_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose

MAX_ATTEMPTS=3
for ((attempt = 1; attempt <= MAX_ATTEMPTS; attempt++)); do
    if python3 "${MY_PATH}/flutter_vm_service_watchdog.py" --timeout 120 -- \
        flutter drive --no-enable-impeller --driver=test_driver/integration_test.dart \
        --target=integration_test/agora_video_view_smoke_test.dart \
        --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose; then
        popd
        exit 0
    else
        result=$?
    fi
    if (( result != 124 || attempt == MAX_ATTEMPTS )); then
        exit "$result"
    fi
    echo "Retrying iOS launch after VM Service discovery timed out ($attempt/$MAX_ATTEMPTS)."
    # The app can remain paused before its VM Service has been discovered.
    xcrun simctl terminate booted com.example.renderingTest || true
done

popd
