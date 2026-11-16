#!/bin/bash

set -euo pipefail

version=$(ruby -ryaml -e '
  version = YAML.safe_load(File.read("pubspec.yaml")).fetch("version")
  abort "pubspec.yaml must declare a nonempty version string" unless version.is_a?(String) && !version.empty?
  puts version
')

# Match release.yml: only MAJOR.MINOR.PATCH publishes to pub.dev by default.
# Explicit forced publication still runs its own checks in the release workflow.
if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Skipping pub.dev publication check for tag-only version $version"
  exit 0
fi

# The log of `dart pub publish`` will be written into `${PUB_CACHE}/log/pub_log.txt`
# Run publish dry run and capture exit code
if ! dart pub publish --dry-run; then
  echo "Publication check failed!"
  exit 1
fi

exit 0
