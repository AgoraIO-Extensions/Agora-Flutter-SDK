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

        if grep -Fq "No tests were found." "${ATTEMPT_LOG}" && \
            grep -Fq "✅" "${ATTEMPT_LOG}" && \
            ! grep -Fq "❌" "${ATTEMPT_LOG}"; then
            echo "Flutter reported no test results, but integration_test reported passing tests; accepting the run."
            rm -f "${ATTEMPT_LOG}"
            break
        fi

        if awk '/Test process is no longer needed by test harness/ { ended = 1; next } ended && /✅/ { late_pass = 1 } END { exit !late_pass }' "${ATTEMPT_LOG}" && \
            grep -Eq "🎉 [1-9][0-9]* tests passed\." "${ATTEMPT_LOG}" && \
            grep -Fq "test package returned with exit code 1" "${ATTEMPT_LOG}" && \
            ! grep -Eq "❌|Some tests failed\.|Failure Details:" "${ATTEMPT_LOG}"; then
            echo "Flutter exited after iOS reported all integration tests passed; accepting the run."
            rm -f "${ATTEMPT_LOG}"
            break
        fi

        if ! grep -Eq "Error waiting for a debug connection: The log reader failed unexpectedly|TimeoutException.*Test timed out after 12 minutes|No tests were found\." "${ATTEMPT_LOG}"; then
            rm -f "${ATTEMPT_LOG}"
            echo "iOS integration test failed with a non-retryable error: ${filename}" >&2
            exit 1
        fi
        rm -f "${ATTEMPT_LOG}"

        if ((attempt == MAX_ATTEMPTS)); then
            echo "iOS integration test failed after ${MAX_ATTEMPTS} attempts: ${filename}" >&2
            exit 1
        fi

        echo "Retrying after a transient iOS integration test failure..."
        sleep 5
    done
done < <(find integration_test -maxdepth 1 -type f -name '*.dart' ! -name '*.generated.dart' | sort)

popd
