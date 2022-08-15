#!/usr/bin/env bash

set -e
set -x

pushd test_shard/destroy_irisengine_smoke_test
flutter packages get
flutter build ios --no-codesign --simulator --debug
popd

pushd test_shard/destroy_irisengine_smoke_test/ios

bundle install
bundle exec fastlane tests --verbose

popd
    