#!/usr/bin/env bash

set -e

cd example/ios

pod install

bundle install
bundle exec fastlane tests
    