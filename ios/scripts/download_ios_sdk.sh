#!/usr/bin/env bash
#
# Download the Agora iOS native SDK and the Iris wrapper from the Agora CDN and
# vendor the xcframeworks into the plugin's `libs/` directory.
#
# The iOS integration no longer depends on the published
# `AgoraRtcEngine_Special_iOS` / `AgoraIrisRTC_iOS` CocoaPods pods. The podspec
# runs this script from `prepare_command`, so every `pod install` resolves the
# SDK straight from download.agora.io.
#
# Both archives only contain flat `.xcframework` bundles, so they can be
# extracted into the same directory and picked up by
# `s.vendored_frameworks = 'libs/*.xcframework'`.
#
# Usage:
#   bash scripts/download_ios_sdk.sh \
#     --native-url <url> --native-sha256 <sha256> \
#     --iris-url <url> --iris-sha256 <sha256> \
#     [--dest ./libs] [--force]
#
# Environment:
#   AGORA_IOS_SDK_CACHE  Cache directory for the downloaded archives.
#                        Defaults to ~/Library/Caches/agora-flutter-ios-sdk.

set -euo pipefail

usage() {
  sed -n '3,20p' "$0" | sed 's/^# \{0,1\}//'
  exit "${1:-0}"
}

NATIVE_URL=""
NATIVE_SHA256=""
IRIS_URL=""
IRIS_SHA256=""
DEST="./libs"
FORCE="false"

while [ $# -gt 0 ]; do
  case "$1" in
    --native-url) NATIVE_URL="${2:-}"; shift 2 ;;
    --native-sha256) NATIVE_SHA256="${2:-}"; shift 2 ;;
    --iris-url) IRIS_URL="${2:-}"; shift 2 ;;
    --iris-sha256) IRIS_SHA256="${2:-}"; shift 2 ;;
    --dest) DEST="${2:-}"; shift 2 ;;
    --force) FORCE="true"; shift ;;
    -h|--help) usage 0 ;;
    *) echo "error: unknown argument: $1" >&2; usage 1 ;;
  esac
done

for required in NATIVE_URL NATIVE_SHA256 IRIS_URL IRIS_SHA256; do
  if [ -z "${!required}" ]; then
    echo "error: --$(echo "$required" | tr 'A-Z_' 'a-z-') is required" >&2
    usage 1
  fi
done

CACHE_DIR="${AGORA_IOS_SDK_CACHE:-$HOME/Library/Caches/agora-flutter-ios-sdk}"
STAMP_FILE="$DEST/.agora-sdk.stamp"
EXPECTED_STAMP="native=${NATIVE_SHA256}
iris=${IRIS_SHA256}"

sha256_of() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    echo "error: neither shasum nor sha256sum is available" >&2
    return 1
  fi
}

fetch() {
  url="$1"
  expected_sha="$2"
  archive="$CACHE_DIR/$expected_sha.zip"

  if [ -f "$archive" ] && [ "$(sha256_of "$archive")" = "$expected_sha" ]; then
    echo "[agora-sdk] Using cached archive $archive" >&2
    printf '%s' "$archive"
    return 0
  fi

  mkdir -p "$CACHE_DIR"
  part="$archive.part.$$"
  rm -f "$part"
  echo "[agora-sdk] Downloading $url" >&2
  if command -v curl >/dev/null 2>&1; then
    curl -fL --retry 3 --retry-delay 2 --connect-timeout 30 -o "$part" "$url"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$part" "$url"
  else
    echo "error: neither curl nor wget is available" >&2
    return 1
  fi

  actual_sha="$(sha256_of "$part")"
  if [ "$actual_sha" != "$expected_sha" ]; then
    rm -f "$part"
    echo "error: checksum mismatch for $url" >&2
    echo "       expected: $expected_sha" >&2
    echo "       actual:   $actual_sha" >&2
    return 1
  fi
  mv "$part" "$archive"
  printf '%s' "$archive"
}

if [ "$FORCE" != "true" ] && [ -f "$STAMP_FILE" ] &&
   [ "$(cat "$STAMP_FILE")" = "$EXPECTED_STAMP" ] &&
   [ -d "$DEST/AgoraRtcKit.xcframework" ] &&
   [ -d "$DEST/AgoraRtcWrapper.xcframework" ]; then
  echo "[agora-sdk] $DEST is up to date"
  exit 0
fi

native_archive="$(fetch "$NATIVE_URL" "$NATIVE_SHA256")"
iris_archive="$(fetch "$IRIS_URL" "$IRIS_SHA256")"

work_dir="$DEST.tmp.$$"
rm -rf "$work_dir"
mkdir -p "$work_dir"

cleanup() { rm -rf "$work_dir"; }
trap cleanup EXIT

unzip -q -o "$native_archive" -d "$work_dir"
unzip -q -o "$iris_archive" -d "$work_dir"

for framework in AgoraRtcKit.xcframework AgoraRtcWrapper.xcframework; do
  if [ ! -d "$work_dir/$framework" ]; then
    echo "error: $framework is missing from the downloaded archives" >&2
    exit 1
  fi
done

printf '%s\n' "$EXPECTED_STAMP" > "$work_dir/.agora-sdk.stamp"

rm -rf "$DEST"
mv "$work_dir" "$DEST"
trap - EXIT

echo "[agora-sdk] Vendored Agora iOS SDK into $DEST"
