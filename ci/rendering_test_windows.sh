#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/rendering_test

flutter packages get

# Build the Windows app first to ensure all dependencies are ready
echo "Building Windows application..."
flutter build windows --debug

# Verify the build succeeded
# Flutter 3.16+ uses build/windows/x64/runner/Debug/
# Flutter < 3.16 uses build/windows/runner/Debug/
WINDOWS_BUILD_DIR=""
if [ -f "build/windows/x64/runner/Debug/rendering_test.exe" ]; then
    WINDOWS_BUILD_DIR="build/windows/x64/runner/Debug"
elif [ -f "build/windows/runner/Debug/rendering_test.exe" ]; then
    WINDOWS_BUILD_DIR="build/windows/runner/Debug"
else
    echo "Error: Windows app build failed - executable not found"
    find build/windows -name "*.exe" 2>/dev/null || echo "No .exe files found"
    exit 1
fi

echo "Found Windows build at: $WINDOWS_BUILD_DIR"

# FIX for DLL Hell: Copy system VCRUNTIME to app directory to force loading of correct version
echo "Copying system runtime DLLs to avoid DLL Hell..."
if [ -f "/c/Windows/System32/vcruntime140.dll" ]; then
    cp "/c/Windows/System32/vcruntime140.dll" "$WINDOWS_BUILD_DIR/"
    echo "Copied vcruntime140.dll from System32"
fi
if [ -f "/c/Windows/System32/msvcp140.dll" ]; then
    cp "/c/Windows/System32/msvcp140.dll" "$WINDOWS_BUILD_DIR/"
    echo "Copied msvcp140.dll from System32"
fi

flutter test integration_test/agora_video_view_render_test.dart --dart-define=TEST_APP_ID="${TEST_APP_ID}" -d windows

popd