#!/usr/bin/env bash
set -e
set -x

if ! dart format --output=none --set-exit-if-changed .; then
  echo "The code style of files above are incorrect."
  echo "Make sure you follow the dart code style (https://github.com/dart-lang/dart_style)."
  exit 1
fi