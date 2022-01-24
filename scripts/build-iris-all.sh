#!/usr/bin/env bash

set -e
set -x

BUILD_TYPE=$1

if [[ -z "$BUILD_TYPE" ]]; then
    BUILD_TYPE="Debug"
fi

bash scripts/build-iris-android.sh $BUILD_TYPE
bash scripts/build-iris-ios.sh $BUILD_TYPE
bash scripts/build-iris-macos.sh $BUILD_TYPE