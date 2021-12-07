#!/usr/bin/env bash

set -e

flutter packages get

cd integration_test_app
flutter packages get

# It's a little tricky that you should run integration test one by one on flutter macOS
for filename in integration_test/*.dart; do
    flutter test $filename
done

# flutter test integration_test/agora_rtc_channel_api_test.dart
# flutter test integration_test/agora_rtc_channel_event_handler_api_test.dart
# flutter test integration_test/agora_rtc_engine_api_test.dart
# flutter test integration_test/agora_rtc_engine_event_handler_api_test.dart
# flutter test integration_test/agora_rtc_channel_event_handler_smoke_test.dart
# flutter test integration_test/agora_rtc_engine_event_handler_smoke_test.dart