#!/usr/bin/env bash
set -e
set -x

MY_PATH=$(realpath $(dirname "$0"))

pushd ${MY_PATH}

rm -rf .yarnrc.yml
rm -rf yarn.lock

echo "nodeLinker: node-modules" >> .yarnrc.yml
echo "enableImmutableInstalls: false" >> .yarnrc.yml
yarn set version berry
cat >> .yarnrc.yml <<'EOF'
approvedGitRepositories:
  - "ssh://git@github.com/AgoraIO-Extensions/terra.git"
  - "ssh://git@github.com/AgoraIO-Extensions/terra_shared_configs.git"
EOF
yarn

popd
