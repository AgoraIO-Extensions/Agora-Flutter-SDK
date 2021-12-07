#!/usr/bin/env bash

set -e

AGORA_FLUTTER_PROJECT_PATH=$(pwd)
WINDOWS_PATH=$AGORA_FLUTTER_PROJECT_PATH/windows

DOWNLOAD_IRIS_URL=$1

cd $WINDOWS_PATH

mkdir -p iris_windows

echo "Downloading project resources from Storage..."

filename="outfile.zip"

if curl --silent -o "iris_windows/iris_windows" -L $DOWNLOAD_IRIS_URL; then
    # unzip "${filename}"
    # unzip $WINDOWS_PATH/iris_windows/iris_windows.zip
    # if [[ -f "${PWD}/${filename}" ]]; then
    #     echo "Removing the file.."
    #     rm -f "${PWD}/${filename}"
    # fi

    cp -r iris_windows/x64/include third_party/iris/include

    cp -r iris_windows/iris_windows/x64/Debug/AgoraRtcScreenSharing.exe third_party/iris/AgoraRtcScreenSharing.exe
    cp -r iris_windows/iris_windows/x64/Debug/AgoraRtcWrapper.dll third_party/iris/AgoraRtcWrapper.dll
    cp -r iris_windows/iris_windows/x64/Debug/AgoraRtcWrapper.lib third_party/iris/AgoraRtcWrapper.lib
else
    echo "Something went wrong"
fi
echo "Done!"

# curl $DOWNLOAD_IRIS_URL  --output iris_windows/iris_windows.zip
# curl $DOWNLOAD_IRIS_URL --output iris_windows/iris_windows.zip

# unzip $WINDOWS_PATH/iris_windows/iris_windows.zip

# jar xvf COCR2_100.zip

