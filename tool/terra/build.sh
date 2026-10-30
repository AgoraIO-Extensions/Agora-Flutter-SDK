#!/usr/bin/env bash
set -e
set -o pipefail
set -x

NEW_VERSION=$1
MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/../..)

TERRA_MAIN_FILE=${PROJECT_ROOT}/tool/terra/terra_config_main.yaml

if [ -n "$NEW_VERSION" ]; then
  # Check the operating system type
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' -E "s/rtc_[0-9]+\.[0-9]+(\.[0-9]+)*/${NEW_VERSION}/g" $TERRA_MAIN_FILE
  else
    # Linux and other Unix-like systems
    sed -i -E "s/rtc_[0-9]+\.[0-9]+(\.[0-9]+)*/${NEW_VERSION}/g" $TERRA_MAIN_FILE
  fi
  echo "Updated version to ${NEW_VERSION} in $TERRA_MAIN_FILE"
fi

bash ${MY_PATH}/prepare.sh
python3 "${MY_PATH}/stage_headers.py"
source "${MY_PATH}/toolchain.sh"

pushd ${MY_PATH}

# Terra can return zero after libclang reports parse errors. Never generate
# JSON serializers or test fixtures from a partially parsed header model.
terra_log=$(mktemp)
trap 'rm -f "$terra_log"; if [ -n "${terra_compiler_dir:-}" ]; then rm -f "$terra_compiler_dir/clang" "$terra_compiler_dir/clang++"; rmdir "$terra_compiler_dir"; fi' EXIT
if ! npm exec terra -- run \
    --config "${TERRA_MAIN_FILE}" \
    --output-dir="${PROJECT_ROOT}" 2>&1 | tee "$terra_log"; then
  exit 1
fi
if LC_ALL=C grep -Eq '\[libclang[^]]*\].*\[(error|fatal)\]|(^|[[:space:]])[1-9][0-9]* errors? generated\.' "$terra_log"; then
  echo "Terra reported C++ parser errors; generated output must not be used." >&2
  exit 1
fi

popd

pushd ${PROJECT_ROOT}

dart format .

popd