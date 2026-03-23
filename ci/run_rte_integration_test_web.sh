#!/usr/bin/env bash

set -e
set -x

MY_PATH=$(realpath $(dirname "$0"))
PROJECT_ROOT=$(realpath ${MY_PATH}/..)

# Copy rte.js to test app web directory so <script src="./rte.js"> can find it
cp ${PROJECT_ROOT}/example/web/rte.js ${PROJECT_ROOT}/test_shard/integration_test_app/web/rte.js

pushd ${PROJECT_ROOT}/test_shard/integration_test_app

echo "Run RTE integration test on web"
echo "Requires chromedriver running on port 4444"

flutter packages get

flutter drive \
  --verbose-system-logs \
  -d web-server \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/rte_comprehensive_test.dart \
  --dart-define=TEST_APP_ID="${TEST_APP_ID}"

popd
