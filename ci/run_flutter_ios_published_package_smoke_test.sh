#!/usr/bin/env bash

set -euo pipefail
set -x

MY_PATH=$(cd "$(dirname "$0")" && pwd)
REPO_ROOT=$(cd "${MY_PATH}/.." && pwd)

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

WORK_DIR=$(mktemp -d)
PACKAGE_DIR="${WORK_DIR}/agora_rtc_engine_published"
APP_DIR="${WORK_DIR}/agora_pub_consumer_ios_smoke"

cleanup() {
  rm -rf "${WORK_DIR}"
}
trap cleanup EXIT

mkdir -p "${PACKAGE_DIR}"

# Copy only tracked files while dereferencing tracked symlinks so the layout
# matches the published artifact instead of the source worktree.
git -C "${REPO_ROOT}" ls-files -z | \
  rsync -aL --from0 --files-from=- "${REPO_ROOT}/" "${PACKAGE_DIR}/"

flutter create --platforms=ios --org io.agora.smoke "${APP_DIR}"

ruby -e '
  path = ARGV[0]
  plugin_path = ARGV[1]
  marker = "cupertino_icons: ^1.0.8"
  replacement = "#{marker}\n  agora_rtc_engine:\n    path: #{plugin_path}"
  content = File.read(path)
  abort("failed to patch pubspec.yaml") unless content.include?(marker)
  File.write(path, content.sub(marker, replacement))
' "${APP_DIR}/pubspec.yaml" "${PACKAGE_DIR}"

pushd "${APP_DIR}"
flutter pub get
flutter build ios --simulator --no-codesign
popd
