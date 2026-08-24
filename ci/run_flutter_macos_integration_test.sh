#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

# It's a little tricky that you should run integration test one by one on flutter macOS/Windows
for filename in integration_test/*.dart; do
    if [[ "$filename" == *.generated.dart  ]]; then
        continue
    fi
    
    # flutter/flutter#189192 can leave `flutter test` waiting on desktop logs.
    if [[ "${FLUTTER_VERSION:-}" == "3.47.1" ]]; then
        flutter drive -d macos \
            --driver=test_driver/integration_test.dart \
            --target="$filename" \
            --dart-define=TEST_APP_ID="${TEST_APP_ID}"
    else
        flutter test "$filename" --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d macos
    fi
done

popd
