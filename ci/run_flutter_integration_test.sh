#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")
PLATFORM=$1 # android/ios/macos/windows/web

if [[ ${PLATFORM} == "web" ]];then
    pushd ${MY_PATH}/../test_shard/fake_test_app

    echo "Run integration test on web"

    flutter packages get

    for filename in integration_test/*.dart; do
        if [[ "$filename" == *.generated.dart  ]]; then
            continue
        fi

        flutter drive \
            --verbose-system-logs \
            -d web-server \
            --driver=test_driver/integration_test.dart \
            --target=integration_test/${filename}
    done

    popd

elif [[ ${PLATFORM} == "android" || ${PLATFORM} == "ios" ]];then
    echo "Not implemented"
else
    echo "Not implemented"
fi