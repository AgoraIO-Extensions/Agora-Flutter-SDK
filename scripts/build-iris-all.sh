#!/usr/bin/env bash

set -e

bash scripts/build-iris-android.sh
bash scripts/build-iris-ios.sh
bash scripts/build-iris-macos.sh