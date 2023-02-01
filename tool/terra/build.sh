#!/usr/bin/env bash
set -e
set -x

TERRA_PATH=$1
MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/../..)

pushd $TERRA_PATH

npm run build -- render-legacy \
    --config ${PROJECT_ROOT}/tool/terra/terra_config_main.yaml  \
    --output-dir=${PROJECT_ROOT}/lib/src \
    --export-file-path=${PROJECT_ROOT}/lib/agora_rtc_engine.dart

popd