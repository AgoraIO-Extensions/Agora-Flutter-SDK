#!/usr/bin/env bash
set -euo pipefail

MY_PATH=$(cd "$(dirname "$0")" && pwd)
platform=${1:?android, ios, macos or windows required}
target=integration_test/smoke/sdk_startup_test.dart
case "$platform" in
  ios)
    exec bash "$MY_PATH/run_flutter_integration_test_ios.sh" "$target"
    ;;
  android|macos|windows) ;;
  *) echo "Unsupported smoke platform: $platform" >&2; exit 2 ;;
esac

cd "$MY_PATH/../test_shard/integration_test_app"
flutter pub get
arguments=("$target" --dart-define=TEST_APP_ID="${TEST_APP_ID}" --timeout=10m --verbose)
if [[ "$platform" = windows ]]; then
    flutter build windows --debug
    app_dir=build/windows/x64/runner/Debug
    test -f "$app_dir/integration_test_app.exe"
    # Preserve the known Windows runtime workaround used by the full API suite.
    for runtime in vcruntime140.dll msvcp140.dll; do
        if [[ -f "/c/Windows/System32/$runtime" ]]; then
            cp "/c/Windows/System32/$runtime" "$app_dir/"
        fi
    done
fi
if [[ "$platform" = macos || "$platform" = windows ]]; then
    arguments+=(-d "$platform")
fi
flutter test "${arguments[@]}"
