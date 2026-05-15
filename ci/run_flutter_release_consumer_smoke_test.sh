#!/usr/bin/env bash

set -euo pipefail
set -x

: "${CONSUMER_PLATFORM:?CONSUMER_PLATFORM is required}"
: "${PACKAGE_SOURCE:?PACKAGE_SOURCE is required}"
: "${RELEASE_VERSION:?RELEASE_VERSION is required}"

PACKAGE_NAME="${PACKAGE_NAME:-agora_rtc_engine}"
GIT_URL="${GIT_URL:-}"
GIT_REF="${GIT_REF:-${RELEASE_VERSION}}"
FLUTTER_BIN="${FLUTTER_BIN:-flutter}"
POD_BIN="${POD_BIN:-pod}"

case "${CONSUMER_PLATFORM}" in
  android|ios|macos|web|windows)
    ;;
  *)
    echo "Unsupported CONSUMER_PLATFORM: ${CONSUMER_PLATFORM}" >&2
    exit 1
    ;;
esac

case "${PACKAGE_SOURCE}" in
  git|pub)
    ;;
  *)
    echo "Unsupported PACKAGE_SOURCE: ${PACKAGE_SOURCE}" >&2
    exit 1
    ;;
esac

if [[ "${PACKAGE_SOURCE}" == "git" && -z "${GIT_URL}" ]]; then
  echo "GIT_URL is required for git source" >&2
  exit 1
fi

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if [[ "${FLUTTER_BIN}" == */* ]]; then
  export PATH="$(dirname "${FLUTTER_BIN}"):${PATH}"
fi

if [[ "${POD_BIN}" == */* ]]; then
  export PATH="$(dirname "${POD_BIN}"):${PATH}"
fi

WORK_DIR="$(mktemp -d)"
APP_DIR="${WORK_DIR}/agora_${PACKAGE_SOURCE}_${CONSUMER_PLATFORM}_smoke"
DEPENDENCY_FILE="${WORK_DIR}/dependency.yaml"

cleanup() {
  rm -rf "${WORK_DIR}"
}
trap cleanup EXIT

"${FLUTTER_BIN}" create --platforms="${CONSUMER_PLATFORM}" --org io.agora.smoke "${APP_DIR}"

if [[ "${PACKAGE_SOURCE}" == "git" ]]; then
  cat >"${DEPENDENCY_FILE}" <<EOF
  ${PACKAGE_NAME}:
    git:
      url: ${GIT_URL}
      ref: ${GIT_REF}
EOF
else
  cat >"${DEPENDENCY_FILE}" <<EOF
  ${PACKAGE_NAME}: ${RELEASE_VERSION}
EOF
fi

ruby -e '
  path = ARGV[0]
  dependency_block = File.read(ARGV[1])
  marker = "  flutter:\n    sdk: flutter"
  content = File.read(path)
  abort("failed to patch pubspec.yaml") unless content.include?(marker)
  File.write(path, content.sub(marker, "#{marker}\n#{dependency_block.rstrip}"))
' "${APP_DIR}/pubspec.yaml" "${DEPENDENCY_FILE}"

cat > "${APP_DIR}/lib/main.dart" <<EOF
import 'package:${PACKAGE_NAME}/${PACKAGE_NAME}.dart';
import 'package:flutter/material.dart';

const _smokeAppId = 'smoke-app-id';

void main() {
  runApp(const ConsumerSmokeApp());
}

class ConsumerSmokeApp extends StatefulWidget {
  const ConsumerSmokeApp({super.key});

  @override
  State<ConsumerSmokeApp> createState() => _ConsumerSmokeAppState();
}

class _ConsumerSmokeAppState extends State<ConsumerSmokeApp> {
  late final RtcEngine _engine;
  String _status = 'initializing';

  @override
  void initState() {
    super.initState();
    _initializeAgora();
  }

  Future<void> _initializeAgora() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: _smokeAppId,
    ));

    if (!mounted) {
      return;
    }

    setState(() {
      _status = 'initialized';
    });
  }

  @override
  void dispose() {
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Agora smoke: \${RtcEngineContext(appId: _smokeAppId).appId} / \${RtcEngineEventHandler().runtimeType} / \$_status',
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
EOF

pushd "${APP_DIR}"

for attempt in $(seq 1 10); do
  if "${FLUTTER_BIN}" pub get; then
    break
  fi

  if [[ "${attempt}" -eq 10 ]]; then
    echo "flutter pub get failed after ${attempt} attempts" >&2
    exit 1
  fi

  sleep 30
done

if [[ "${CONSUMER_PLATFORM}" == "macos" ]]; then
  "${FLUTTER_BIN}" config --enable-macos-desktop
  "${FLUTTER_BIN}" build macos
elif [[ "${CONSUMER_PLATFORM}" == "windows" ]]; then
  "${FLUTTER_BIN}" config --enable-windows-desktop
  "${FLUTTER_BIN}" build windows
elif [[ "${CONSUMER_PLATFORM}" == "android" ]]; then
  "${FLUTTER_BIN}" build apk
elif [[ "${CONSUMER_PLATFORM}" == "web" ]]; then
  "${FLUTTER_BIN}" build web
else
  "${FLUTTER_BIN}" build ios --simulator --no-codesign
fi

popd
