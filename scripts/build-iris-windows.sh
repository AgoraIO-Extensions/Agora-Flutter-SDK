#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
WINDOWS_PATH=$AGORA_FLUTTER_PROJECT_PATH/windows

DOWNLOAD_IRIS_URL=$1

cd $WINDOWS_PATH

mkdir -p iris_windows

curl -u "$ARTIFACTORY_USER":"$ARTIFACTORY_PWD" -o "iris_windows/iris_windows.zip" -L $DOWNLOAD_IRIS_URL
    
unzip $WINDOWS_PATH/iris_windows/iris_windows.zip -d $WINDOWS_PATH/iris_windows

files=($WINDOWS_PATH/iris_windows/*)
echo "${files[0]}"
IRIS_ZIP="${files[0]}"

cp -r $IRIS_ZIP/x64/include third_party/iris

cp -r $IRIS_ZIP/x64/Debug/AgoraRtcScreenSharing.exe third_party/iris/AgoraRtcScreenSharing.exe
cp -r $IRIS_ZIP/x64/Debug/AgoraRtcWrapper.dll third_party/iris/AgoraRtcWrapper.dll
cp -r $IRIS_ZIP/x64/Debug/AgoraRtcWrapper.lib third_party/iris/AgoraRtcWrapper.lib

rm -rf $WINDOWS_PATH/iris_windows

