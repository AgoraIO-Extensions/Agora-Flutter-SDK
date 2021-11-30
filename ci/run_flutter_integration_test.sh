#!/usr/bin/env bash

set -e

flutter packages get

cd integration_test_app
flutter packages get
flutter test integration_test