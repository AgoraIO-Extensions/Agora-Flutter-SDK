#!/bin/bash

set -e

old_package_name='Agora-Flutter-SDK'
new_package_name='Shengwang-Flutter-SDK'

old_name="agora_rtc_engine"
new_name="shengwang_rtc_engine"

old_description="Flutter plugin of Agora RTC SDK, allow you to simply integrate Agora"
new_description="Flutter plugin of Shengwang RTC SDK, allow you to simply integrate Shengwang"

old_link="www.agora.io"
new_link="www.shengwang.cn"

MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/..)

# ./
change_file=${PROJECT_ROOT}/pubspec.yaml

sed "s/name: ${old_name}/name: ${new_name}/g" ${change_file} >tmp && mv tmp ${change_file}
sed "s/${old_package_name}/${new_package_name}/g" ${change_file} >tmp && mv tmp ${change_file}
sed "s/${old_description}/${new_description}/g" ${change_file} >tmp && mv tmp ${change_file}
sed "s/${old_link}/${new_link}/g" ${change_file} >tmp && mv tmp ${change_file}


# ./example/lib/
change_dir="${PROJECT_ROOT}/example/lib"

find "$change_dir" -type f | while read -r file; do
  sed -i.bak "s/package:${old_name}\//package:${new_name}\//g" "$file"
  echo "Replaced in $file"
done

change_file=${PROJECT_ROOT}/example/pubspec.yaml
sed "s/${old_name}:/${new_name}:/g" ${change_file} >tmp && mv tmp ${change_file}

find "$change_dir" -name "*.bak" -type f -delete

echo "All replacements completed successfully, and backup files have been deleted."