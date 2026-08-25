#!/usr/bin/env bash

set -e
set -o pipefail
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

MAX_ATTEMPTS="${IOS_TEST_MAX_ATTEMPTS:-1}"

while IFS= read -r filename; do
    for ((attempt = 1; attempt <= MAX_ATTEMPTS; attempt++)); do
        echo "Running iOS integration test: ${filename} (attempt ${attempt}/${MAX_ATTEMPTS})"
        ATTEMPT_LOG=$(mktemp "${TMPDIR:-/tmp}/agora-ios-integration-test.XXXXXX")
        if flutter test "${filename}" --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose 2>&1 | tee "${ATTEMPT_LOG}"; then
            rm -f "${ATTEMPT_LOG}"
            break
        fi

        if ! grep -Fq "Error waiting for a debug connection: The log reader failed unexpectedly" "${ATTEMPT_LOG}"; then
            rm -f "${ATTEMPT_LOG}"
            echo "iOS integration test failed with a non-retryable error: ${filename}" >&2
            exit 1
        fi
        rm -f "${ATTEMPT_LOG}"

        if ((attempt == MAX_ATTEMPTS)); then
            echo "iOS integration test failed after ${MAX_ATTEMPTS} attempts: ${filename}" >&2
            exit 1
        fi

        echo "Retrying after Flutter failed to discover the iOS VM Service..."
        sleep 5
    done
done < <(find integration_test -maxdepth 1 -type f -name '*.dart' ! -name '*.generated.dart' | sort)

popd
