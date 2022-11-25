#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

ARTIFACTS_PATH="${MY_PATH}/../artifacts"
mkdir -p ${ARTIFACTS_PATH}

IRIS_TESTER_PATH=${MY_PATH}/../test_shard/iris_tester

source ${MY_PATH}/../scripts/artifacts_version.sh

DOWNLOAD_NAME=${IRIS_CDN_URL_ANDROID##*/}

DOWNLOAD_BASE_NAME=${DOWNLOAD_NAME/.zip/""}

curl -L "${IRIS_CDN_URL_ANDROID}" > ${ARTIFACTS_PATH}/${DOWNLOAD_NAME}

VERSION="$(cut -d'_' -f2 <<<"${DOWNLOAD_NAME}")"

pushd ${ARTIFACTS_PATH}/${DOWNLOAD_NAME}
    unzip ${DOWNLOAD_NAME} -d ${DOWNLOAD_BASE_NAME}
popd

UNZIP_PATH="${${ARTIFACTS_PATH}}/${DOWNLOAD_BASE_NAME}/iris_${VERSION}_DCG_Android"

ABIS="arm64-v8a armeabi-v7a x86_64"
for ABI in ${ABIS};
do
    if [[ ! -d "${IRIS_TESTER_PATH}/android/libs/${ABI}" ]]; then
        mkdir -p "${IRIS_TESTER_PATH}/android/libs/${ABI}"
    fi

    cp -RP "${UNZIP_PATH}/ALL_ARCHITECTURE/Release/${ABI}/libIrisDebugger.so" "${IRIS_TESTER_PATH}/android/libs/${ABI}/libIrisDebugger.so"
done;

# pushd ${MY_PATH}/../test_shard/fake_test_app

# flutter packages get

# flutter test integration_test

# popd

# pushd ${MY_PATH}/../test_shard/integration_test_app

# flutter packages get

# flutter build macos --dart-define=TEST_APP_ID="${TEST_APP_ID}" lib/fake_remote_user_main.dart
# open build/macos/Build/Products/Release/integration_test_app.app

# flutter test integration_test --dart-define=TEST_APP_ID="${TEST_APP_ID}"

# popd