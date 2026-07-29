#!/usr/bin/env bash

set -euo pipefail

IRIS_SDK_URL="https://download.agora.io/sdk/release/iris_4.6.70.122-dev.1_DCG_OHOS_Video_20260729_1027_76.zip"
IRIS_SDK_SHA256="8023a8a4fdfc8b467f031c4a7ebe0aed0d4291f84da46b1aaff43be4f267122d"

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
HAR_DIR="${SCRIPT_DIR}/har"
RTC_HAR="${HAR_DIR}/AgoraRtcSdk.har"
WRAPPER_HAR="${HAR_DIR}/AgoraRtcWrapper.har"
LOCK_DIR="${HAR_DIR}/.preinstall.lock"
TMP_DIR=""
STAGING_DIR=""
LOCK_HELD=0
PUBLISH_STARTED=0
PUBLISH_COMPLETE=0
RTC_EXISTED=0
WRAPPER_EXISTED=0

cleanup() {
  local status=$?
  trap - EXIT

  if [[ "${PUBLISH_STARTED}" == "1" && "${PUBLISH_COMPLETE}" != "1" ]]; then
    if [[ "${RTC_EXISTED}" == "1" ]]; then
      mv -f "${STAGING_DIR}/backup/AgoraRtcSdk.har" "${RTC_HAR}" || true
    else
      rm -f "${RTC_HAR}"
    fi
    if [[ "${WRAPPER_EXISTED}" == "1" ]]; then
      mv -f "${STAGING_DIR}/backup/AgoraRtcWrapper.har" "${WRAPPER_HAR}" || true
    else
      rm -f "${WRAPPER_HAR}"
    fi
  fi

  [[ -n "${STAGING_DIR}" ]] && rm -rf "${STAGING_DIR}"
  [[ -n "${TMP_DIR}" ]] && rm -rf "${TMP_DIR}"
  [[ "${LOCK_HELD}" == "1" ]] && rmdir "${LOCK_DIR}" 2>/dev/null || true
  exit "${status}"
}

calculate_sha256() {
  if command -v shasum >/dev/null 2>&1; then
    LC_ALL=C LANG=C shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    LC_ALL=C LANG=C sha256sum "$1" | awk '{print $1}'
  else
    echo "Neither shasum nor sha256sum is available" >&2
    return 1
  fi
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

mkdir -p "${HAR_DIR}"
if ! mkdir "${LOCK_DIR}" 2>/dev/null; then
  echo "Another OHOS HAR installation is already running" >&2
  exit 1
fi
LOCK_HELD=1

TMP_ROOT="${SCRIPT_DIR}/tmp"
mkdir -p "${TMP_ROOT}"
TMP_DIR=$(mktemp -d "${TMP_ROOT}/preinstall.XXXXXX")

ARCHIVE_PATH="${TMP_DIR}/iris-ohos.zip"
curl --fail --location --retry 3 --output "${ARCHIVE_PATH}" "${IRIS_SDK_URL}"

ACTUAL_SHA256=$(calculate_sha256 "${ARCHIVE_PATH}")
if [[ "${ACTUAL_SHA256}" != "${IRIS_SDK_SHA256}" ]]; then
  echo "Iris OHOS archive SHA256 mismatch" >&2
  exit 1
fi

unzip -q "${ARCHIVE_PATH}" -d "${TMP_DIR}/sdk"

WRAPPER_COUNT=$(find "${TMP_DIR}/sdk" -type f -name 'AgoraRtcWrapper.har' | wc -l | tr -d '[:space:]')
RTC_COUNT=$(find "${TMP_DIR}/sdk" -type f -name 'AgoraRtcSdk*.har' | wc -l | tr -d '[:space:]')

if [[ "${WRAPPER_COUNT}" != "1" || "${RTC_COUNT}" != "1" ]]; then
  echo "The Iris OHOS archive must contain exactly one wrapper HAR and one RTC HAR" >&2
  exit 1
fi

WRAPPER_SOURCE=$(find "${TMP_DIR}/sdk" -type f -name 'AgoraRtcWrapper.har' -print -quit)
RTC_SOURCE=$(find "${TMP_DIR}/sdk" -type f -name 'AgoraRtcSdk*.har' -print -quit)

if [[ ! -s "${WRAPPER_SOURCE}" || ! -s "${RTC_SOURCE}" ]]; then
  echo "The Iris OHOS archive contains an empty HAR file" >&2
  exit 1
fi

STAGING_DIR=$(mktemp -d "${HAR_DIR}/.preinstall-stage.XXXXXX")
mkdir -p "${STAGING_DIR}/backup"
cp "${WRAPPER_SOURCE}" "${STAGING_DIR}/AgoraRtcWrapper.har"
cp "${RTC_SOURCE}" "${STAGING_DIR}/AgoraRtcSdk.har"

if [[ -e "${WRAPPER_HAR}" ]]; then
  cp "${WRAPPER_HAR}" "${STAGING_DIR}/backup/AgoraRtcWrapper.har"
  WRAPPER_EXISTED=1
fi
if [[ -e "${RTC_HAR}" ]]; then
  cp "${RTC_HAR}" "${STAGING_DIR}/backup/AgoraRtcSdk.har"
  RTC_EXISTED=1
fi

PUBLISH_STARTED=1
mv "${STAGING_DIR}/AgoraRtcWrapper.har" "${WRAPPER_HAR}"
mv "${STAGING_DIR}/AgoraRtcSdk.har" "${RTC_HAR}"
PUBLISH_COMPLETE=1

echo "Installed OHOS HAR dependencies into ${HAR_DIR}"
