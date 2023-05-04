#!/usr/bin/env bash

set -e
set -x

CDN_URL=$1
PLATFORM=$2

MY_PATH=$(dirname "$0")

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
    ABIS="arm64-v8a armeabi-v7a x86_64"
    for ABI in ${ABIS};
    do
        if [[ ! -d "${IRIS_TESTER_PATH}/android/libs/${ABI}" ]]; then
            mkdir -p "${IRIS_TESTER_PATH}/android/libs/${ABI}"
        fi

        cp -RP "${UNZIP_PATH}/Debugger/ALL_ARCHITECTURE/${ABI}/libIrisDebugger.so" "${IRIS_TESTER_PATH}/android/libs/${ABI}/libIrisDebugger.so"

        ls ${IRIS_TESTER_PATH}/android/libs/${ABI}/
    done;

    
fi

if [[ ${PLATFORM} == "MAC" ]];then
    cp -RP "${UNZIP_PATH}/Debugger/MAC/IrisDebugger.framework" "${IRIS_TESTER_PATH}/macos/"
fi

if [[ ${PLATFORM} == "iOS" ]];then
    cp -RP "${UNZIP_PATH}/Debugger/ALL_ARCHITECTURE/IrisDebugger.xcframework" "${IRIS_TESTER_PATH}/ios/"
fi

if [[ ${PLATFORM} == "Windows" ]];then
    cp -RP "${UNZIP_PATH}/Debugger/x64/IrisDebugger.dll" "${IRIS_TESTER_PATH}/windows/IrisDebugger.dll"
    cp -RP "${UNZIP_PATH}/Debugger/x64/IrisDebugger.lib" "${IRIS_TESTER_PATH}/windows/IrisDebugger.lib"
fi

# pushd ${UNZIP_PATH}





# popd