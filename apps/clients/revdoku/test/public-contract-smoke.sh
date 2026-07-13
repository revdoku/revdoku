#!/usr/bin/env bash
set -euo pipefail

CLIENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

require_text() {
  local file="$1" text="$2"
  grep -Fq -- "$text" "$CLIENT_DIR/$file" || {
    echo "error: $file is missing required contract text: $text" >&2
    exit 1
  }
}

reject_text() {
  local file="$1" text="$2"
  if grep -Fq -- "$text" "$CLIENT_DIR/$file"; then
    echo "error: $file contains retired contract text: $text" >&2
    exit 1
  fi
}

bash -n "$CLIENT_DIR/bin/revdoku"

require_text "bin/revdoku" "--site-mode MODE"
require_text "README.md" "one 30-day Starter trial"
require_text "api.md" 'HTTP `402` with code `TRIAL_EXPIRED`'
require_text "api.md" 'Supported ranges are `24h`, `7d`, `30d`, and `90d`.'
require_text "api.md" '| Starter | 1 custom domain. |'
require_text "skill/SKILL.md" 'Reusable API keys start on Builder'
require_text "skill/SKILL.md" '`bucket_lock_files` with a `paths` array'
require_text "skill/SKILL.md" '`revdoku_dashboard_link`'

reject_text "api.md" "Published websites are permanent on every plan"
reject_text "api.md" "stateful Streamable"
reject_text "skill/SKILL.md" '`site_type: "app"`'
reject_text "skill/SKILL.md" "Any field names you like"

echo "Public CLI/skill/API contract checks passed."
