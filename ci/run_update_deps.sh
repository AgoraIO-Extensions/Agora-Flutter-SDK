#!/bin/bash

set -euo pipefail
export LC_ALL=C

# get current directory
current_dir=$(pwd)
echo "current_dir=${current_dir}"

# const variables
dep_file_ios=ios/agora_rtc_engine.podspec
dep_file_macos=macos/agora_rtc_engine.podspec
dep_file_android=android/build.gradle
dep_file_windows=windows/CMakeLists.txt
dep_file_windows_integration=integration_test_app/iris_integration_test/CMakeLists.txt

# get parsed dependencies content from argument 1, the format is as follows:
# [
#     {
#         "iris_cdn": [
#             "https://download.agora.io/sdk/release/iris_4.5.0-gxz.119_DCG_Mac_Video_Unity_20250217_0847_579.zip",
#             "https://download.agora.io/sdk/release/iris_4.5.0-gxz.119_DCG_Mac_Video_Standalone_20250217_0847_579.zip",
#             "https://download.agora.io/sdk/release/iris_4.5.0-gxz.119_DCG_Mac_Video_20250217_0847_579.zip"
#         ],
#         "cdn": [
#             "https://download.agora.io/sdk/release/AgoraRtcEngine_macOS_Preview_4.5.0-gxz.119.zip"
#         ],
#         "iris_cocoapods": [
#             "pod 'AgoraIrisRTC_macOS', '4.5.0-gxz.119'"
#         ],
#         "iris_maven": [
#             "implementation 'io.agora.rtc:iris-rtc:4.5.0-gxz.119'"
#         ],
#         "maven": [
#             "implementation 'io.agora.rtc:agora-full-preview:4.5.0-gxz.119'",
#             "implementation 'io.agora.rtc:full-screen-sharing-special:4.5.0-gxz.119'"
#         ],
#         "platform": "macOS", // iOS, macOS, Android, Windows, Web
#         "cocoapods": [
#             "pod 'AgoraRtcEngine_macOS_Preview', '4.5.0-gxz.119'"
#         ]
#     },
# ]
dependencies_content=$(printf '%s' "$1" | jq -c '
    if type == "string" then fromjson else . end
    | if type == "array" then . else error("dependencies content must be a JSON array") end
  ')


# function to update podspec file
function update_podspec_file() {
    local dep_file=$1
    local dep_item=$2

    # Handle iris dependencies
    iris_cocoapods=$(echo "${dep_item}" | jq -r '.iris_cocoapods[]')
    if [ "${iris_cocoapods}" != "" ]; then
        # replace 'pod' with 's.dependency'
        iris_deps=$(echo "${iris_cocoapods}" | sed 's/pod/s.dependency/g')
        # Add indentation
        iris_deps=$(echo "${iris_deps}" | sed 's/^/    /')

        perl -0777 -pe "s/# iris dependencies start.*# iris dependencies end/# iris dependencies start\n${iris_deps}\n    # iris dependencies end/ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
    fi

    # Handle native dependencies
    cocoapods=$(echo "${dep_item}" | jq -r '.cocoapods[]')
    if [ "${cocoapods}" != "" ]; then
        # replace 'pod' with 's.dependency'
        native_deps=$(echo "${cocoapods}" | sed 's/pod/s.dependency/g')
        # Add indentation
        native_deps=$(echo "${native_deps}" | sed 's/^/    /')

        perl -0777 -pe "s/# native dependencies start.*# native dependencies end/# native dependencies start\n${native_deps}\n    # native dependencies end/ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
    fi
}

# function to update gradle file
function update_gradle_file() {
    local dep_file=$1
    local dep_item=$2

    # Handle iris dependencies
    iris_maven=$(echo "${dep_item}" | jq -r '.iris_maven[]')
    if [ "${iris_maven}" != "" ]; then
        # replace 'implementation' with 'api'
        iris_deps=$(echo "${iris_maven}" | sed 's/implementation/api/g')
        # Add indentation
        iris_deps=$(echo "${iris_deps}" | sed 's/^/    /')

        perl -0777 -pe "s/    \/\/ iris dependencies start.*    \/\/ iris dependencies end/    \/\/ iris dependencies start\n${iris_deps}\n    \/\/ iris dependencies end/ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
    fi

    # Handle native dependencies
    maven=$(echo "${dep_item}" | jq -r '.maven[]')
    if [ "${maven}" != "" ]; then
        # replace 'implementation' with 'api'
        native_deps=$(echo "${maven}" | sed 's/implementation/api/g')
        # Add indentation
        native_deps=$(echo "${native_deps}" | sed 's/^/    /')

        perl -0777 -pe "s/    \/\/ native dependencies start.*    \/\/ native dependencies end/    \/\/ native dependencies start\n${native_deps}\n    \/\/ native dependencies end/ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
    fi
}

# function to update cmake file
function update_cmake_file() {
    local dep_file=$1
    local integration_dep_file=$2
    local dep_item=$3

    # Legacy Windows packages use the combined Iris archive, which also
    # contains the Native RTC SDK. Keep the archive URL and root name aligned.
    iris_cdn=$(echo "${dep_item}" | jq -r '.iris_cdn[] | select((contains("Standalone") | not) and (contains("Unity") | not))' | head -n1)
    if [ -n "${iris_cdn}" ] && [ "${iris_cdn}" != "null" ]; then
        escaped_iris_cdn=$(printf '%s\n' "${iris_cdn}" | sed 's/[\/&]/\\&/g')
        iris_archive_name=$(basename "${iris_cdn}" .zip)
        case "${iris_archive_name}" in
          *_RTC_Windows_Video_*)
            iris_extract_root_name=${iris_archive_name/_RTC_Windows_Video_/_RTC_Windows_}
            ;;
          *)
            echo "Unsupported legacy Windows Iris archive: ${iris_archive_name}" >&2
            return 1
            ;;
        esac

        iris_content="set(IRIS_SDK_DOWNLOAD_SDK_BY_URL \"${escaped_iris_cdn}\")
set(IRIS_SDK_DOWNLOAD_NAME \"${iris_extract_root_name}\")"
        integration_iris_content="set(IRIS_SDK_DOWNLOAD_NAME \"${iris_extract_root_name}\")"

        perl -0777 -pe "s~# iris dependencies start.*# iris dependencies end~# iris dependencies start\n${iris_content}\n# iris dependencies end~ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"

        perl -0777 -pe "s~# iris dependencies start.*# iris dependencies end~# iris dependencies start\n${integration_iris_content}\n    # iris dependencies end~ms" "${integration_dep_file}" > "${integration_dep_file}.tmp"
        mv "${integration_dep_file}.tmp" "${integration_dep_file}"
    fi
}


echo "${dependencies_content}" | jq -c '.[]' | while read -r dep_item; do
    # get platform from dep_item
    platform=$(echo "${dep_item}" | jq -r '.platform')

    # update dependencies file by platform
    if [ "${platform}" == "iOS" ]; then
        update_podspec_file "${dep_file_ios}" "${dep_item}"
    elif [ "${platform}" == "macOS" ]; then
        update_podspec_file "${dep_file_macos}" "${dep_item}"
    elif [ "${platform}" == "Android" ]; then
        update_gradle_file "${dep_file_android}" "${dep_item}"
    elif [ "${platform}" == "Windows" ]; then
        update_cmake_file "${dep_file_windows}" "${dep_file_windows_integration}" "${dep_item}"
    fi
done
