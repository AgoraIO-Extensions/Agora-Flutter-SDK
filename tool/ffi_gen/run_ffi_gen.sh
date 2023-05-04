#!/usr/bin/env bash
set -e
set -x

IRIS_PATH=$1
MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/../..)
TMP_FFI_GEN_INCLUDE_DIR_NAME=${PROJECT_ROOT}/tmp_ffi_gen_include

rm -rf ${TMP_FFI_GEN_INCLUDE_DIR_NAME}
mkdir ${TMP_FFI_GEN_INCLUDE_DIR_NAME}

cp -RP ${IRIS_PATH}/src/interface/* ${TMP_FFI_GEN_INCLUDE_DIR_NAME}
cp -RP ${IRIS_PATH}/src/interface/rtc/* ${TMP_FFI_GEN_INCLUDE_DIR_NAME}
# cp -RP ${MY_PATH}/ffigen_config.yaml ${TMP_FFI_GEN_INCLUDE_DIR_NAME}/ffigen_config.yaml

pushd ${PROJECT_ROOT}

flutter packages get
flutter pub run ffigen --config=${MY_PATH}/ffigen_config.yaml

popd

rm -rf ${TMP_FFI_GEN_INCLUDE_DIR_NAME}