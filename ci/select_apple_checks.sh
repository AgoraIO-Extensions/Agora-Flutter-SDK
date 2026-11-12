#!/usr/bin/env bash
set -euo pipefail

MY_PATH=$(cd "$(dirname "$0")" && pwd)
if [[ "${FULL_COMPATIBILITY:-false}" = true || -z "${BASE_SHA:-}" || -z "${HEAD_SHA:-}" ]]; then
    echo "apple_packages=true" >> "$GITHUB_OUTPUT"
elif git fetch --no-tags --depth=1 origin "$BASE_SHA" "$HEAD_SHA" &&
     git diff --no-renames --name-only -z "$BASE_SHA" "$HEAD_SHA" > "$RUNNER_TEMP/ci-changed-files"; then
    python3 "${MY_PATH}/check_apple_changes.py" < "$RUNNER_TEMP/ci-changed-files" >> "$GITHUB_OUTPUT"
    rm "$RUNNER_TEMP/ci-changed-files"
else
    echo "::warning::Changed files unavailable; running Apple packaging checks."
    echo "apple_packages=true" >> "$GITHUB_OUTPUT"
fi
