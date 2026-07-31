#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/..)

pushd ${PROJECT_ROOT}

flutter --version
flutter packages get
bash ${MY_PATH}/flutter-build-runner.sh
dart format .

popd
