#!/usr/bin/env bash
set -euo pipefail
umask 077

VERSION='1.0.544'
EXPECTED_SHA256='45dbd562fb47e91a24cb85a3223cbab04602fcc5d0c34acc54b0d8539a416764'
INSTALL_DIR="${HOME}/.local/bin"
case "${1:-}" in
  --help|-h)
    printf 'Install Revdoku CLI %s without AI integrations.\nUsage: bash install-cli.sh [--dir DIRECTORY]\nDefault: ~/.local/bin\n' "$VERSION"
    exit 0 ;;
  --dir)
    [[ $# == 2 && -n "$2" ]] || { echo 'error: --dir requires a directory' >&2; exit 1; }
    INSTALL_DIR="$2" ;;
  '') ;;
  *) echo 'error: usage: bash install-cli.sh [--dir DIRECTORY]' >&2; exit 1 ;;
esac

for dependency in curl openssl jq base64 find; do
  command -v "$dependency" >/dev/null 2>&1 || { printf 'error: install %s first\n' "$dependency" >&2; exit 1; }
done
mkdir -p "$INSTALL_DIR"
INSTALL_DIR="$(cd "$INSTALL_DIR" && pwd -P)"
[[ ! -L "$INSTALL_DIR/revdoku" && ! -d "$INSTALL_DIR/revdoku" ]] || {
  echo 'error: destination revdoku is a symlink or directory; choose another --dir' >&2; exit 1;
}
TEMP_DIR="$(mktemp -d "$INSTALL_DIR/.revdoku-install.XXXXXX")"
trap 'rm -rf "$TEMP_DIR"' EXIT
curl -q --proto '=https' --proto-redir '=https' -fsSL \
  "https://github.com/revdoku/revdoku/releases/download/cli-v${VERSION}/revdoku" \
  -o "$TEMP_DIR/revdoku"
ACTUAL_SHA256="$(openssl dgst -sha256 "$TEMP_DIR/revdoku" | awk '{print $NF}')"
[[ "$ACTUAL_SHA256" == "$EXPECTED_SHA256" ]] || { echo 'error: CLI checksum mismatch; nothing installed' >&2; exit 1; }
[[ "$(bash "$TEMP_DIR/revdoku" --version)" == "$VERSION" ]] || { echo 'error: CLI version mismatch' >&2; exit 1; }
chmod 0755 "$TEMP_DIR/revdoku"
mv "$TEMP_DIR/revdoku" "$INSTALL_DIR/revdoku"
printf 'Installed Revdoku CLI %s at %s/revdoku\n' "$VERSION" "$INSTALL_DIR"
printf 'Run: %s/revdoku --help\n' "$INSTALL_DIR"
printf 'Add %s to PATH if needed. Run revdoku login to connect.\n' "$INSTALL_DIR"
