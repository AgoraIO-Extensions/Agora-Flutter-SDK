#!/usr/bin/env bash

set -e

flutter packages get

cd integration_test_app
flutter packages get

flutter test integration_test/agora_rtc_channel_api_test.dart
flutter test integration_test/agora_rtc_channel_event_handler_api_test.dart
flutter test integration_test/agora_rtc_engine_api_test.dart
flutter test integration_test/agora_rtc_engine_event_handler_api_test.dart