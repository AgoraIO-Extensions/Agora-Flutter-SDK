#!/usr/bin/env bash

set -e
set -o pipefail
set -x

MY_PATH=$(cd "$(dirname "$0")" && pwd)

pushd "${MY_PATH}/../test_shard/integration_test_app"

flutter packages get

MAX_ATTEMPTS="${IOS_TEST_MAX_ATTEMPTS:-3}"

while IFS= read -r filename; do
    for ((attempt = 1; attempt <= MAX_ATTEMPTS; attempt++)); do
        echo "Running iOS integration test: ${filename} (attempt ${attempt}/${MAX_ATTEMPTS})"
        ATTEMPT_LOG=$(mktemp "${TMPDIR:-/tmp}/agora-ios-integration-test.XXXXXX")
        if python3 "${MY_PATH}/flutter_vm_service_watchdog.py" --timeout 120 -- \
            flutter test "${filename}" --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose 2>&1 | tee "${ATTEMPT_LOG}"; then
            rm -f "${ATTEMPT_LOG}"
            break
        else
            result=$?
        fi

        if ((result != 124)) && ! grep -Fq "Error waiting for a debug connection: The log reader failed unexpectedly" "${ATTEMPT_LOG}"; then
            rm -f "${ATTEMPT_LOG}"
            echo "iOS integration test failed with a non-retryable error: ${filename}" >&2
            exit "$result"
        fi
        rm -f "${ATTEMPT_LOG}"
        xcrun simctl terminate booted io.agora.integrationtestapp.integrationTestApp || true

        if ((attempt == MAX_ATTEMPTS)); then
            echo "iOS integration test failed after ${MAX_ATTEMPTS} attempts: ${filename}" >&2
            exit "$result"
        fi

        echo "Retrying after Flutter failed to discover the iOS VM Service..."
        sleep 5
    done
done < <(find integration_test -maxdepth 1 -type f -name '*.dart' ! -name '*.generated.dart' | sort)

popd
