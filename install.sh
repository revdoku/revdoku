#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="revdoku"
INSTALL_BASE="${REVDOKU_INSTALL_BASE:-https://raw.githubusercontent.com/revdoku/revdoku/main}"
AGENT="${REVDOKU_AGENT:-auto}"
USER_BIN_DIR="${REVDOKU_BIN_DIR:-${HOME}/.revdoku/bin}"
JQ_VERSION="1.8.1"
JQ_BASE_URL="https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}"

SCRIPT_PATH="${BASH_SOURCE[0]:-}"
SCRIPT_DIR=""
if [[ -n "$SCRIPT_PATH" && -f "$SCRIPT_PATH" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
fi

die() {
  echo "error: $1" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "requires $1"
}

sha256_file() {
  local path="$1"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$path" | awk '{print $1}'
    return
  fi
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$path" | awk '{print $1}'
    return
  fi
  if command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$path" | awk '{print $2}'
    return
  fi
  die "requires sha256sum, shasum, or openssl"
}

detect_jq_asset() {
  local os arch
  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  arch="$(uname -m)"

  case "$os/$arch" in
    darwin/arm64)
      echo "jq-macos-arm64|a9fe3ea2f86dfc72f6728417521ec9067b343277152b114f4e98d8cb0e263603"
      ;;
    darwin/x86_64)
      echo "jq-macos-amd64|e80dbe0d2a2597e3c11c404f03337b981d74b4a8504b70586c354b7697a7c27f"
      ;;
    linux/x86_64)
      echo "jq-linux-amd64|020468de7539ce70ef1bceaf7cde2e8c4f2ca6c3afb84642aabc5c97d9fc2a0d"
      ;;
    linux/aarch64|linux/arm64)
      echo "jq-linux-arm64|6bc62f25981328edd3cfcfe6fe51b073f2d7e7710d7ef7fcdac28d4e384fc3d4"
      ;;
    *)
      die "unsupported platform for bundled jq: ${os}/${arch}"
      ;;
  esac
}

local_asset_candidates() {
  local repo_path="$1"
  [[ -n "$SCRIPT_DIR" ]] || return

  case "$repo_path" in
    "skills/${SKILL_NAME}/SKILL.md")
      printf '%s\n' \
        "${SCRIPT_DIR}/skills/${SKILL_NAME}/SKILL.md" \
        "${SCRIPT_DIR}/skill/SKILL.md"
      ;;
    "skills/${SKILL_NAME}/scripts/revdoku.sh")
      printf '%s\n' \
        "${SCRIPT_DIR}/skills/${SKILL_NAME}/scripts/revdoku.sh" \
        "${SCRIPT_DIR}/skill/scripts/revdoku.sh"
      ;;
    "skills/${SKILL_NAME}/bin/revdoku")
      printf '%s\n' \
        "${SCRIPT_DIR}/skills/${SKILL_NAME}/bin/revdoku" \
        "${SCRIPT_DIR}/bin/revdoku"
      ;;
  esac
}

copy_local_asset_if_available() {
  local repo_path="$1"
  local target="$2"
  local candidate

  while IFS= read -r candidate; do
    [[ -n "$candidate" && -f "$candidate" ]] || continue
    cp "$candidate" "$target"
    return 0
  done < <(local_asset_candidates "$repo_path")

  return 1
}

download_file() {
  local repo_path="$1"
  local target="$2"
  local source_path

  if copy_local_asset_if_available "$repo_path" "$target"; then
    return
  fi

  if [[ "$INSTALL_BASE" == file://* ]]; then
    source_path="${INSTALL_BASE#file://}/${repo_path}"
    [[ -f "$source_path" ]] || die "missing local source for $repo_path at ${source_path}"
    cp "$source_path" "$target"
    return
  fi

  need_cmd curl
  curl -fsSL "${INSTALL_BASE%/}/${repo_path}" -o "$target"
}

install_jq_if_needed() {
  local bin_dir="$1"
  if command -v jq >/dev/null 2>&1 || [[ -x "${bin_dir}/jq" ]]; then
    return
  fi

  local asset expected tmp actual
  need_cmd curl
  IFS="|" read -r asset expected < <(detect_jq_asset)
  tmp="$(mktemp)"
  curl -fsSL "${JQ_BASE_URL}/${asset}" -o "$tmp"
  actual="$(sha256_file "$tmp")"
  if [[ "$actual" != "$expected" ]]; then
    rm -f "$tmp"
    die "downloaded jq checksum mismatch"
  fi
  mv "$tmp" "${bin_dir}/jq"
  chmod 0755 "${bin_dir}/jq"
}

install_skill_to() {
  local root="$1"
  local skill_dir="${root}/skills/${SKILL_NAME}"
  local scripts_dir="${skill_dir}/scripts"
  local bin_dir="${skill_dir}/bin"

  mkdir -p "$scripts_dir" "$bin_dir"
  download_file "skills/${SKILL_NAME}/SKILL.md" "${skill_dir}/SKILL.md"
  download_file "skills/${SKILL_NAME}/scripts/revdoku.sh" "${scripts_dir}/revdoku.sh"
  download_file "skills/${SKILL_NAME}/bin/revdoku" "${bin_dir}/revdoku"
  chmod 0644 "${skill_dir}/SKILL.md"
  chmod 0755 "${scripts_dir}/revdoku.sh" "${bin_dir}/revdoku"
  install_jq_if_needed "$bin_dir"

  echo "Installed ${SKILL_NAME} to ${skill_dir}"
}

install_user_command() {
  mkdir -p "$USER_BIN_DIR"
  download_file "skills/${SKILL_NAME}/bin/revdoku" "${USER_BIN_DIR}/revdoku"
  chmod 0755 "${USER_BIN_DIR}/revdoku"
  install_jq_if_needed "$USER_BIN_DIR"
  echo "Installed command to ${USER_BIN_DIR}/revdoku"
}

# Stamp the installed client version (passed by the Rails-served bootstrap) so
# the CLI can self-check for updates. Skipped when the value is missing or still
# the literal placeholder (e.g. installing from a raw mirror).
write_client_version() {
  local version="${REVDOKU_CLIENT_VERSION:-}"
  [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+ ]] || return 0

  local config_dir="${REVDOKU_CONFIG_DIR:-$(dirname "$USER_BIN_DIR")}"
  mkdir -p "$config_dir"
  printf '%s\n' "$version" > "${config_dir}/client_version"
}

main() {
  local codex_root="${CODEX_HOME:-${HOME}/.codex}"
  local claude_root="${CLAUDE_HOME:-${HOME}/.claude}"
  local hermes_root="${HERMES_HOME:-${HOME}/.hermes}"
  local openclaw_root="${OPENCLAW_HOME:-${HOME}/.openclaw}"
  local installed=0

  case "$AGENT" in
    auto)
      install_skill_to "$codex_root"
      installed=1
      if [[ -d "$claude_root" ]]; then
        install_skill_to "$claude_root"
      fi
      if [[ -d "$hermes_root" ]]; then
        install_skill_to "$hermes_root"
      fi
      if [[ -d "$openclaw_root" ]]; then
        install_skill_to "$openclaw_root"
      fi
      ;;
    codex)
      install_skill_to "$codex_root"
      installed=1
      ;;
    claude)
      install_skill_to "$claude_root"
      installed=1
      ;;
    hermes)
      install_skill_to "$hermes_root"
      installed=1
      ;;
    openclaw)
      install_skill_to "$openclaw_root"
      installed=1
      ;;
    both)
      install_skill_to "$codex_root"
      install_skill_to "$claude_root"
      installed=1
      ;;
    all)
      install_skill_to "$codex_root"
      install_skill_to "$claude_root"
      install_skill_to "$hermes_root"
      install_skill_to "$openclaw_root"
      installed=1
      ;;
    *)
      die "invalid REVDOKU_AGENT=${AGENT}; use auto, codex, claude, hermes, openclaw, both, or all"
      ;;
  esac

  [[ "$installed" -eq 1 ]] || die "nothing installed"
  install_user_command
  write_client_version
  echo ""
  echo "Store files with the ${SKILL_NAME} skill, or run ${USER_BIN_DIR}/revdoku directly."
  echo "Next: ${USER_BIN_DIR}/revdoku login    then: ${USER_BIN_DIR}/revdoku p <folder>  (publish it live)"
}

main "$@"
