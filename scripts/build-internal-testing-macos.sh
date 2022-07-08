#!/usr/bin/env bash

set -e

ROOT_PATH=$(pwd)
EXAMPLE_PATH=$ROOT_PATH/example

cd $EXAMPLE_PATH

flutter build macos --release --dart-define TEST_APP_ID="$TEST_APP_ID" --dart-define TEST_TOEKN="$TEST_TOEKN" --dart-define TEST_CHANNEL_ID="$TEST_CHANNEL_ID"
mkdir -p $EXAMPLE_PATH/build/internal_testing_artifacts/macos
mkdir -p $EXAMPLE_PATH/build/internal_testing_artifacts/macos/dSYMs

cp -r $EXAMPLE_PATH/build/macos/Build/Products/Release/agora_rtc_engine_example.app "$EXAMPLE_PATH/build/internal_testing_artifacts/macos"
cp -r $EXAMPLE_PATH/build/macos/Build/Products/Release/agora_rtc_engine "$EXAMPLE_PATH/build/internal_testing_artifacts/macos/dSYMs"
cp -r $EXAMPLE_PATH/build/macos/Build/Products/Release/agora_rtc_engine_example.app.dSYM "$EXAMPLE_PATH/build/internal_testing_artifacts/macos/dSYMs"