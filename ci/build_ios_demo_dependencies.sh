#!/usr/bin/env bash

# Run from example/. Only the final SwiftPM build is archived into the QA IPA.
set -euo pipefail

test -f pubspec.yaml
test -f ios/Podfile
plugin_name=$(ruby -ryaml -e 'puts YAML.load_file(ARGV.fetch(0)).fetch("name")' ../pubspec.yaml)

for manager in cocoapods swiftpm; do
  echo "=== iOS Demo dependency check: $manager ==="
  if [ "$manager" = cocoapods ]; then
    flutter config --no-enable-swift-package-manager
  else
    flutter config --enable-swift-package-manager
  fi

  flutter clean
  if [ -f ios/Podfile.lock ]; then
    (cd ios && pod deintegrate)
  fi
  rm -rf ios/Pods
  rm -f ios/Podfile.lock
  flutter pub get
  flutter build ios --release --no-codesign "$@"

  for plugin in "$plugin_name" iris_method_channel; do
    if [ "$manager" = cocoapods ]; then
      grep -Fq "  - $plugin (" ios/Podfile.lock || {
        echo "::error::$plugin is not integrated through CocoaPods"
        exit 1
      }
    else
      package_swift=ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage/Package.swift
      grep -Fq ".package(name: \"$plugin\"," "$package_swift" || {
        echo "::error::$plugin is not integrated through SwiftPM"
        exit 1
      }
      if [ -f ios/Podfile.lock ] && grep -Fq "  - $plugin (" ios/Podfile.lock; then
        echo "::error::$plugin unexpectedly fell back to CocoaPods"
        exit 1
      fi
    fi
  done

  echo "iOS Demo $manager dependency check passed"
  if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
    echo "- iOS Demo $manager dependency check passed" >> "$GITHUB_STEP_SUMMARY"
  fi
done
