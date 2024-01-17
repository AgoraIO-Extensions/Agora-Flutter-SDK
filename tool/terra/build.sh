#!/usr/bin/env bash
set -e
set -x

MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/../..)

bash ${MY_PATH}/prepare.sh

pushd ${MY_PATH}

npm exec terra -- run \
    --config ${PROJECT_ROOT}/tool/terra/legacy_terra_config.yaml  \
    --output-dir=${PROJECT_ROOT}/lib/src

# Incremental migrate to the new terra, this will override the existing files
npm exec terra -- run \
    --config ${PROJECT_ROOT}/tool/terra/terra_config_main.yaml  \
    --output-dir=${PROJECT_ROOT}/

popd

pushd ${PROJECT_ROOT}

dart format .

popd