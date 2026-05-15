#!/bin/bash

# The log of `dart pub publish`` will be written into `${PUB_CACHE}/log/pub_log.txt`
# Run publish dry run and capture exit code
if ! dart pub publish --dry-run; then
  echo "Publication check failed!"
  exit 1
fi

exit 0