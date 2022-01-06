#!/usr/bin/env bash

set -e
set -x

flutter packages get

cd integration_test_app

pushd iris_integration_test
git submodule update
popd

flutter packages get
flutter test integration_test --dart-define=TEST_APP_ID="${TEST_APP_ID}"