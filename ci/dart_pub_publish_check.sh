#!/bin/bash

# The log of `dart pub publish`` will be written into `${PUB_CACHE}/log/pub_log.txt`
dart pub publish --dry-run --verbose

if [[ ! -f "${PUB_CACHE}/log/pub_log.txt" ]]; then
    echo "The ${PUB_CACHE}/log/pub_log.txt is not exist."
    exit 1
fi

RET=$(grep 'ERR' ${PUB_CACHE}/log/pub_log.txt)

if [[ ! -z $RET ]]; then 
  echo "\n"
  echo "=================================== ERR ============================================="
  echo "There are some ERR when run the \`dart pub publish --dry-run\`, please check the log."
  exit 1
fi

exit 0