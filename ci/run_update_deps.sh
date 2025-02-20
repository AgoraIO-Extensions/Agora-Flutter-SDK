#!/bin/bash

# get current directory
current_dir=$(pwd)
echo "current_dir=${current_dir}"

# const variables
dep_file_ios=ios/agora_rtc_engine.podspec
dep_file_macos=macos/agora_rtc_engine.podspec
dep_file_android=android/build.gradle
dep_file_windows=windows/cmake/DownloadSDK.cmake

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
dependencies_content=$1


# function to update podspec file
function update_podspec_file() {
    local dep_file=$1
    local dep_item=$2
    
    # Handle iris dependencies
    iris_cocoapods=$(echo "${dep_item}" | jq -r '.iris_cocoapods[]')
    if [ "${iris_cocoapods}" != "" ]; then
        # replace 'pod' with 's.dependency' and remove quotes
        iris_deps=$(echo "${iris_cocoapods}" | sed 's/pod/s.dependency/g' | sed 's/"//g')
        # Add indentation
        iris_deps=$(echo "${iris_deps}" | sed 's/^/    /')
        
        perl -0777 -pe "s/# iris dependencies start.*# iris dependencies end/# iris dependencies start\n${iris_deps}\n    # iris dependencies end/ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
    fi
    
    # Handle native dependencies
    cocoapods=$(echo "${dep_item}" | jq -r '.cocoapods[]')
    if [ "${cocoapods}" != "" ]; then
        # replace 'pod' with 's.dependency' and remove quotes
        native_deps=$(echo "${cocoapods}" | sed 's/pod/s.dependency/g' | sed 's/"//g')
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
        # replace 'implementation' with 'api' and remove quotes
        iris_deps=$(echo "${iris_maven}" | sed 's/implementation/api/g' | sed 's/"//g')
        # Add indentation
        iris_deps=$(echo "${iris_deps}" | sed 's/^/    /')
        
        perl -0777 -pe "s/    \/\/ iris dependencies start.*    \/\/ iris dependencies end/    \/\/ iris dependencies start\n${iris_deps}\n    \/\/ iris dependencies end/ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
    fi
    
    # Handle native dependencies
    maven=$(echo "${dep_item}" | jq -r '.maven[]')
    if [ "${maven}" != "" ]; then
        # replace 'implementation' with 'api' and remove quotes
        native_deps=$(echo "${maven}" | sed 's/implementation/api/g' | sed 's/"//g')
        # Add indentation
        native_deps=$(echo "${native_deps}" | sed 's/^/    /')
        
        perl -0777 -pe "s/    \/\/ native dependencies start.*    \/\/ native dependencies end/    \/\/ native dependencies start\n${native_deps}\n    \/\/ native dependencies end/ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
    fi
}

# function to update cmake file
function update_cmake_file() {
    local dep_file=$1
    local dep_item=$2
    
    # Handle iris dependencies
    iris_cdn_standalone=$(echo "${dep_item}" | jq -r '.iris_cdn[] | select(. | contains("Standalone"))')
    if [ "${iris_cdn_standalone}" != "" ]; then
        escaped_iris_cdn=$(printf '%s\n' "$iris_cdn_standalone" | sed 's/[\/&]/\\&/g')
        iris_content="set(IRIS_SDK_DOWNLOAD_URL \"${escaped_iris_cdn}\")"
        
        perl -0777 -pe "s~# iris dependencies start.*# iris dependencies end~# iris dependencies start\n${iris_content}\n# iris dependencies end~ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
    fi
    
    # Handle native dependencies
    cdn=$(echo "${dep_item}" | jq -r '.cdn[0]')
    if [ "${cdn}" != "null" ]; then
        escaped_cdn=$(printf '%s\n' "$cdn" | sed 's/[\/&]/\\&/g')
        native_content="set(NATIVE_SDK_DOWNLOAD_URL \"${escaped_cdn}\")"
        
        perl -0777 -pe "s~# native dependencies start.*# native dependencies end~# native dependencies start\n${native_content}\n# native dependencies end~ms" "${dep_file}" > "${dep_file}.tmp"
        mv "${dep_file}.tmp" "${dep_file}"
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
        update_cmake_file "${dep_file_windows}" "${dep_item}"
    fi
done

