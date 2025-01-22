#!/bin/bash
set -e
MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/../..)
. ${PROJECT_ROOT}/scripts/publishCN/common.sh

change_file=${PROJECT_ROOT}/pubspec.yaml
sed "s/name: ${old_name}/name: ${new_name}/g" ${change_file} >tmp && mv tmp ${change_file}
sed "s/${old_package_name}/${new_package_name}/g" ${change_file} >tmp && mv tmp ${change_file}
sed "s/${old_description}/${new_description}/g" ${change_file} >tmp && mv tmp ${change_file}
sed "s/${old_link}/${new_link}/g" ${change_file} >tmp && mv tmp ${change_file}
