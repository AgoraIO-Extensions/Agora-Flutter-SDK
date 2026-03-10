#!/bin/bash

set -e

old_pkg="agora_rtc_engine"
new_pkg="shengwang_rtc_engine"

old_pkg_example="${old_pkg}_example"
new_pkg_example="${new_pkg}_example"

old_repo_org="AgoraIO-Extensions"
new_repo_org="shengwang-extensions"

old_repo_name="Agora-Flutter-SDK"
new_repo_name="Shengwang-Flutter-SDK"

old_description="Flutter plugin of Agora RTC SDK, allow you to simply integrate Agora"
new_description="Flutter plugin of Shengwang RTC SDK, allow you to simply integrate Shengwang"

old_link="www.agora.io"
new_link="www.shengwang.cn"

old_bundle_prefix="io.agora"
new_bundle_prefix="io.agora"

old_android_bundle="io.agora.agora_rtc_ng_example"
new_android_bundle="io.agora.shengwang_rtc_ng_example"

old_android_kt_pkg="io.agora.agora_rtc_flutter_example"
new_android_kt_pkg="io.agora.shengwang_rtc_flutter_example"

old_docs_zip="agora_rtc_engine_docs"
new_docs_zip="shengwang_rtc_engine_docs"
old_docs_zip2="agora_rtc_docs"
new_docs_zip2="shengwang_rtc_docs"

MY_PATH=$(realpath "$(dirname "$0")")
ROOT=$(realpath "${MY_PATH}/..")

replace_in_file() {
  local file="$1"; shift
  for expr in "$@"; do
    sed -i '' "$expr" "$file"
  done
}

replace_in_dir() {
  local dir="$1"
  local pattern="$2"
  local old="$3"
  local new="$4"
  find "$dir" -type f -name "$pattern" \
    ! -path "*/.dart_tool/*" \
    ! -path "*/build/*" | while read -r file; do
    if grep -q "$old" "$file" 2>/dev/null; then
      sed -i '' "s|${old}|${new}|g" "$file"
    fi
  done
}

echo "Updating root pubspec.yaml"
f="${ROOT}/pubspec.yaml"
replace_in_file "$f" \
  "s|name: ${old_pkg}|name: ${new_pkg}|g" \
  "s|${old_repo_org}/${old_repo_name}|${new_repo_org}/${new_repo_name}|g" \
  "s|${old_description}|${new_description}|g" \
  "s|${old_link}|${new_link}|g"

echo "Updating lib/ package references"
replace_in_dir "${ROOT}/lib" "*.dart" "package:${old_pkg}/" "package:${new_pkg}/"

echo "Renaming podspec files and updating s.name"
for platform in ios macos; do
  old_spec="${ROOT}/${platform}/${old_pkg}.podspec"
  new_spec="${ROOT}/${platform}/${new_pkg}.podspec"
  if [ -f "$old_spec" ]; then
    mv "$old_spec" "$new_spec"
  fi
done

for platform in ios macos; do
  spec="${ROOT}/${platform}/${new_pkg}.podspec"
  if [ -f "$spec" ]; then
    if grep -qE "s\.name\s*=\s*'${old_pkg}'" "$spec"; then
      sed -i '' "s|s\.name *= *'${old_pkg}'|s.name             = '${new_pkg}'|g" "$spec"
    fi
  fi
done

echo "Updating test/ package references"
replace_in_dir "${ROOT}/test" "*.dart" "package:${old_pkg}/" "package:${new_pkg}/"

echo "Updating example/ pubspec.yaml"
f="${ROOT}/example/pubspec.yaml"
replace_in_file "$f" \
  "s|name: ${old_pkg_example}|name: ${new_pkg_example}|g" \
  "s|  ${old_pkg}:|  ${new_pkg}:|g" \
  "s|the ${old_pkg} plugin|the ${new_pkg} plugin|g"

echo "Updating example/lib/ package references"
replace_in_dir "${ROOT}/example/lib" "*.dart" "package:${old_pkg}/" "package:${new_pkg}/"
replace_in_dir "${ROOT}/example/lib" "*.dart" "package:${old_pkg_example}/" "package:${new_pkg_example}/"

echo "Updating example/test/ package references"
replace_in_dir "${ROOT}/example/test" "*.dart" "package:${old_pkg_example}/" "package:${new_pkg_example}/"

echo "Updating example/ios bundle IDs"
f="${ROOT}/example/ios/Runner/Info.plist"
[ -f "$f" ] && replace_in_file "$f" \
  "s|${old_pkg_example}|${new_pkg_example}|g" \
  "s|Agora Rtc Engine|Shengwang Rtc Engine|g"

f="${ROOT}/example/ios/export.plist"
[ -f "$f" ] && replace_in_file "$f" \
  "s|${old_bundle_prefix}\.agoraRtcEngineExample|${new_bundle_prefix}.shengwangRtcEngineExample|g" \
  "s|${old_bundle_prefix}\.|${new_bundle_prefix}.|g" \
  "s|${new_bundle_prefix}\.agoraRtcEngineExample|${new_bundle_prefix}.shengwangRtcEngineExample|g"

f="${ROOT}/example/ios/Runner.xcodeproj/project.pbxproj"
[ -f "$f" ] && replace_in_file "$f" \
  "s|${old_bundle_prefix}\.agoraRtcEngineExample|${new_bundle_prefix}.shengwangRtcEngineExample|g"
f="${ROOT}/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme"
[ -f "$f" ] && replace_in_file "$f" \
  "s|${old_bundle_prefix}\.|${new_bundle_prefix}.|g"

echo "Updating example/macos bundle IDs"
f="${ROOT}/example/macos/Runner/Configs/AppInfo.xcconfig"
[ -f "$f" ] && replace_in_file "$f" \
  "s|PRODUCT_NAME = ${old_pkg_example}|PRODUCT_NAME = ${new_pkg_example}|g" \
  "s|${old_bundle_prefix}\.|${new_bundle_prefix}.|g" \
  "s|Copyright © [0-9]* ${old_bundle_prefix}|Copyright © 2024 ${new_bundle_prefix}|g"

f="${ROOT}/example/macos/Runner.xcodeproj/project.pbxproj"
[ -f "$f" ] && replace_in_file "$f" \
  "s|${old_bundle_prefix}\.agoraRtcEngineExample|${new_bundle_prefix}.shengwangRtcEngineExample|g"

f="${ROOT}/example/macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme"
[ -f "$f" ] && replace_in_file "$f" \
  "s|${old_bundle_prefix}\.|${new_bundle_prefix}.|g"

echo "Updating example/android bundle IDs and Kotlin package names"
f="${ROOT}/example/android/app/build.gradle"
[ -f "$f" ] && replace_in_file "$f" \
  "s|${old_android_bundle}|${new_android_bundle}|g"

for manifest in \
  "${ROOT}/example/android/app/src/main/AndroidManifest.xml" \
  "${ROOT}/example/android/app/src/debug/AndroidManifest.xml" \
  "${ROOT}/example/android/app/src/profile/AndroidManifest.xml"
do
  [ -f "$manifest" ] && replace_in_file "$manifest" \
    "s|${old_android_bundle}|${new_android_bundle}|g"
done

replace_in_dir "${ROOT}/example/android" "*.kt" \
  "${old_android_kt_pkg}" "${new_android_kt_pkg}"
replace_in_dir "${ROOT}/example/android" "*.kt" \
  "${old_android_bundle}" "${new_android_bundle}"

echo "Updating example/windows CMakeLists and Runner.rc"
f="${ROOT}/example/windows/CMakeLists.txt"
[ -f "$f" ] && replace_in_file "$f" \
  "s|project(${old_pkg_example}|project(${new_pkg_example}|g" \
  "s|set(BINARY_NAME \"${old_pkg_example}\")|set(BINARY_NAME \"${new_pkg_example}\")|g"

f="${ROOT}/example/windows/runner/Runner.rc"
[ -f "$f" ] && replace_in_file "$f" \
  "s|\"io\.agora\"|\"cn.shengwang\"|g" \
  "s|io\.agora\. All rights reserved|cn.shengwang. All rights reserved|g"

echo "Updating SDK windows/CMakeLists.txt plugin target name"
f="${ROOT}/windows/CMakeLists.txt"
[ -f "$f" ] && replace_in_file "$f" \
  "s|set(PLUGIN_NAME \"${old_pkg}_plugin\")|set(PLUGIN_NAME \"${new_pkg}_plugin\")|g" \
  "s|set(${old_pkg}_bundled_libraries|set(${new_pkg}_bundled_libraries|g" \
  "s|set(PROJECT_NAME \"${old_pkg}\")|set(PROJECT_NAME \"${new_pkg}\")|g"

echo "Renaming Windows include directory: ${old_pkg} -> ${new_pkg}"
old_inc="${ROOT}/windows/include/${old_pkg}"
new_inc="${ROOT}/windows/include/${new_pkg}"
if [ -d "$old_inc" ]; then
  mv "$old_inc" "$new_inc"
fi

# C++ 源文件中 #include "include/agora_rtc_engine/..." 路径同步更新
for ext in cpp cc h mm; do
  replace_in_dir "${ROOT}/windows" "*.${ext}" \
    "include/${old_pkg}/" "include/${new_pkg}/"
done

echo "Updating test_shard/ pubspec and dart files"
find "${ROOT}/test_shard" -name "pubspec.yaml" | while read -r file; do
  if grep -q "${old_pkg}" "$file" 2>/dev/null; then
    sed -i '' "s|  ${old_pkg}:|  ${new_pkg}:|g" "$file"
  fi
done
replace_in_dir "${ROOT}/test_shard" "*.dart" "package:${old_pkg}/" "package:${new_pkg}/"

for pbxproj in $(find "${ROOT}/test_shard" -name "project.pbxproj" 2>/dev/null); do
  if grep -q "${old_bundle_prefix}" "$pbxproj" 2>/dev/null; then
    sed -i '' "s|${old_bundle_prefix}\.|${new_bundle_prefix}.|g" "$pbxproj"
  fi
done

echo "Updating tool/testcase_gen/ package references"
replace_in_dir "${ROOT}/tool/testcase_gen" "*.dart" "package:${old_pkg}/" "package:${new_pkg}/"

echo "Updating terra_config_main.yaml"
f="${ROOT}/tool/terra/terra_config_main.yaml"
[ -f "$f" ] && replace_in_file "$f" \
  "s|flutter_ng_json_template_en.json|flutter_ng_json_template_cn.json|g"

echo "Updating .github workflows"
replace_in_dir "${ROOT}/.github" "*.yml" "${old_pkg_example}" "${new_pkg_example}"
replace_in_dir "${ROOT}/.github" "*.yaml" "${old_pkg_example}" "${new_pkg_example}"
replace_in_dir "${ROOT}/.github" "*.yml" "${old_docs_zip}" "${new_docs_zip}"
replace_in_dir "${ROOT}/.github" "*.yml" "${old_docs_zip2}" "${new_docs_zip2}"

f="${ROOT}/.github/workflows/release.yml"
if [ -f "$f" ]; then
  replace_in_file "$f" \
    "s|${old_repo_org}/${old_repo_name}\.git|${new_repo_org}/${new_repo_name}.git|g" \
    "s|    ${old_pkg}: \^\\\$RELEASE_VERSION|    ${new_pkg}: ^\$RELEASE_VERSION|g" \
    "s|    ${old_pkg}:|    ${new_pkg}:|g"
fi

f="${ROOT}/.github/workflows/run_build_example.yml"
[ -f "$f" ] && replace_in_file "$f" \
  "s|${old_bundle_prefix}\.agoraRtcEngineExample|${new_bundle_prefix}.shengwangRtcEngineExample|g"

f="${ROOT}/.github/workflows/on_issue_labeled.yml"
if [ -f "$f" ]; then
  replace_in_file "$f" \
    "s|${old_repo_name}|${new_repo_name}|g"
fi

f="${ROOT}/.github/ISSUE_TEMPLATE/bug_report.yml"
if [ -f "$f" ]; then
  replace_in_file "$f" \
    "s|${old_repo_name}|${new_repo_name}|g" \
    "s|the ${old_pkg}|the ${new_pkg}|g"
fi
