

#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(dirname "$0")
IRIS_PATH=$1

mkdir -p ${MY_PATH}/ffigen_include

cp -RP ${IRIS_PATH}/src/interface/*.h ${MY_PATH}/ffigen_include/
cp -RP ${IRIS_PATH}/src/interface/rtc/*.h ${MY_PATH}/ffigen_include/
cp -RP ${IRIS_PATH}/debug/src/iris_debug.h ${MY_PATH}/ffigen_include/iris_debug.h

 flutter pub run ffigen --config ${MY_PATH}/ffigen_config.yaml

 rm -rf ${MY_PATH}/ffigen_include