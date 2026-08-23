#!/usr/bin/env bash

set -e
set -o pipefail
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

TEST_LOG=$(mktemp)
test_status=0
flutter test integration_test/agora_video_view_render_test.dart \
    --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d windows \
    2>&1 | tee "${TEST_LOG}" || test_status=${PIPESTATUS[0]}

if ((test_status != 0)); then
    if ! grep -Eq '[0-9]+ tests? passed(, [0-9]+ (tests? )?skipped)?\.[[:space:]]*$' "${TEST_LOG}"; then
        rm -f "${TEST_LOG}"
        exit "${test_status}"
    fi
    echo "Flutter reported passing tests with exit code ${test_status}; accepting the test result."
fi
rm -f "${TEST_LOG}"

popd
