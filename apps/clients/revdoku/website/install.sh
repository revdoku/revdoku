#!/usr/bin/env bash
set -euo pipefail

REVDOKU_INSTALL_BASE="${REVDOKU_INSTALL_BASE:-__REVDOKU_INSTALL_BASE__}"
# Substituted with the current version when served by Rails /install.sh; left as
# the literal placeholder when fetched from a raw mirror (install.sh ignores it).
REVDOKU_CLIENT_VERSION="${REVDOKU_CLIENT_VERSION:-__REVDOKU_CLIENT_VERSION__}"

# Template served by Rails /install.sh.
if ! command -v curl >/dev/null 2>&1; then
  echo "error: requires curl" >&2
  exit 1
fi

curl -fsSL "${REVDOKU_INSTALL_BASE%/}/install.sh" | REVDOKU_INSTALL_BASE="$REVDOKU_INSTALL_BASE" REVDOKU_CLIENT_VERSION="$REVDOKU_CLIENT_VERSION" bash
