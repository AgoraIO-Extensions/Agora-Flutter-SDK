#!/bin/bash

set -ex

IRIS_PATH=$1

# shell_path=$(
#   cd "$(dirname "$0")" || exit
#   pwd
# )
root_path=$IRIS_PATH

build() {
  cd "$root_path" || exit
  mkdir -p ./build/ios/"$1"
  cd ./build/ios/"$1" || exit
  if [ "$1" = "OS64COMBINED" ]; then
    archs="arm64"
  elif [ "$1" = "SIMULATOR64" ]; then
    archs="x86_64"
    #    archs="arm64 x86_64"
  fi
  cmake \
    -G "Xcode" \
    -DCMAKE_TOOLCHAIN_FILE="$root_path"/cmake/ios.toolchain.cmake \
    -DPLATFORM="$1" \
    -DARCHS="$archs" \
    -DDEPLOYMENT_TARGET="9.0" \
    -DCMAKE_BUILD_TYPE="$2" \
    "$root_path"
  cmake --build . --config "$2"
  unset archs
}

ARCH=$2
BUILD_TYPE=$3

if [[ -z $ARCH ]]; then 
  ARCH="ALL"
fi

if [[ -z $BUILD_TYPE ]]; then
  BUILD_TYPE="Release"
fi

if [[ "$ARCH" = "ALL" ]]; then
  echo "start build OS64COMBINED ----------"
  build OS64COMBINED $BUILD_TYPE
  echo "start build SIMULATOR64 ----------"
  build SIMULATOR64 $BUILD_TYPE
  echo "start create .xcframework ----------"
  mkdir -p "$root_path/build/ios/ALL_ARCHITECTURE/output/dcg/$BUILD_TYPE"
  xcodebuild -create-xcframework \
    -framework "$root_path/build/ios/OS64COMBINED/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework" \
    -debug-symbols "$root_path/build/ios/OS64COMBINED/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework.dSYM" \
    -framework "$root_path/build/ios/SIMULATOR64/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework" \
    -debug-symbols "$root_path/build/ios/SIMULATOR64/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework.dSYM" \
    -output "$root_path/build/ios/ALL_ARCHITECTURE/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.xcframework"
  echo "start create .framework ----------"
  cp -rp "$root_path"/build/ios/OS64COMBINED/output/dcg/$BUILD_TYPE "$root_path/build/ios/ALL_ARCHITECTURE/output/dcg"
  #  lipo -remove arm64 \
  #    "$root_path/build/ios/SIMULATOR64/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework/AgoraRtcWrapper" \
  #    -output "$root_path/build/ios/SIMULATOR64/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework/AgoraRtcWrapper"
  lipo -create \
    "$root_path/build/ios/OS64COMBINED/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework/AgoraRtcWrapper" \
    "$root_path/build/ios/SIMULATOR64/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework/AgoraRtcWrapper" \
    -output "$root_path/build/ios/ALL_ARCHITECTURE/output/dcg/$BUILD_TYPE/AgoraRtcWrapper.framework/AgoraRtcWrapper"
else
    build $ARCH $BUILD_TYPE
fi
