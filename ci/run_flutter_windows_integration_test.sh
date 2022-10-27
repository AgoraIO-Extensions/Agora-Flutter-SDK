#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/fake_test_app

flutter packages get

# It's a little tricky that you should run integration test one by one on flutter macOS/Windows
for filename in integration_test/*.dart; do
    if [[ "$filename" == *.generated.dart  ]]; then
        continue
    fi
    flutter test $filename -d windows
done

popd

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

# It's a little tricky that you should run integration test one by one on flutter macOS/Windows
for filename in integration_test/*.dart; do
    if [[ "$filename" == *.generated.dart  ]]; then
        continue
    fi
    flutter test $filename --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d windows
done

popd