#!/bin/bash

# usage: check_android15_16k_page_alignment.sh path/to/lib.so

SO_FILE="$1"

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

res="$(objdump -p ${SO_FILE} | grep LOAD | awk '{ print $NF }' | head -1)"
if [[ $res =~ "2**14" ]] || [[ $res =~ "2**16" ]]; then
    echo -e "${SO_FILE}: ALIGNED ($res)"
    exit 0
else
    echo -e "${SO_FILE}: UNALIGNED ($res)"
    exit 1
fi