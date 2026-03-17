#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

pushd ${MY_PATH}/../test_shard/integration_test_app

flutter packages get

# Build the Windows app first to ensure all dependencies are ready
echo "Building Windows application..."
flutter build windows --debug

# Verify the build succeeded
# Flutter 3.16+ uses build/windows/x64/runner/Debug/
# Flutter < 3.16 uses build/windows/runner/Debug/
WINDOWS_BUILD_DIR=""
if [ -f "build/windows/x64/runner/Debug/integration_test_app.exe" ]; then
    WINDOWS_BUILD_DIR="build/windows/x64/runner/Debug"
elif [ -f "build/windows/runner/Debug/integration_test_app.exe" ]; then
    WINDOWS_BUILD_DIR="build/windows/runner/Debug"
else
    echo "Error: Windows app build failed - executable not found"
    echo "Checked paths:"
    echo "  - build/windows/x64/runner/Debug/integration_test_app.exe"
    echo "  - build/windows/runner/Debug/integration_test_app.exe"
    echo ""
    echo "Listing build/windows directory structure:"
    find build/windows -name "*.exe" 2>/dev/null || echo "No .exe files found"
    exit 1
fi

echo "Found Windows build at: $WINDOWS_BUILD_DIR"

# FIX for DLL Hell: Copy system VCRUNTIME to app directory to force loading of correct version
# This avoids loading incompatible versions from other tools in PATH (e.g. Mercurial)
echo "Copying system runtime DLLs to avoid DLL Hell..."
if [ -f "/c/Windows/System32/vcruntime140.dll" ]; then
    cp "/c/Windows/System32/vcruntime140.dll" "$WINDOWS_BUILD_DIR/"
    echo "Copied vcruntime140.dll from System32"
fi
if [ -f "/c/Windows/System32/msvcp140.dll" ]; then
    cp "/c/Windows/System32/msvcp140.dll" "$WINDOWS_BUILD_DIR/"
    echo "Copied msvcp140.dll from System32"
fi

# List all DLL dependencies to verify they're present
echo "Checking DLL dependencies..."
ls -la ${WINDOWS_BUILD_DIR}/*.dll 2>/dev/null || echo "Warning: No DLLs found in Debug folder"

# Check if Visual C++ Runtime is available
echo "Checking system dependencies..."
where vcruntime140.dll 2>/dev/null || echo "Warning: vcruntime140.dll not in PATH"

# Give Windows a moment to settle after build
sleep 5

# Try to run a simple test first to verify the app can start
echo "Testing if app can start with a simple test..."
flutter test integration_test/apis_call_integration_test.dart \
    --dart-define=TEST_APP_ID="${TEST_APP_ID}" \
    -d windows \
    --verbose \
    --timeout=2m || {
    echo "Warning: Initial test failed, but continuing with full test suite..."
    echo "This failure might indicate environment issues."
}

sleep 3

# It's a little tricky that you should run integration test one by one on flutter macOS/Windows
for filename in integration_test/*.dart; do
    if [[ "$filename" == *.generated.dart  ]]; then
        continue
    fi
    
    echo "Running test: $filename"
    
    # Add timeout and retry mechanism for Windows tests
    # Windows app startup can be slower and may need retries
    MAX_RETRIES=3
    RETRY_COUNT=0
    
    until [ $RETRY_COUNT -ge $MAX_RETRIES ]
    do
        # Add verbose flag and increase timeout
        flutter test $filename \
            --dart-define=TEST_APP_ID="${TEST_APP_ID}" \
            -d windows \
            --verbose \
            --timeout=10m && break
        
        RETRY_COUNT=$((RETRY_COUNT+1))
        if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
            echo "Test failed, retrying ($RETRY_COUNT/$MAX_RETRIES)..."
            
            # Try to capture Windows Event Log errors (last 5 application errors)
            echo "Checking for recent application errors..."
            powershell.exe -Command "Get-EventLog -LogName Application -EntryType Error -Newest 5 -After (Get-Date).AddMinutes(-5) | Select-Object TimeGenerated, Source, Message | Format-List" 2>/dev/null || true
            
            # Clean up any stuck processes
            taskkill //F //IM integration_test_app.exe //T 2>/dev/null || true
            sleep 10
        else
            echo "Test failed after $MAX_RETRIES attempts"
            popd
            exit 1
        fi
    done
done

popd