#!/usr/bin/env bash
set -euo pipefail
[[ $# == 1 && -n "$1" ]] || { echo 'Usage: bash cli/package-release.sh EMPTY_OUTPUT_DIRECTORY' >&2; exit 1; }
CLI_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$CLI_DIR/.." && pwd)"
VERSION_FILE="$ROOT/VERSION"
[[ -f "$VERSION_FILE" ]] || VERSION_FILE="$ROOT/../../../VERSION"
VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"
[[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo 'Invalid VERSION' >&2; exit 1; }
[[ "$(bash "$CLI_DIR/revdoku" --version 2>/dev/null)" == "$VERSION" ]] || { echo 'CLI version differs from VERSION' >&2; exit 1; }
SHA="$(openssl dgst -sha256 "$CLI_DIR/revdoku" | awk '{print $NF}')"
grep -Fxq "VERSION='$VERSION'" "$CLI_DIR/install.sh"
grep -Fxq "EXPECTED_SHA256='$SHA'" "$CLI_DIR/install.sh"
[[ ! -e "$1" || ( -d "$1" && -z "$(ls -A "$1")" ) ]] || { echo 'Output directory must be empty' >&2; exit 1; }
mkdir -p "$1"
cp "$CLI_DIR/revdoku" "$1/revdoku"
cp "$CLI_DIR/install.sh" "$1/install-cli.sh"
cp "$ROOT/LICENSE" "$1/LICENSE"
chmod 0755 "$1/revdoku" "$1/install-cli.sh"
(
  cd "$1"
  for file in revdoku install-cli.sh LICENSE; do
    printf '%s  %s\n' "$(openssl dgst -sha256 "$file" | awk '{print $NF}')" "$file"
  done > SHA256SUMS
)
printf 'Prepared CLI %s assets in %s\n' "$VERSION" "$1"
