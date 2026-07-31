#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(realpath $(dirname "$0"))
AGORA_FLUTTER_PROJECT_PATH=$(realpath ${MY_PATH}/..)

pushd ${AGORA_FLUTTER_PROJECT_PATH}

rm -rf $AGORA_FLUTTER_PROJECT_PATH/example/macos/Flutter/ephemeral
rm -rf $AGORA_FLUTTER_PROJECT_PATH/example/windows/Flutter/ephemeral
rm -rf $AGORA_FLUTTER_PROJECT_PATH/example/linux/Flutter/ephemeral
rm -rf $AGORA_FLUTTER_PROJECT_PATH/example/ios/.symlinks

dart run build_runner build --delete-conflicting-outputs

popd
