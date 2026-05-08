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

# Yarn 4.14+ blocks git: protocol deps unless explicitly allowed (YN0080).
cat >> .yarnrc.yml << 'EOF'

approvedGitRepositories:
  - "ssh://git@github.com/AgoraIO-Extensions/*"
EOF

yarn

popd