#!/usr/bin/env bash

set -e

flutter packages get

cd integration_test_app
flutter packages get

flutter test integration_test/agora_rtc_channel_api_test.dart
flutter test integration_test/agora_rtc_channel_event_handler_api_test.dart
flutter test integration_test/agora_rtc_engine_api_test.dart
flutter test integration_test/agora_rtc_engine_event_handler_api_test.dart
# TODO(littlegnal): Temporary disable somke test for iOS/macOS, because it is not stable 
# to run somke test on CI at this time
# flutter test integration_test/agora_rtc_channel_event_handler_smoke_test.dart
# flutter test integration_test/agora_rtc_engine_event_handler_smoke_test.dart