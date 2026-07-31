#!/usr/bin/env bash
set -euo pipefail

TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_CLIENT_DIR="$(cd "$TEST_DIR/.." && pwd)"

if [[ -f "$TEST_DIR/../skills/revdoku/SKILL.md" ]]; then
  # Public GitHub distribution layout.
  DIST_ROOT="$(cd "$TEST_DIR/.." && pwd)"
  CLI_FILE="$DIST_ROOT/skills/revdoku/bin/revdoku"
  SKILL_FILE="$DIST_ROOT/skills/revdoku/SKILL.md"
  API_FILE="$DIST_ROOT/api.md"
  README_FILE="$DIST_ROOT/README.md"
  LICENSE_FILE="$DIST_ROOT/LICENSE"
  VERSION_FILE="$DIST_ROOT/VERSION"
  MANIFEST_ROOT="$DIST_ROOT"
  PUBLIC_DISTRIBUTION=true
else
  # Canonical revdoku-ee source layout.
  DIST_ROOT="$SOURCE_CLIENT_DIR"
  CLI_FILE="$SOURCE_CLIENT_DIR/bin/revdoku"
  SKILL_FILE="$SOURCE_CLIENT_DIR/skill/SKILL.md"
  API_FILE="$SOURCE_CLIENT_DIR/api.md"
  README_FILE="$SOURCE_CLIENT_DIR/README.md"
  LICENSE_FILE="$SOURCE_CLIENT_DIR/LICENSE"
  VERSION_FILE="$(cd "$SOURCE_CLIENT_DIR/../../.." && pwd)/VERSION"
  MANIFEST_ROOT="$SOURCE_CLIENT_DIR"
  PUBLIC_DISTRIBUTION=false
fi

die() {
  echo "error: $1" >&2
  exit 1
}

require_text() {
  local file="$1" text="$2"
  grep -Fq -- "$text" "$file" || die "${file#$DIST_ROOT/} is missing required contract text: $text"
}

reject_text() {
  local file="$1" text="$2"
  if grep -Fq -- "$text" "$file"; then
    die "${file#$DIST_ROOT/} contains retired or unavailable contract text: $text"
  fi
}

[[ -f "$LICENSE_FILE" ]] || die "root/source LICENSE is missing"
bash -n "$CLI_FILE"

require_text "$CLI_FILE" "--site-mode MODE"
require_text "$README_FILE" "hosted MCP implementation"
require_text "$API_FILE" '`GET` | `/api/v1/buckets/:id/form_submissions/:submission_id`'
require_text "$API_FILE" '`GET` | `/api/v1/buckets/:id/versions`'
require_text "$API_FILE" 'Selection coordinates are `[x1, y1, x2, y2]`.'
require_text "$SKILL_FILE" '`bucket_publication_analytics`'
require_text "$SKILL_FILE" '`bucket_env_get`'
require_text "$SKILL_FILE" '`bucket_lock_files`'
require_text "$SKILL_FILE" '`bucket_delete_permanently`'
require_text "$SKILL_FILE" 'Public, Password, and Require Email'

for file in "$API_FILE" "$SKILL_FILE" "$README_FILE"; do
  reject_text "$file" "local stdio MCP"
  reject_text "$file" "docs/connector-updates.md"
  reject_text "$file" "reference file uploads"
  reject_text "$file" 'site_type: "app"'
  reject_text "$file" "Any field names you like"
done

skill_words="$(wc -w < "$SKILL_FILE" | tr -d '[:space:]')"
[[ "$skill_words" -le 3000 ]] || die "SKILL.md is too large (${skill_words} words; maximum 3000)"

version="$(tr -d '[:space:]' < "$VERSION_FILE")"
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+([+-][0-9A-Za-z.-]+)?$ ]] || die "invalid VERSION: $version"

if [[ "$PUBLIC_DISTRIBUTION" == true ]]; then
  manifest_paths=(
    "$MANIFEST_ROOT/.codex-plugin/plugin.json"
    "$MANIFEST_ROOT/.cursor-plugin/plugin.json"
    "$MANIFEST_ROOT/plugins/revdoku/.claude-plugin/plugin.json"
  )
else
  manifest_paths=(
    "$MANIFEST_ROOT/public/.codex-plugin/plugin.json"
    "$MANIFEST_ROOT/public/.cursor-plugin/plugin.json"
    "$MANIFEST_ROOT/claude-plugin/plugin.json"
  )
fi

for manifest in "${manifest_paths[@]}"; do
  manifest_version="$(ruby -rjson -e 'print JSON.parse(File.read(ARGV.fetch(0))).fetch("version")' "$manifest")"
  [[ "$manifest_version" == "$version" ]] || die "${manifest#$DIST_ROOT/} version $manifest_version does not match $version"
done

ruby -rjson -e '
  codex = JSON.parse(File.read(ARGV.fetch(0)))
  cursor = JSON.parse(File.read(ARGV.fetch(1)))
  abort "Codex plugin must load .mcp.json" unless codex["mcpServers"] == "./.mcp.json"
  abort "Cursor plugin must load mcp.json" unless cursor["mcpServers"] == "./mcp.json"
  abort "Cursor plugin must use its native manifest schema" if cursor.key?("interface")
' "${manifest_paths[0]}" "${manifest_paths[1]}"

if [[ "$PUBLIC_DISTRIBUTION" == true ]]; then
  mcp_files=("$DIST_ROOT/.mcp.json" "$DIST_ROOT/mcp.json")
else
  mcp_files=("$DIST_ROOT/public/.mcp.json" "$DIST_ROOT/public/mcp.json")
fi
for mcp_file in "${mcp_files[@]}"; do
  ruby -rjson -e '
    expected = { "type" => "http", "url" => "https://app.revdoku.com/mcp" }
    actual = JSON.parse(File.read(ARGV.fetch(0))).dig("mcpServers", "revdoku")
    abort "public MCP config must contain only the hosted Revdoku server" unless actual == expected
  ' "$mcp_file"
done

marketplace_file="$MANIFEST_ROOT/.claude-plugin/marketplace.json"
if [[ "$PUBLIC_DISTRIBUTION" != true ]]; then
  marketplace_file="$MANIFEST_ROOT/claude-plugin/marketplace.json"
fi
ruby -rjson -e '
  entries = JSON.parse(File.read(ARGV.fetch(0))).fetch("plugins")
  abort "Claude marketplace must omit explicit plugin versions for git revision updates" if entries.any? { |entry| entry.key?("version") }
' "$marketplace_file"

if [[ "$PUBLIC_DISTRIBUTION" == true ]]; then
  [[ ! -e "$DIST_ROOT/apps" ]] || die "public distribution must not contain the private source tree"
  [[ ! -e "$DIST_ROOT/templates/quick-publish-examples" ]] || die "public distribution must not contain quick-publish build inputs"
  cmp -s "$DIST_ROOT/skills/revdoku/SKILL.md" "$DIST_ROOT/plugins/revdoku/skills/revdoku/SKILL.md" || die "standalone and plugin skills differ"
fi

echo "Public CLI, skill, MCP setup, plugin, and API contract checks passed."
