#!/usr/bin/env bash
set -euo pipefail

REVDOKU_INSTALL_BASE="${REVDOKU_INSTALL_BASE:-__REVDOKU_INSTALL_BASE__}"

# Template served by Rails /install.sh.
if ! command -v curl >/dev/null 2>&1; then
  echo "error: requires curl" >&2
  exit 1
fi

curl -fsSL "${REVDOKU_INSTALL_BASE%/}/install.sh" | REVDOKU_INSTALL_BASE="$REVDOKU_INSTALL_BASE" bash
