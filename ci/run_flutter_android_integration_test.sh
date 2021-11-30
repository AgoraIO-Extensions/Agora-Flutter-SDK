#!/usr/bin/env bash

set -e
echo $ANDROID_NDK
sdkmanager --list --channel=0

flutter packages get

cd integration_test_app
flutter packages get
flutter test integration_test