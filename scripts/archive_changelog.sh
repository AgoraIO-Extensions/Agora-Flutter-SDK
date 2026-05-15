#!/usr/bin/env bash

set -euo pipefail

ROOT_FILE="CHANGELOG.md"
ARCHIVE_FILE="docs/CHANGELOG.archive.md"
MAX_BYTES=262144

usage() {
  cat <<'EOF'
Usage: archive_changelog.sh [--root PATH] [--archive PATH] [--max-bytes N]
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --root)
      ROOT_FILE="$2"
      shift 2
      ;;
    --archive)
      ARCHIVE_FILE="$2"
      shift 2
      ;;
    --max-bytes)
      MAX_BYTES="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ ! -f "${ROOT_FILE}" ]]; then
  echo "missing root changelog: ${ROOT_FILE}" >&2
  exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

python3 - <<'PY' "${ROOT_FILE}" "${TMP_DIR}/meta.json"
import json
import re
import sys
from pathlib import Path

root = Path(sys.argv[1]).read_text()
match = re.search(r'^(# Changelog\s*\n+)', root, re.MULTILINE)
if not match:
    raise SystemExit("CHANGELOG.md must start with '# Changelog'")
header = match.group(1)
body = root[match.end():]
parts = re.split(r'(?=^## )', body, flags=re.MULTILINE)
sections = [part for part in parts if part.strip()]
Path(sys.argv[2]).write_text(json.dumps({"header": header, "sections": sections}))
PY

python3 - <<'PY' "${TMP_DIR}/meta.json" "${TMP_DIR}/header.txt"
import json
import sys
from pathlib import Path
data = json.loads(Path(sys.argv[1]).read_text())
Path(sys.argv[2]).write_text(data["header"])
for index, section in enumerate(data["sections"]):
    Path(f"{sys.argv[2]}.{index}").write_text(section)
print(len(data["sections"]))
PY

SECTION_COUNT="$(python3 - <<'PY' "${TMP_DIR}/meta.json"
import json
import sys
from pathlib import Path
data = json.loads(Path(sys.argv[1]).read_text())
print(len(data["sections"]))
PY
)"

KEEP_COUNT="${SECTION_COUNT}"
while (( KEEP_COUNT >= 1 )); do
  cp "${TMP_DIR}/header.txt" "${TMP_DIR}/candidate_root.txt"
  for ((i=0; i<KEEP_COUNT; i++)); do
    cat "${TMP_DIR}/header.txt.${i}" >> "${TMP_DIR}/candidate_root.txt"
  done
  CANDIDATE_BYTES="$(wc -c < "${TMP_DIR}/candidate_root.txt" | tr -d ' ')"
  if (( CANDIDATE_BYTES <= MAX_BYTES )); then
    break
  fi
  KEEP_COUNT=$((KEEP_COUNT - 1))
done

if (( KEEP_COUNT == 0 )); then
  echo "latest changelog section cannot fit within ${MAX_BYTES} bytes" >&2
  exit 1
fi

if (( KEEP_COUNT == SECTION_COUNT )); then
  cp "${TMP_DIR}/candidate_root.txt" "${ROOT_FILE}"
  echo "CHANGELOG.md already within limit (${CANDIDATE_BYTES} bytes)"
  exit 0
fi

mkdir -p "$(dirname "${ARCHIVE_FILE}")"

if [[ -f "${ARCHIVE_FILE}" ]]; then
  ARCHIVE_BODY="$(python3 - <<'PY' "${ARCHIVE_FILE}"
import re
import sys
from pathlib import Path
text = Path(sys.argv[1]).read_text()
match = re.search(r'^(# Changelog Archive\s*\n+)', text, re.MULTILINE)
if match:
    print(text[match.end():], end="")
else:
    print(text, end="")
PY
)"
else
  ARCHIVE_BODY=""
fi

{
  printf '# Changelog Archive\n\n'
  for ((i=KEEP_COUNT; i<SECTION_COUNT; i++)); do
    cat "${TMP_DIR}/header.txt.${i}"
  done
  printf '%s' "${ARCHIVE_BODY}"
} > "${ARCHIVE_FILE}"

cp "${TMP_DIR}/candidate_root.txt" "${ROOT_FILE}"

FINAL_BYTES="$(wc -c < "${ROOT_FILE}" | tr -d ' ')"
echo "Archived $((SECTION_COUNT - KEEP_COUNT)) changelog section(s); root changelog is ${FINAL_BYTES} bytes"
