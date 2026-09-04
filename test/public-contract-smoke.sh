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
  LLMS_INSTALL_FILE="$DIST_ROOT/llms-install.md"
  README_FILE="$DIST_ROOT/README.md"
  LICENSE_FILE="$DIST_ROOT/LICENSE"
  INSTALL_FILE="$DIST_ROOT/install.sh"
  UNINSTALL_FILE="$DIST_ROOT/uninstall.sh"
  VERSION_FILE="$DIST_ROOT/VERSION"
  CHANGELOG_FILE="$DIST_ROOT/CHANGELOG.md"
  MANIFEST_ROOT="$DIST_ROOT"
  PRICING_FILE="$DIST_ROOT/pricing.md"
  SCHEMA_MAP_FILE="$DIST_ROOT/schema-map.xml"
  RESOURCE_FEED_FILE="$DIST_ROOT/schema-feeds/agent-resources.jsonl"
  PUBLIC_DISTRIBUTION=true
else
  # Canonical source-package layout.
  DIST_ROOT="$SOURCE_CLIENT_DIR"
  CLI_FILE="$SOURCE_CLIENT_DIR/bin/revdoku"
  SKILL_FILE="$SOURCE_CLIENT_DIR/skill/SKILL.md"
  API_FILE="$SOURCE_CLIENT_DIR/api.md"
  LLMS_INSTALL_FILE="$SOURCE_CLIENT_DIR/llms-install.md"
  README_FILE="$SOURCE_CLIENT_DIR/README.md"
  LICENSE_FILE="$SOURCE_CLIENT_DIR/LICENSE"
  INSTALL_FILE="$SOURCE_CLIENT_DIR/install.sh"
  UNINSTALL_FILE="$SOURCE_CLIENT_DIR/uninstall.sh"
  VERSION_FILE="$(cd "$SOURCE_CLIENT_DIR/../../.." && pwd)/VERSION"
  SOURCE_ROOT="$(cd "$SOURCE_CLIENT_DIR/../../.." && pwd)"
  CHANGELOG_FILE="$SOURCE_ROOT/CHANGELOG.md"
  CHANGELOG_HELPER="$SOURCE_ROOT/scripts/changelog.rb"
  MANIFEST_ROOT="$SOURCE_CLIENT_DIR"
  PRICING_FILE="$SOURCE_CLIENT_DIR/discovery/pricing.md"
  SCHEMA_MAP_FILE="$SOURCE_CLIENT_DIR/discovery/schema-map.xml"
  RESOURCE_FEED_FILE="$SOURCE_CLIENT_DIR/discovery/schema-feeds/agent-resources.jsonl"
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
[[ -f "$CHANGELOG_FILE" ]] || die "root/source CHANGELOG.md is missing"
bash -n "$CLI_FILE"
bash -n "$INSTALL_FILE"
bash -n "$UNINSTALL_FILE"


require_text "$CLI_FILE" "--site-mode MODE"
require_text "$CLI_FILE" "--form-preset NAME"
require_text "$CLI_FILE" '--arg access_mode "$PUBLICATION_ACCESS_MODE"'
require_text "$CLI_FILE" '--arg form_preset "$PUBLICATION_FORM_PRESET"'
reject_text "$CLI_FILE" "/api/v1/quick_publish"
reject_text "$CLI_FILE" "anonymous preview"
require_text "$CLI_FILE" "PUBLICATION_UPGRADE_REQUIRED"
require_text "$CLI_FILE" "Upgrade the account, then try again."
require_text "$README_FILE" "hosted MCP implementation"
require_text "$README_FILE" "[CHANGELOG.md](./CHANGELOG.md)"
require_text "$README_FILE" "npx skills add revdoku/revdoku --skill revdoku -g"
require_text "$LLMS_INSTALL_FILE" "Prefer local shell and filesystem access"
for target in codex claude-code cursor antigravity opencode grok-build hermes openclaw; do
  require_text "$INSTALL_FILE" "$target"
  require_text "$UNINSTALL_FILE" "$target"
done
require_text "$README_FILE" "app.revdoku.com/users/sign_up"
require_text "$README_FILE" "every tool descriptor requires OAuth"
require_text "$README_FILE" "*.localhost3000.love"
require_text "$LLMS_INSTALL_FILE" "npx skills add revdoku/revdoku --skill revdoku -g"
require_text "$LLMS_INSTALL_FILE" "app.revdoku.com/users/sign_up"
require_text "$LLMS_INSTALL_FILE" "Authenticate with OAuth before calling tools"
require_text "$LLMS_INSTALL_FILE" "https://app.revdoku.com/pricing"
require_text "$LLMS_INSTALL_FILE" "https://app.revdoku.com/pricing.json"
require_text "$LLMS_INSTALL_FILE" "Permanent public Free websites are indexable by default"
require_text "$CLI_FILE" "--login)"
require_text "$CLI_FILE" "grant TOKEN"
require_text "$CLI_FILE" "Opens browser sign-in when credentials are missing."
require_text "$CLI_FILE" "https://app.revdoku.com/pricing.json"
reject_text "$CLI_FILE" "up to 5 public websites"
require_text "$CLI_FILE" "Preview the current private draft for 15 minutes."
require_text "$SKILL_FILE" 'scripts/revdoku.sh p <path>'
reject_text "$SKILL_FILE" 'website_preview_create'
reject_text "$API_FILE" '/api/v1/quick_publish'
require_text "$API_FILE" "never ask the user to paste or repeat the verification code in"
require_text "$API_FILE" '`GET` | `/api/v1/buckets/:id/form_submissions/:submission_id`'
require_text "$API_FILE" '`PATCH` | `/api/v1/buckets/:id/form_submissions/:submission_id`'
require_text "$API_FILE" '`POST` | `/api/v1/buckets/:id/form_submissions/:submission_id/reply`'
require_text "$API_FILE" '`DELETE` | `/api/v1/buckets/:id/form_submissions/:submission_id`'
require_text "$API_FILE" '`GET` | `/api/v1/buckets/:id/versions`'
require_text "$API_FILE" 'Selection coordinates are `[x1, y1, x2, y2]`.'
require_text "$API_FILE" '`"area_selection_enabled": false`'
require_text "$SKILL_FILE" '`bucket_publication_analytics`'
require_text "$SKILL_FILE" 'Analytics accepts `all`'
require_text "$SKILL_FILE" '`downloads` contains'
require_text "$SKILL_FILE" '`bucket_env_get`'
require_text "$SKILL_FILE" '`bucket_lock_files`'
require_text "$SKILL_FILE" '`bucket_delete_permanently`'
require_text "$SKILL_FILE" '`github_sync_setup`'
require_text "$SKILL_FILE" '`area_selection_enabled: false`'
require_text "$SKILL_FILE" 'Password, and Require Email'
require_text "$API_FILE" '`github_sync_setup`'
require_text "$API_FILE" 'https://app.revdoku.com/pricing'
require_text "$API_FILE" 'https://app.revdoku.com/pricing.json'
require_text "$API_FILE" 'including Free websites, are indexable by'
require_text "$SKILL_FILE" 'https://app.revdoku.com/pricing'
require_text "$SKILL_FILE" 'Permanent public Free websites are indexable by default'
require_text "$SKILL_FILE" 'Never silently publish protected content as'
require_text "$SKILL_FILE" 'Every authenticated bucket preview lasts 15 minutes'
reject_text "$SKILL_FILE" 'up to 100 permanent public websites'
reject_text "$SKILL_FILE" 'up to 5 public websites'
reject_text "$SKILL_FILE" 'sites are noindex by default'
reject_text "$SKILL_FILE" 'short-lived dashboard login link'
reject_text "$SKILL_FILE" 'analytics, visitor activity'
require_text "$API_FILE" '`/api/v1/account/brand_domain`'
require_text "$API_FILE" '"status": "pending_ownership"'
require_text "$API_FILE" 'The lifetime cannot be customized'
require_text "$SOURCE_CLIENT_DIR/docs.md" 'Every bucket preview expires 15'
require_text "$SKILL_FILE" '`ACCOUNT_SUSPENDED`'
require_text "$SKILL_FILE" 'support@revdoku.com'
require_text "$API_FILE" '`account.restriction`'
require_text "$SOURCE_CLIENT_DIR/docs.md" 'website moderation restriction'
require_text "$SOURCE_CLIENT_DIR/docs.md" 'Permanent public Free websites are indexable by default'
reject_text "$SOURCE_CLIENT_DIR/docs.md" 'scheduler hitting a public action'
require_text "$PRICING_FILE" 'https://app.revdoku.com/pricing.md'
require_text "$PRICING_FILE" 'https://app.revdoku.com/pricing.json'
reject_text "$PRICING_FILE" '| Limit |'
require_text "$SCHEMA_MAP_FILE" 'href="https://app.revdoku.com/pricing.md"'
require_text "$SCHEMA_MAP_FILE" 'href="https://app.revdoku.com/pricing.json"'
require_text "$RESOURCE_FEED_FILE" '"url":"https://app.revdoku.com/pricing.md"'
require_text "$RESOURCE_FEED_FILE" '"url":"https://app.revdoku.com/pricing.json"'

for file in "$API_FILE" "$SKILL_FILE" "$README_FILE"; do
  reject_text "$file" "local stdio MCP"
  reject_text "$file" "docs/connector-updates.md"
  reject_text "$file" "reference file uploads"
  reject_text "$file" 'site_type: "app"'
  reject_text "$file" "Settings → Security and login"
  reject_text "$file" "Any field names you like"
  reject_text "$file" "Starter trial"
  reject_text "$file" "trial"
  reject_text "$file" "Trial"
  reject_text "$file" "available on Starter"
  reject_text "$file" "available on Builder"
  reject_text "$file" "paid plans"
  reject_text "$file" "sign in or create an account"
  reject_text "$file" "https://docs.revdoku.site/"
done

reject_text "$README_FILE" "priceing"
reject_text "$README_FILE" "currently can hosts"
reject_text "$README_FILE" "for paid customers"
reject_text "$README_FILE" "Claude's scheduled tasks"
reject_text "$API_FILE" "Custom Website Names"
reject_text "$API_FILE" 'dashboard will show `0 views`'
reject_text "$API_FILE" "one live-site slot"
reject_text "$API_FILE" "4k-file buckets"
for demo_file in "$README_FILE" "$SOURCE_CLIENT_DIR/docs.md"; do
  if grep -Eq '\]\(https://[^)]*\.revdoku\.site/' "$demo_file"; then
    die "${demo_file#$DIST_ROOT/} links a live demo through the legacy publication domain"
  fi
done

require_text "$README_FILE" 'can be downloaded from Revdoku at'
require_text "$README_FILE" 'export them to CSV at any time'
require_text "$API_FILE" 'export authorized submission data to CSV at'
require_text "$SKILL_FILE" 'export submission data to CSV at any time'

require_text "$API_FILE" 'Supported ranges are `all`'

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
  reject_text "$CHANGELOG_FILE" "## Unreleased"
  grep -Eq '^## [0-9]+\.[0-9]+\.[0-9]+ — [0-9]{4}-[0-9]{2}-[0-9]{2}$' "$CHANGELOG_FILE" || die "public CHANGELOG.md has no valid release heading"
  [[ ! -e "$DIST_ROOT/apps" ]] || die "public distribution must not contain the private source tree"
  [[ ! -e "$DIST_ROOT/templates/quick-publish-examples" ]] || die "public distribution must not contain quick-publish build inputs"
  cmp -s "$DIST_ROOT/skills/revdoku/SKILL.md" "$DIST_ROOT/plugins/revdoku/skills/revdoku/SKILL.md" || die "standalone and plugin skills differ"
  discovery_files=(
    ".well-known/agent.json"
    ".well-known/agent-card.json"
    ".well-known/ai-plugin.json"
    ".well-known/api-catalog"
    "openapi.json"
    "pricing.md"
    "robots.txt"
    "schema-map.xml"
    "schema-feeds/agent-resources.jsonl"
  )
  for relative in "${discovery_files[@]}"; do
    [[ -f "$DIST_ROOT/$relative" ]] || die "public discovery file is missing: $relative"
  done
  ruby -rjson -e 'ARGV.each { |path| JSON.parse(File.read(path)) }' \
    "$DIST_ROOT/.well-known/agent.json" \
    "$DIST_ROOT/.well-known/agent-card.json" \
    "$DIST_ROOT/.well-known/ai-plugin.json" \
    "$DIST_ROOT/.well-known/api-catalog" \
    "$DIST_ROOT/openapi.json"
else
  ruby "$CHANGELOG_HELPER" check "$CHANGELOG_FILE"
fi

echo "Public CLI, skill, MCP setup, plugin, and API contract checks passed."
