#!/usr/bin/env bash
set -e
set -x

MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/../../)

pushd ${MY_PATH}
dart pub get
popd

dart run ${MY_PATH}/bin/testcase_gen.dart \
    --gen-fake-test --output-dir=${PROJECT_ROOT}/test_apps/fake_test_app/integration_test/generated

dart run ${MY_PATH}/bin/testcase_gen.dart \
    --gen-integration-test --output-dir=${PROJECT_ROOT}/test_apps/integration_test_app/integration_test/generated

dart format .
