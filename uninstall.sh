#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="revdoku"
AGENT="${REVDOKU_AGENT:-auto}"
USER_BIN_DIR="${REVDOKU_BIN_DIR:-${HOME}/.revdoku/bin}"
REMOVE_CREDENTIALS="${REVDOKU_REMOVE_CREDENTIALS:-false}"
REMOVE_BUNDLED_JQ="${REVDOKU_REMOVE_BUNDLED_JQ:-auto}"
REMOVE_CODEX_MCP="${REVDOKU_REMOVE_CODEX_MCP:-true}"

die() {
  echo "error: $1" >&2
  exit 1
}

remove_path() {
  local path="$1"
  if [[ -e "$path" || -L "$path" ]]; then
    rm -rf "$path"
    echo "Removed ${path}"
  else
    echo "Not found: ${path}"
  fi
}

remove_skill_from() {
  local root="$1"
  remove_path "${root}/skills/${SKILL_NAME}"
}

remove_codex_mcp_registration() {
  local codex_root="$1"
  local config_file="${CODEX_CONFIG_FILE:-${codex_root}/config.toml}"
  local tmp backup

  case "$REMOVE_CODEX_MCP" in
    true) ;;
    false)
      echo "Kept Codex MCP registration. Set REVDOKU_REMOVE_CODEX_MCP=true to remove it."
      return
      ;;
    *)
      die "invalid REVDOKU_REMOVE_CODEX_MCP=${REMOVE_CODEX_MCP}; use true or false"
      ;;
  esac

  if [[ ! -f "$config_file" ]]; then
    echo "Not found: ${config_file}"
    return
  fi

  if ! grep -Eq '^\[mcp_servers\.revdoku(\.|\])' "$config_file"; then
    echo "Not found: Codex MCP server registration in ${config_file}"
    return
  fi

  tmp="$(mktemp)"
  backup="${config_file}.revdoku-uninstall-backup.$(date +%Y%m%d%H%M%S)"
  cp "$config_file" "$backup"
  awk '
    /^\[mcp_servers\.revdoku(\.|\])/ { skip = 1; next }
    /^\[/ { skip = 0 }
    !skip { print }
  ' "$config_file" > "$tmp"
  mv "$tmp" "$config_file"
  echo "Removed Codex MCP server registration from ${config_file}"
  echo "Backup saved to ${backup}"
}

remove_user_command() {
  remove_path "${USER_BIN_DIR}/revdoku"

  case "$REMOVE_BUNDLED_JQ" in
    true)
      remove_path "${USER_BIN_DIR}/jq"
      ;;
    auto)
      if [[ "$USER_BIN_DIR" == "${HOME}/.revdoku/bin" ]]; then
        remove_path "${USER_BIN_DIR}/jq"
      fi
      ;;
    false)
      ;;
    *)
      die "invalid REVDOKU_REMOVE_BUNDLED_JQ=${REMOVE_BUNDLED_JQ}; use auto, true, or false"
      ;;
  esac
}

remove_credentials_if_requested() {
  case "$REMOVE_CREDENTIALS" in
    true)
      remove_path "${HOME}/.revdoku/credentials"
      remove_path "${HOME}/.revdoku/credentials.bucket"
      ;;
    false)
      echo "Kept credentials in ${HOME}/.revdoku. Set REVDOKU_REMOVE_CREDENTIALS=true to remove them."
      ;;
    *)
      die "invalid REVDOKU_REMOVE_CREDENTIALS=${REMOVE_CREDENTIALS}; use true or false"
      ;;
  esac
}

main() {
  local codex_root="${CODEX_HOME:-${HOME}/.codex}"
  local claude_root="${CLAUDE_HOME:-${HOME}/.claude}"
  local hermes_root="${HERMES_HOME:-${HOME}/.hermes}"
  local openclaw_root="${OPENCLAW_HOME:-${HOME}/.openclaw}"

  case "$AGENT" in
    auto)
      remove_skill_from "$codex_root"
      remove_codex_mcp_registration "$codex_root"
      if [[ -d "$claude_root" ]]; then
        remove_skill_from "$claude_root"
      fi
      if [[ -d "$hermes_root" ]]; then
        remove_skill_from "$hermes_root"
      fi
      if [[ -d "$openclaw_root" ]]; then
        remove_skill_from "$openclaw_root"
      fi
      ;;
    codex)
      remove_skill_from "$codex_root"
      remove_codex_mcp_registration "$codex_root"
      ;;
    claude)
      remove_skill_from "$claude_root"
      ;;
    hermes)
      remove_skill_from "$hermes_root"
      ;;
    openclaw)
      remove_skill_from "$openclaw_root"
      ;;
    both)
      remove_skill_from "$codex_root"
      remove_codex_mcp_registration "$codex_root"
      remove_skill_from "$claude_root"
      ;;
    all)
      remove_skill_from "$codex_root"
      remove_codex_mcp_registration "$codex_root"
      remove_skill_from "$claude_root"
      remove_skill_from "$hermes_root"
      remove_skill_from "$openclaw_root"
      ;;
    *)
      die "invalid REVDOKU_AGENT=${AGENT}; use auto, codex, claude, hermes, openclaw, both, or all"
      ;;
  esac

  remove_user_command
  remove_credentials_if_requested

  rmdir "${USER_BIN_DIR}" 2>/dev/null || true
  rmdir "${HOME}/.revdoku" 2>/dev/null || true

  echo "Revdoku local tooling uninstall complete."
}

main "$@"
