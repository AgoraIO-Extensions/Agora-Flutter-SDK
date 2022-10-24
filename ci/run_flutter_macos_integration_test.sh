#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

flutter packages get

cd ${MY_PATH}/../test_shard/integration_test_app

# pushd iris_integration_test
# git submodule update
# popd

flutter packages get

# It's a little tricky that you should run integration test one by one on flutter macOS/Windows
for filename in integration_test/*.dart; do
    if [[ "$filename" == *.generated.dart  ]]; then
        continue
    fi
    flutter test $filename --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d macos
done