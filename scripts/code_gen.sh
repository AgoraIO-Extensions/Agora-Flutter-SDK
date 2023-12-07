#!/usr/bin/env bash
set -e
set -x

TERRA_PATH=$1
MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/..)

pushd ${PROJECT_ROOT}

flutter packages get
bash ${PROJECT_ROOT}/tool/terra/build.sh ${TERRA_PATH}
bash ${MY_PATH}/flutter-build-runner.sh
bash ${PROJECT_ROOT}/tool/testcase_gen/build.sh

dart format .

popd