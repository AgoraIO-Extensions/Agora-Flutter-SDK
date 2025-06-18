#!/bin/bash

IRIS_SDK_URL="https://download.agora.io/sdk/release/iris_4.4.2.0.28-build.2_DCG_OHOS_Video_20250625_0204_53.zip"

# The internal folder structure is:
# iris_x.x.x-ohos.x.x_DCG_OHOS
# ├── ALL_ARCHITECTURE
# │   └── Release
# │       └── AgoraRtcWrapper.har
# └── DCG
#     └── AgoraRtcSdk-x.x.x.har

# 1. Download the iris zip file into ./tmp with curl
# 2. Unzip the iris zip file into ./tmp
# 3. find the AgoraRtcWrapper.har in ./tmp/iris_x.x.x-ohos.x.x_DCG_OHOS/DCG/Release with find command
# 4. Copy the AgoraRtcWrapper.har to ./har/AgoraRtcWrapper.har
# 5. Copy the AgoraRtcSdk-x.x.x.har to ./har/AgoraRtcSdk.har

TMP_FOLDER="./tmp"

# create tmp folder if not exists
mkdir -p $TMP_FOLDER

# download the iris zip file if not exists
if [ ! -f $TMP_FOLDER/iris.zip ]; then
    curl -o $TMP_FOLDER/iris.zip $IRIS_SDK_URL
    if [ $? -ne 0 ]; then
        echo "Failed to download iris zip file from $IRIS_SDK_URL"
        exit 1
    fi
fi

# unzip the iris zip file if not exists
unzip -o -d $TMP_FOLDER $TMP_FOLDER/iris.zip
if [ $? -ne 0 ]; then
    echo "Failed to unzip iris zip file"
    exit 1
fi

# find the AgoraRtcWrapper.har in ./tmp/iris_x.x.x-ohos.x.x_DCG_OHOS/DCG/Release with find command
UNZIPED_SDK_FOLDER=$(find $TMP_FOLDER -name "AgoraRtcWrapper.har" | sed 's/\/ALL_ARCHITECTURE\/Release\/AgoraRtcWrapper.har//')
if [ -z "$UNZIPED_SDK_FOLDER" ]; then
    echo "Failed to find AgoraRtcWrapper.har in $TMP_FOLDER"
    exit 1
fi

# create .har folder if not exists
HAR_FOLDER="./har"
mkdir -p $HAR_FOLDER

# copy the AgoraRtcWrapper.har to ./har/AgoraRtcWrapper.har
cp $UNZIPED_SDK_FOLDER/ALL_ARCHITECTURE/Release/AgoraRtcWrapper.har $HAR_FOLDER/AgoraRtcWrapper.har
if [ $? -ne 0 ]; then
    echo "Failed to copy AgoraRtcWrapper.har to $HAR_FOLDER/AgoraRtcWrapper.har"
    exit 1
fi

# find AgoraRtcSdk-x.x.x.har in $UNZIPED_SDK_FOLDER/DCG by extension .har
AGORA_RTC_SDK_FOLDER=$(find $UNZIPED_SDK_FOLDER/DCG -name "*.har")

# copy the AgoraRtcSdk-x.x.x.har to ./har/AgoraRtcSdk.har
cp $AGORA_RTC_SDK_FOLDER $HAR_FOLDER/AgoraRtcSdk.har

