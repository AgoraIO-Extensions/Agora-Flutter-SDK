#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

flutter test integration_test --dart-define=TEST_APP_ID="${TEST_APP_ID}" --verbose

popd