#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

while IFS= read -r filename; do
    echo "Running iOS integration test: ${filename}"
    flutter test "${filename}" --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose
done < <(find integration_test -maxdepth 1 -type f -name '*.dart' ! -name '*.generated.dart' | sort)

popd
