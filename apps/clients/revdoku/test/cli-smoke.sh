#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLIENT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_ROOT="$(cd "${CLIENT_DIR}/../../.." && pwd)"
WEB_DIR="${REPO_ROOT}/apps/web"

REVDOKU_URL="${REVDOKU_URL:-http://127.0.0.1:3001}"
GRANT_TOKEN="${REVDOKU_GRANT_TOKEN:-}"
CREATE_LOCAL_GRANT="${REVDOKU_CREATE_LOCAL_GRANT:-false}"
KEEP_BUCKET="${REVDOKU_KEEP_SMOKE_BUCKET:-false}"

SMOKE_TITLE="CLI smoke virtual storage $(date -u +%Y%m%d%H%M%S)"
SMOKE_DESCRIPTION="Revdoku CLI smoke bucket"
SMOKE_TAG_SOURCE="ai-agent"
SMOKE_TAG_STATUS="draft"
SMOKE_PROJECT="cli-smoke"

die() {
  echo "error: $1" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "requires $1"
}

need_cmd jq
need_cmd mktemp

if [[ -z "$GRANT_TOKEN" && "$CREATE_LOCAL_GRANT" != "true" ]]; then
  die "set REVDOKU_GRANT_TOKEN, or set REVDOKU_CREATE_LOCAL_GRANT=true when running against a local Rails app"
fi

tmp_home="$(mktemp -d)"
tmp_home_selected="$(mktemp -d)"
tmp_data="$(mktemp -d)"
tmp_selected_data="$(mktemp -d)"
tmp_sensitive="$(mktemp -d)"
tmp_data_root="$(basename "$tmp_data")"
tmp_selected_data_root="$(basename "$tmp_selected_data")"
cleanup_bucket_id=""
cleanup_selected_bucket_id=""

cleanup_delete_bucket() {
  local token="$1"
  local bucket_id="$2"
  local bucket_json confirmation delete_body

  bucket_json="$(
    curl -fsS "${REVDOKU_URL%/}/api/v1/buckets/${bucket_id}" \
      -H "Authorization: Bearer ${token}" 2>/dev/null || true
  )"
  confirmation="$(printf "%s" "$bucket_json" | jq -r '.data.bucket.delete.confirmation // empty')"
  [[ -n "$confirmation" ]] || return 0

  delete_body="$(jq -cn --arg confirmation "$confirmation" '{confirmation: $confirmation}')"
  curl -fsS -X DELETE "${REVDOKU_URL%/}/api/v1/buckets/${bucket_id}" \
    -H "Authorization: Bearer ${token}" \
    -H "Content-Type: application/json" \
    -d "$delete_body" >/dev/null 2>&1 || true
}

cleanup() {
  if [[ "$KEEP_BUCKET" != "true" && -n "$cleanup_bucket_id" && -s "${tmp_home}/.revdoku/credentials" ]]; then
    cleanup_token="$(tr -d '\r\n' < "${tmp_home}/.revdoku/credentials")"
    cleanup_delete_bucket "$cleanup_token" "$cleanup_bucket_id"
  fi
  if [[ "$KEEP_BUCKET" != "true" && -n "$cleanup_selected_bucket_id" && -s "${tmp_home_selected}/.revdoku/credentials" ]]; then
    cleanup_selected_token="$(tr -d '\r\n' < "${tmp_home_selected}/.revdoku/credentials")"
    cleanup_delete_bucket "$cleanup_selected_token" "$cleanup_selected_bucket_id"
  fi
  rm -rf "$tmp_home" "$tmp_home_selected" "$tmp_data" "$tmp_selected_data" "$tmp_sensitive"
}
trap cleanup EXIT

selected_grant_token=""
selected_bucket_id=""
if [[ -z "$GRANT_TOKEN" ]]; then
  [[ -d "$WEB_DIR" ]] || die "could not locate apps/web for local grant creation"
  grant_output="$(
    cd "$WEB_DIR"
    bin/rails runner '
      timestamp = Time.current.utc.strftime("%Y%m%d%H%M%S")
      user = User.create!(email: "cli-smoke-#{timestamp}-#{SecureRandom.hex(4)}@revdoku.invalid", confirmed_at: Time.current)
      account = Account.create!(name: "CLI Smoke #{timestamp}", owner: user, personal: true, max_storage_mb: 5120, max_account_connections: 10)
      AccountMember.create!(account: account, user: user, role: :owner)
      bucket = ActsAsTenant.with_tenant(account) do
        account.buckets.create!(title: "CLI Smoke Selected #{timestamp}", bucket_kind: :normal, source: :api)
      end
      account.complete_setup!
      account.update!(max_storage_mb: 5120, max_buckets: 10, max_live_publications: 10, max_account_connections: 10)
      account_raw, = AgentConnectionGrant.issue!(user: user, account: account, bucket: nil, bucket_permissions: {}, metadata: { source: "cli_smoke" })
      selected_raw, = AgentConnectionGrant.issue!(user: user, account: account, bucket: bucket, bucket_permissions: { bucket.prefix_id => "write" }, metadata: { source: "cli_smoke_selected" })
      puts JSON.generate(account_grant: account_raw, selected_grant: selected_raw, selected_bucket_id: bucket.prefix_id)
    '
  )"
  grant_json="$(printf "%s\n" "$grant_output" | tail -n 1)"
  GRANT_TOKEN="$(printf "%s" "$grant_json" | jq -r '.account_grant')"
  selected_grant_token="$(printf "%s" "$grant_json" | jq -r '.selected_grant')"
  selected_bucket_id="$(printf "%s" "$grant_json" | jq -r '.selected_bucket_id')"
fi

printf '<!doctype html><title>Revdoku CLI smoke</title>\n' > "${tmp_data}/index.html"
printf 'revdoku CLI smoke\n' > "${tmp_data}/notes.txt"
printf 'selected bucket default\n' > "${tmp_selected_data}/selected.txt"
printf 'REVDOKU_SECRET=do-not-upload\n' > "${tmp_data}/.env"
printf 'private key placeholder\n' > "${tmp_data}/id_rsa"
mkdir -p "${tmp_data}/config"
printf 'token placeholder\n' > "${tmp_data}/config/api-token.txt"

exchange_json="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    grant "$GRANT_TOKEN"
)"

account_id="$(printf "%s" "$exchange_json" | jq -r '.data.account_id // empty')"
[[ "$account_id" == acct_* ]] || die "grant exchange did not return account id"
[[ -s "${tmp_home}/.revdoku/credentials" ]] || die "grant exchange did not save credentials"

dashboard_link="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    dashboard
)"
[[ "$dashboard_link" == *"/agent_login/"* ]] || die "dashboard link did not return an agent browser login URL"

if [[ -n "$selected_grant_token" && "$selected_grant_token" != "null" ]]; then
  selected_exchange_json="$(
    HOME="$tmp_home_selected" "${CLIENT_DIR}/bin/revdoku" \
      --url "$REVDOKU_URL" \
      grant "$selected_grant_token"
  )"
  selected_access="$(printf "%s" "$selected_exchange_json" | jq -r '.data.bucket_access // empty')"
  remembered_bucket="$(tr -d '\r\n' < "${tmp_home_selected}/.revdoku/credentials.bucket")"
  [[ "$selected_access" == "selected" ]] || die "selected grant exchange did not return selected access"
  [[ "$remembered_bucket" == "$selected_bucket_id" ]] || die "selected grant did not save the default bucket"

  selected_store_id="$(
    HOME="$tmp_home_selected" "${CLIENT_DIR}/bin/revdoku" \
      --url "$REVDOKU_URL" \
      p --draft "$tmp_selected_data"
  )"
  cleanup_selected_bucket_id="$selected_store_id"
  [[ "$selected_store_id" == "$selected_bucket_id" ]] || die "selected grant store did not use remembered bucket"
  selected_files_json="$(
    curl -fsS "${REVDOKU_URL%/}/api/v1/buckets/${selected_bucket_id}/files" \
      -H "Authorization: Bearer $(tr -d '\r\n' < "${tmp_home_selected}/.revdoku/credentials")"
  )"
  selected_expected_path="${tmp_selected_data_root}/selected.txt"
  selected_found="$(printf "%s" "$selected_files_json" | jq -r --arg path "$selected_expected_path" '.data.files[]?.path | select(. == $path)' | head -n 1)"
  [[ "$selected_found" == "$selected_expected_path" ]] || die "selected grant did not store into the remembered bucket"
fi

printf 'REVDOKU_SECRET=do-not-upload\n' > "${tmp_sensitive}/.env"
mkdir -p "${tmp_sensitive}/config"
printf 'token placeholder\n' > "${tmp_sensitive}/config/api-token.txt"
bucket_count_before="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    ls | jq '.data.buckets | length'
)"
sensitive_output="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    --title "CLI smoke skipped secrets" \
    p --draft "$tmp_sensitive" 2>&1
)" && die "secret-only folder should not have been stored"
[[ "$sensitive_output" == *"no files found to store after safety exclusions"* ]] || die "secret-only folder did not explain why it was not stored"
bucket_count_after="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    ls | jq '.data.buckets | length'
)"
[[ "$bucket_count_after" == "$bucket_count_before" ]] || die "secret-only folder created an empty bucket"

bucket_id="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    --title "$SMOKE_TITLE" \
    --description "$SMOKE_DESCRIPTION" \
    --tag-path "$SMOKE_TAG_SOURCE" \
    --tag-path "$SMOKE_TAG_STATUS" \
    --metadata "{\"project\":\"${SMOKE_PROJECT}\",\"surface\":\"revdoku-client\"}" \
    p --draft "$tmp_data"
)"
cleanup_bucket_id="$bucket_id"
[[ "$bucket_id" == bkt_* ]] || die "store did not return bucket id"

bucket_json="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    ls
)"

bucket="$(printf "%s" "$bucket_json" | jq --arg id "$bucket_id" '.data.buckets[] | select(.id == $id)' | jq -s '.[0]')"
[[ "$bucket" != "null" ]] || die "stored bucket was not listed"

description="$(printf "%s" "$bucket" | jq -r '.description // empty')"
project="$(printf "%s" "$bucket" | jq -r '.metadata.project // empty')"
source_tag="$(printf "%s" "$bucket" | jq -r --arg tag "$SMOKE_TAG_SOURCE" '.tags[]?.full_path | select(. == $tag)' | head -n 1)"
status_tag="$(printf "%s" "$bucket" | jq -r --arg tag "$SMOKE_TAG_STATUS" '.tags[]?.full_path | select(. == $tag)' | head -n 1)"

[[ "$description" == "$SMOKE_DESCRIPTION" ]] || die "bucket description was not preserved"
[[ "$project" == "$SMOKE_PROJECT" ]] || die "bucket metadata was not preserved"
[[ "$source_tag" == "$SMOKE_TAG_SOURCE" ]] || die "source tag path was not preserved"
[[ "$status_tag" == "$SMOKE_TAG_STATUS" ]] || die "status tag path was not preserved"

files_json="$(
  curl -fsS "${REVDOKU_URL%/}/api/v1/buckets/${bucket_id}/files" \
    -H "Authorization: Bearer $(tr -d '\r\n' < "${tmp_home}/.revdoku/credentials")"
)"
for path in "${tmp_data_root}/index.html" "${tmp_data_root}/notes.txt"; do
  found="$(printf "%s" "$files_json" | jq -r --arg path "$path" '.data.files[]?.path | select(. == $path)' | head -n 1)"
  [[ "$found" == "$path" ]] || die "stored file missing from bucket: $path"
done
for path in "${tmp_data_root}/.env" "${tmp_data_root}/id_rsa" "${tmp_data_root}/config/api-token.txt"; do
  found="$(printf "%s" "$files_json" | jq -r --arg path "$path" '.data.files[]?.path | select(. == $path)' | head -n 1)"
  [[ -z "$found" ]] || die "sensitive file should not have been stored: $path"
done

# Read files back through the CLI (files / read).
cli_files_json="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    --bucket-id "$bucket_id" \
    files
)"
cli_listed_notes="$(printf "%s" "$cli_files_json" | jq -r --arg path "${tmp_data_root}/notes.txt" '.data.files[]?.path | select(. == $path)' | head -n 1)"
[[ "$cli_listed_notes" == "${tmp_data_root}/notes.txt" ]] || die "files did not list the stored notes.txt"

read_notes="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    --bucket-id "$bucket_id" \
    read "${tmp_data_root}/notes.txt"
)"
[[ "$read_notes" == "revdoku CLI smoke" ]] || die "read did not return the stored notes.txt content"

archive_json="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    --bucket-id "$bucket_id" \
    archive
)"
archived_state="$(printf "%s" "$archive_json" | jq -r '.data.bucket.archived')"
[[ "$archived_state" == "true" ]] || die "archive did not mark bucket archived"

bucket_json_with_archived="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    ls
)"
includes_archived="$(printf "%s" "$bucket_json_with_archived" | jq -r '.data.includes_archived')"
archived_list_state="$(printf "%s" "$bucket_json_with_archived" | jq -r --arg id "$bucket_id" '.data.buckets[] | select(.id == $id) | .archived' | head -n 1)"
[[ "$includes_archived" == "true" ]] || die "list-buckets did not include archived metadata"
[[ "$archived_list_state" == "true" ]] || die "archived bucket was missing from list-buckets"

unarchive_json="$(
  HOME="$tmp_home" "${CLIENT_DIR}/bin/revdoku" \
    --url "$REVDOKU_URL" \
    --bucket-id "$bucket_id" \
    unarchive
)"
unarchived_state="$(printf "%s" "$unarchive_json" | jq -r '.data.bucket.archived')"
[[ "$unarchived_state" == "false" ]] || die "unarchive did not restore bucket"

jq -n \
  --arg account_id "$account_id" \
  --arg bucket_id "$bucket_id" \
  --arg title "$SMOKE_TITLE" \
  '{ok:true, account_id:$account_id, bucket_id:$bucket_id, title:$title}'
