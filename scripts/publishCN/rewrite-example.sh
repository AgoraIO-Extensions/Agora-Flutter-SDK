#!/bin/bash
set -e

export LC_ALL=C

MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/../..)
. ${PROJECT_ROOT}/scripts/publishCN/common.sh

change_dir="${PROJECT_ROOT}/example/lib"

find "$change_dir" -type f | while read -r file; do
  sed -i.bak "s/package:${old_name}\//package:${new_name}\//g" "$file"
  echo "Replaced in $file"
done

change_file=${PROJECT_ROOT}/example/pubspec.yaml
sed "s/${old_name}:/${new_name}:/g" ${change_file} >tmp && mv tmp ${change_file}

find "$change_dir" -name "*.bak" -type f -delete

echo "All replacements completed successfully, and backup files have been deleted."
