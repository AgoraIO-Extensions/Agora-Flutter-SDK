#!/usr/bin/env bash

set -e

ROOT_PATH=$(pwd)
EXAMPLE_PATH=$ROOT_PATH/example

cd $EXAMPLE_PATH

function build_ios {
    bundle_identifier=$1
    team_id=$2
    profile_name=$3
    code_sign_identity=$4
    exportPList=$5

    fastlane run update_code_signing_settings use_automatic_signing:false path:"$EXAMPLE_PATH/ios/Runner.xcodeproj" bundle_identifier:"$bundle_identifier" team_id:"$team_id" profile_name:"$profile_name" code_sign_identity:"$code_sign_identity"

    flutter build ipa --dart-define TEST_APP_ID="$TEST_APP_ID" --dart-define TEST_TOEKN="$TEST_TOEKN" --dart-define TEST_CHANNEL_ID="$TEST_CHANNEL_ID" --export-options-plist $exportPList
    mkdir -p $EXAMPLE_PATH/build/internal_testing_artifacts/ios/$profile_name
    cp -r $EXAMPLE_PATH/build/ios/ipa/agora_rtc_engine_example.ipa "$EXAMPLE_PATH/build/internal_testing_artifacts/ios/${profile_name}/agora_rtc_engine_example.ipa"
    cp -r $EXAMPLE_PATH/build/ios/archive/Runner.xcarchive/dSYMs "$EXAMPLE_PATH/build/internal_testing_artifacts/ios/${profile_name}"
}

cd ios

build_ios "io.agora.agoraRtcEngineExampleTest" "$TEAM_TEST" "AgoraTest2020" "$CODE_SIGN_IDENTIRY_TEST" $ROOT_PATH/scripts/exportPlistTest.plist

build_ios "io.agora.agoraRtcEngineExampleLab" "$TEAM_LAB" "AgoraLab2020" "$CODE_SIGN_IDENTIRY_LAB" $ROOT_PATH/scripts/exportPlistLab.plist

build_ios "io.agora.agoraRtcEngineExampleQA" "$TEAM_QA" "AgoraQA2021" "$CODE_SIGN_IDENTIRY_QA" $ROOT_PATH/scripts/exportPlistQA.plist