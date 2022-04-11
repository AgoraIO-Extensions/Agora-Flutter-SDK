#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
IRIS_PROJECT_PATH=$(pwd)/web

pushd "$AGORA_FLUTTER_PROJECT_PATH"
echo "Updating submodule web"
git submodule update --remote
popd

pushd "$IRIS_PROJECT_PATH"
echo "Building Iris-Rtc-Web"
yarn
yarn build
echo "Copying $IRIS_PROJECT_PATH/dist/ to $AGORA_FLUTTER_PROJECT_PATH/assets/"
cp -r "$IRIS_PROJECT_PATH/dist/" \
  "$AGORA_FLUTTER_PROJECT_PATH/assets/"
popd
