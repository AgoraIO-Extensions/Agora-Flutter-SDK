#!/usr/bin/env bash

set -e
# set -x

CDN_URL=$1
PLATFORM=$2

MY_PATH=$(dirname "$0")

source ${MY_PATH}/../scripts/artifacts_version.sh

ARTIFACTS_PATH="${MY_PATH}/../artifacts"
mkdir -p ${ARTIFACTS_PATH}

IRIS_TESTER_PATH=${MY_PATH}/../test_shard/iris_tester

DOWNLOAD_NAME=${CDN_URL##*/}

DOWNLOAD_BASE_NAME=${DOWNLOAD_NAME/.zip/""}

curl -L "${CDN_URL}" > ${ARTIFACTS_PATH}/${DOWNLOAD_NAME}

VERSION="$(cut -d'_' -f2 <<<"${DOWNLOAD_NAME}")"

pushd ${ARTIFACTS_PATH}
    unzip ${DOWNLOAD_NAME} -d ${DOWNLOAD_BASE_NAME}
popd

UNZIP_PATH="${ARTIFACTS_PATH}/${DOWNLOAD_BASE_NAME}/iris_${VERSION}_DCG_${PLATFORM}"

if [[ ${PLATFORM} == "Android" ]];then
    pushd ${UNZIP_PATH}
        ABIS="arm64-v8a armeabi-v7a x86_64"
        for ABI in ${ABIS};
        do
            if [[ ! -d "${IRIS_TESTER_PATH}/android/libs/${ABI}" ]]; then
                mkdir -p "${IRIS_TESTER_PATH}/android/libs/${ABI}"
            fi

            cp -RP "ALL_ARCHITECTURE/Release/${ABI}/libIrisDebugger.so" "${IRIS_TESTER_PATH}/android/libs/${ABI}/libIrisDebugger.so"
        done;
    popd
fi

if [[ ${PLATFORM} == "MAC" ]];then
    cp -RP "MAC/Release/Release/IrisDebugger.framework" "${IRIS_TESTER_PATH}/macos/"
fi

if [[ ${PLATFORM} == "iOS" ]];then
    cp -RP "ALL_ARCHITECTURE/Release/Release/IrisDebugger.xcframework" "${IRIS_TESTER_PATH}/ios/"
fi

if [[ ${PLATFORM} == "Windows" ]];then
    cp -RP "x64/Release/Release/IrisDebugger.xcframework" "${IRIS_TESTER_PATH}/windows/IrisDebugger.dll"
fi