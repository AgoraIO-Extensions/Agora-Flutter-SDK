#!/usr/bin/env bash

set -e

ROOT_PATH=$(pwd)
EXAMPLE_PATH=$ROOT_PATH/example

cd $EXAMPLE_PATH

flutter clean
flutter packages get

mkdir build/internal_testing_artifacts
mkdir build/internal_testing_artifacts/ios
mkdir build/internal_testing_artifacts/android

flutter build ipa --dart-define TEST_APP_ID="$TEST_APP_ID" --dart-define TEST_TOEKN="$TEST_TOEKN" --dart-define TEST_CHANNEL_ID="$TEST_CHANNEL_ID" --export-options-plist $exportPList
cp -r $EXAMPLE_PATH/build/app/outputs/flutter-apk/app-release.apk $EXAMPLE_PATH/build/internal_testing_artifacts/android/agora_rtc_engine_example.apk

bash $ROOT_PATH/scripts/build-internal-testing-ios.sh

dt=$(date '+%d/%m/%Y %H:%M:%S')
zip -r -y "$EXAMPLE_PATH/build/internal_testing_artifacts_${dt}.zip" "$EXAMPLE_PATH/build/internal_testing_artifacts"
