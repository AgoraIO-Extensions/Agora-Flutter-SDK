#!/usr/bin/env bash
set -e
set -x

RTC_VERSION=$1
MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/..)

pushd ${PROJECT_ROOT}

flutter --version

dart pub get --no-example

bash ${PROJECT_ROOT}/tool/terra/build.sh ${RTC_VERSION}

bash ${MY_PATH}/flutter-build-runner.sh

bash ${PROJECT_ROOT}/tool/testcase_gen/build.sh

dart format .

popd