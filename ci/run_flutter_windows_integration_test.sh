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
if [ ! -f "build/windows/x64/runner/Debug/integration_test_app.exe" ]; then
    echo "Error: Windows app build failed - executable not found"
    exit 1
fi

# Give Windows a moment to settle after build
sleep 5

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