#!/bin/bash

set -ex

shell_path=$(
  cd "$(dirname "$0")" || exit
  pwd
)
root_path="$shell_path/../.."

build() {
  cd "$root_path" || exit
  mkdir -p ./build/mac/"$1"
  cd ./build/mac/"$1" || exit
  archs="arm64 x86_64"
  cmake \
    -G "Xcode" \
    -DCMAKE_TOOLCHAIN_FILE="$root_path"/cmake/ios.toolchain.cmake \
    -DPLATFORM="$1" \
    -DARCHS="$archs" \
    -DCMAKE_BUILD_TYPE="$2" \
    "$root_path"
  cmake --build . --config "$2"
  unset archs
}

ARCH=$1
BUILD_TYPE=$2

if [[ -z $ARCH ]]; then 
  ARCH = "ALL"
fi

if [[ -z $BUILD_TYPE ]]; then
  BUILD_TYPE = "Release"
fi

if [[ "$ARCH" = "ALL" ]]; then
  build MAC $BUILD_TYPE
else
  build $ARCH $BUILD_TYPE
fi
