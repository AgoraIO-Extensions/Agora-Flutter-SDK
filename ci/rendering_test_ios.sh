#!/usr/bin/env bash

set -e
set -o pipefail
set -x

MY_PATH=$(dirname "$0")

export SAVE_DEBUG_GOLDEN="true"
export IOS_SIMULATOR_SCREENSHOT="true"

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

# TODO(littlegnal): Add `--no-enable-impeller` flag to disable impeller at this time.
# https://github.com/flutter/flutter/issues/134852
# TODO(littlegnal): Temporily disable the `agora_video_view_render_test.dart` https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1580
# flutter drive --no-enable-impeller --driver=test_driver/integration_test.dart --target=integration_test/agora_video_view_render_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose

MAX_ATTEMPTS="${IOS_RENDERING_TEST_MAX_ATTEMPTS:-2}"
for ((attempt = 1; attempt <= MAX_ATTEMPTS; attempt++)); do
  echo "Running iOS rendering test (attempt ${attempt}/${MAX_ATTEMPTS})"
  ATTEMPT_LOG=$(mktemp "${TMPDIR:-/tmp}/agora-ios-rendering-test.XXXXXX")
  if flutter drive --no-enable-impeller --driver=test_driver/integration_test.dart \
    --target=integration_test/agora_video_view_smoke_test.dart \
    --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose 2>&1 | tee "${ATTEMPT_LOG}"; then
    rm -f "${ATTEMPT_LOG}"
    break
  fi

  if ! grep -Eq "Service has disappeared|Error waiting for a debug connection: The log reader failed unexpectedly" "${ATTEMPT_LOG}"; then
    rm -f "${ATTEMPT_LOG}"
    exit 1
  fi
  rm -f "${ATTEMPT_LOG}"

  if ((attempt == MAX_ATTEMPTS)); then
    exit 1
  fi

  echo "Retrying after a transient iOS rendering test failure..."
  sleep 5
done

popd
