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
  mkdir -p ./build/android/"$1"
  cd ./build/android/"$1" || exit
  cmake \
    -G "Ninja" \
    -DANDROID_ABI="$1" \
    -DANDROID_NDK="$ANDROID_NDK" \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK"/build/cmake/android.toolchain.cmake \
    -DANDROID_TOOLCHAIN=clang \
    -DANDROID_PLATFORM=android-16 \
    -DCMAKE_BUILD_TYPE="$2" \
    "$root_path"
  cmake --build . --config "$2"
}

# e.g.,
# build-android.sh ALL Debug
# build-android.sh arm64-v8a Debug
ARCH=$2
BUILD_TYPE=$3
if [[ -z $ARCH ]]; then 
  ARCH="ALL"
fi

if [[ -z $BUILD_TYPE ]]; then
  BUILD_TYPE="Release"
fi

BUILD_TYPE_LOWER_CASE=$(echo "$BUILD_TYPE" | tr "[:upper:]" "[:lower:]")
if [ $ARCH = "ALL" ]; then
  pushd $IRIS_PATH/dcg/android
  echo "start build aar ----------"
  chmod +x ./gradlew
  ./gradlew assemble$BUILD_TYPE_LOWER_CASE
  echo "start copy outputs ----------"
  mkdir -p "$root_path/build/android/ALL_ARCHITECTURE/output/dcg/$BUILD_TYPE"
  cp "app/build/outputs/aar/app-${BUILD_TYPE_LOWER_CASE}.aar" "$root_path/build/android/ALL_ARCHITECTURE/output/dcg/${BUILD_TYPE}/AgoraRtcWrapper.aar"
  cp -rp app/build/intermediates/merged_native_libs/${BUILD_TYPE_LOWER_CASE}/out/lib/ "$root_path/build/android/ALL_ARCHITECTURE/output/dcg/${BUILD_TYPE}"
  cp -RP app/build/intermediates/aar_main_jar/${BUILD_TYPE_LOWER_CASE}/classes.jar "$root_path/build/android/ALL_ARCHITECTURE/output/dcg/${BUILD_TYPE}/AgoraRtcWrapper.jar"
  popd
else
  build $ARCH $BUILD_TYPE
fi