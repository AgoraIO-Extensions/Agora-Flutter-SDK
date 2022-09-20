

#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")

mkdir -p ${MY_PATH}/ffigen_include

cp -RP ${MY_PATH}/../../macos/AgoraRtcWrapper.framework/Headers/* ${MY_PATH}/ffigen_include/
cp -RP ${MY_PATH}/../../macos/libs/AgoraRtcKit.framework/Headers/* ${MY_PATH}/ffigen_include/

cp -RP ${MY_PATH}/cxx/src/iris_debug.h ${MY_PATH}/ffigen_include/iris_debug.h


 flutter pub run ffigen --config ${MY_PATH}/ffigen_config.yaml

 rm -rf ${MY_PATH}/ffigen_include