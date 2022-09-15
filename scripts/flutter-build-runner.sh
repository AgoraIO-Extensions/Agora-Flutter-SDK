#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)

rm -rf $AGORA_FLUTTER_PROJECT_PATH/example/macos/Flutter/ephemeral
rm -rf $AGORA_FLUTTER_PROJECT_PATH/example/windows/Flutter/ephemeral
rm -rf $AGORA_FLUTTER_PROJECT_PATH/example/ios/.symlinks

flutter packages pub run build_runner build --delete-conflicting-outputs