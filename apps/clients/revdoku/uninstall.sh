#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="revdoku"
AGENT="${REVDOKU_AGENT:-auto}"
USER_BIN_DIR="${REVDOKU_BIN_DIR:-${HOME}/.revdoku/bin}"
REMOVE_CREDENTIALS="${REVDOKU_REMOVE_CREDENTIALS:-false}"
REMOVE_BUNDLED_JQ="${REVDOKU_REMOVE_BUNDLED_JQ:-auto}"

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
      remove_path "${HOME}/.revdoku/credentials.workspace"
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

  case "$AGENT" in
    auto)
      remove_skill_from "$codex_root"
      if [[ -d "$claude_root" ]]; then
        remove_skill_from "$claude_root"
      fi
      ;;
    codex)
      remove_skill_from "$codex_root"
      ;;
    claude)
      remove_skill_from "$claude_root"
      ;;
    both)
      remove_skill_from "$codex_root"
      remove_skill_from "$claude_root"
      ;;
    *)
      die "invalid REVDOKU_AGENT=${AGENT}; use auto, codex, claude, or both"
      ;;
  esac

  remove_user_command
  remove_credentials_if_requested

  rmdir "${USER_BIN_DIR}" 2>/dev/null || true
  rmdir "${HOME}/.revdoku" 2>/dev/null || true

  echo "Revdoku local tooling uninstall complete."
}

main "$@"
