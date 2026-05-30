# Revdoku Workspace Storage API

Revdoku exposes the same workspace storage model through HTTP APIs and MCP
tools. Use the API when integrating a service, CI job, backend worker, or custom
client. Use MCP when an AI agent is connected to Revdoku as a tool server.
Most users should use the app's copied agent prompt instead of hand-writing API
calls.

All examples assume:

```sh
export REVDOKU_URL=https://app.revdoku.com
export REVDOKU_API_KEY=revdoku_...
```

Every API request uses:

```http
Authorization: Bearer $REVDOKU_API_KEY
```

Agent and integration clients should also send standard HTTP `User-Agent`
telemetry plus Revdoku agent context headers. Revdoku stores these in request
logs and audit logs so users can see which agent/client used a workspace and
when.

```http
User-Agent: RevdokuMCP/0.1.0 (codex)
X-Revdoku-Agent: codex
X-Revdoku-Agent-Client: chatgpt
X-Revdoku-Agent-Version: 0.1.0
X-Revdoku-Agent-Run-Id: run_20260520_001
X-Revdoku-Agent-Project: marketing-site
X-Revdoku-Agent-Task: landing-page-refresh
```

Use `User-Agent` for the standard client identifier. Use `X-Revdoku-Agent-*`
only for Revdoku-specific operational context. `project` and `task` may also be
stored in optional workspace metadata when future agents need to find the same
workspace; request headers are for audit/activity tracking.

Responses are wrapped as `{ "data": ... }`. Errors are wrapped as
`{ "error": { "message": "...", "code": "...", "request_id": "...", "docs_url": "..." } }`.
Use `error.code` for recovery logic; `request_id` is for support/debugging, and
`docs_url` points the agent or integrator at the relevant documentation.

## Agent Authentication

The easiest way for a signed-in user to connect an agent is the Revdoku app's
**Copy prompt** button. It creates a one-time grant token. Exchange that
token for a normal `revdoku_...` API key:

```sh
curl -fsS "$REVDOKU_URL/api/v1/agent_auth/exchange_grant" \
  -H "Content-Type: application/json" \
  -d '{
    "grant_token": "GRANT_TOKEN_FROM_REVDOKU",
    "label": "CI storage agent"
  }'
```

The response includes `data.api_key`, `data.account_id`, the granted
`workspace_access`, optional `workspace_ids` / `workspace_permissions`, account
connection limits, `data.guidance`, and a short-lived `manage_access.url` where
the user can review or adjust the agent's access. The grant can be used once
and expires quickly. Store the API key in secret storage, follow `data.guidance`,
and do not print the key.

Email-code auth is the fallback when the user is not already signed in:

```sh
curl -fsS "$REVDOKU_URL/api/v1/agent_auth/request_code" \
  -H "Content-Type: application/json" \
  -d '{ "email": "person@example.com" }'

curl -fsS "$REVDOKU_URL/api/v1/agent_auth/verify_code" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "person@example.com",
    "code": "123456",
    "label": "CI storage agent",
    "workspace_access": "all"
  }'
```

For selected-workspace access, pass `workspace_access: "selected"`,
`workspace_ids`, and optional `workspace_permissions` such as
`{ "wrk_...": "write" }`.

## Browser Dashboard Links

Agents can create a short-lived browser login link when the user asks to open the
Revdoku dashboard, manage access, view pricing, or use another Revdoku UI page
that is not exposed through the API or CLI:

```sh
curl -fsS "$REVDOKU_URL/api/v1/agent_auth/browser_login_link" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{ "redirect_path": "/account/access" }'
```

Common `redirect_path` values are `/workspaces` for the dashboard, `/library`
for Library settings, `/account/access` for people, API keys, and agent access,
and `/pricing` for plans. The returned `data.url` is single-use and expires
quickly. If the URL is shown in a terminal, tell the user to Cmd-click on macOS
or Ctrl-click on Windows/Linux when their terminal supports clickable links.

## Workspace Lifecycle

Create a private workspace:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "workspace": {
      "title": "Marketing workspace",
      "description": "Static site drafts and generated launch assets",
      "tag_paths": ["website", "ai-agent"],
      "metadata": {
        "project": "marketing-site",
        "task": "landing-page-refresh"
      }
    }
  }'
```

List workspaces:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Get one workspace and its files:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Update workspace title or metadata:

```sh
curl -fsS -X PATCH "$REVDOKU_URL/api/v1/workspaces/wrk_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{ "workspace": { "description": "Updated purpose", "metadata": { "run": "revision-2" } } }'
```

List reusable workspace labels before choosing `tag_paths` or tag ids. A
`tag_path` can be a simple label such as `website` or a slash group such as
`projects/work`; missing labels are created when a workspace is saved:

```sh
curl -fsS "$REVDOKU_URL/api/v1/tags" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Archive a workspace:

```sh
curl -fsS -X DELETE "$REVDOKU_URL/api/v1/workspaces/wrk_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

## Workspace Versions and Restore

List workspace versions:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../versions" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Read one historical version and its files:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../versions/wrkrv_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Restore a historical version as the latest version:

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/workspaces/wrk_.../rollback" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "version_id": "wrkrv_...",
    "comment": "Return to the first published draft"
  }'
```

Restore is non-destructive: Revdoku creates a new latest version linked to the
selected version's file revisions. Existing newer versions remain in history.
The new version comment starts with `Restored from Version N`.

## File Storage

Multipart upload is simplest and works well for small to medium files:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -F "relative_path=dist/index.html" \
  -F "file=@dist/index.html;type=text/html"
```

Uploading to the same `relative_path` creates a new version of that workspace
file.

For simultaneous agent work, lock an existing file before replacing it. The lock
records the owning API key and message so other agents can see who is editing.
Locks expire automatically after the server maximum, currently 15 minutes.

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/workspaces/wrk_.../files/lock" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "path": "dist/index.html",
    "message": "codex updating dist/index.html for the landing page refresh",
    "duration_seconds": 900
  }'
```

Unlock after the write:

```sh
curl -fsS -X DELETE "$REVDOKU_URL/api/v1/workspaces/wrk_.../files/df_.../lock" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

If another API key owns an active lock, write/delete/direct-upload requests
return `423` with code `FILE_LOCKED` and lock details. Do not overwrite in that
case; coordinate with the lock owner or wait for expiry.

`relative_path` supports nested folders. Preserve the path from the local project
root, for example `index.html`, `assets/styles/site.css`, and
`assets/images/logo.png`. Revdoku keeps those paths for private workspace storage
and public workspace publications.

List workspace files:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Download a file:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../files/df_.../download" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -o index.html
```

Delete a file:

```sh
curl -fsS -X DELETE "$REVDOKU_URL/api/v1/workspaces/wrk_.../files/df_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

## Direct Uploads

For larger files or browser/service integrations, create an upload descriptor,
upload bytes to the returned URL, then attach the signed blob to a workspace.

```sh
BODY='{
  "blob": {
    "filename": "index.html",
    "byte_size": 1234,
    "checksum": "BASE64_MD5",
    "content_type": "text/html",
    "sha256": "HEX_SHA256",
    "purpose": "file"
  }
}'

curl -fsS "$REVDOKU_URL/api/v1/direct_uploads" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$BODY"
```

Workspace-limited keys must also include the target workspace id when creating
the upload descriptor. Include `relative_path` or `path` when replacing an
existing file so Revdoku can enforce active file locks before issuing the direct
upload:

```sh
curl -fsS "$REVDOKU_URL/api/v1/direct_uploads" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "workspace_id": "wrk_...",
    "relative_path": "dist/index.html",
    "blob": {
      "filename": "index.html",
      "byte_size": 1234,
      "checksum": "BASE64_MD5",
      "content_type": "text/html",
      "sha256": "HEX_SHA256",
      "purpose": "workspace_file"
    }
  }'
```

Use `data.direct_upload.url` and `data.direct_upload.headers` from the response
for the byte upload. Then attach the returned `data.signed_id`:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "signed_blob_id": "...",
    "relative_path": "dist/index.html",
    "name": "index.html"
  }'
```

The byte upload goes directly to the configured object-storage service using the
returned URL and headers. The workspace path is set when attaching the signed
blob with `relative_path`; do not add Revdoku auth or agent headers to the
object-storage upload URL.

## Public Workspace Publishing

Private workspace storage does not create a public URL. Publish explicitly when
the workspace should be public.

Create a permanent public workspace URL:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../publish" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{ "entrypoint": "index.html", "site_type": "static", "permanent": true }'
```

Use `site_type: "static"` for ordinary static websites where missing nested
paths should return 404. Use `site_type: "spa"` for compiled client-side apps,
including React/Vite/Lovable-style builds, where deep links such as `/settings`
should fall back to the publication entrypoint. `spa_mode: true` is accepted as
an alias for `site_type: "spa"`.

Create an expiring public URL:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../publish" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{ "entrypoint": "index.html", "expires_in_days": 7 }'
```

Publication responses include:

- `url`: share URL. For published workspaces this is the public workspace URL when configured.
- `public_url`: public workspace URL. With wildcard publishing enabled this is `https://<workspace-slug>.<publication-domain>/`; otherwise it is the direct public object-storage/CDN URL.
- `managed_url`: Rails-managed compatibility link.
- `asset_base_url`: direct public object-storage/CDN directory for workspace assets.
- `permanent`: `true` when the link has no expiration.
- `expires_at`: ISO timestamp for expiring links, omitted for permanent links.
- `active`: `true` while the publication is usable.
- `public_id`: stable DNS-safe workspace slug. It is generated on first publish and reused for that workspace.
- `spa_mode`: `true` when nested public routes fall back to the entrypoint.

Expiring publications stop serving after `expires_at`. Revdoku also schedules a
cleanup job at that time to purge the public files.

Workspace publishes overwrite the stable `<public_id>/...` public prefix. For workspace bundles, `public_id` is the DNS-safe workspace publication slug used as the public storage prefix. It is generated on first publish and remains reserved for that workspace across unpublish and republish. Published changes may take a short CDN cache window to appear globally. When wildcard workspace subdomains are configured, public URLs use `https://<workspace-slug>.<publication-domain>/`.

If public object storage is not configured for the deployment, publish requests
return `503` with error code `PUBLIC_STORAGE_NOT_CONFIGURED`. Treat the
workspace as private storage in that case; do not delete or re-upload files just
because public publishing is unavailable.

For larger local folders, use the publish-session API. This creates or updates a
workspace, compares paths and SHA-256 hashes against the current publication,
returns direct upload URLs only for files that need new bytes, and finalizes the
publication after the client uploads those bytes to object storage. Reused files
appear in `data.publish_session.files` with `upload_required: false` and are not
included in `data.publish_session.uploads`.

```sh
curl -fsS "$REVDOKU_URL/api/v1/publish" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Marketing site",
    "workspace_title": "Marketing site",
    "workspace_description": "Generated landing page assets",
    "workspace_tag_paths": ["website", "ai-agent"],
    "entrypoint": "index.html",
    "site_type": "spa",
    "permanent": true,
    "files": [
      {
        "path": "index.html",
        "byte_size": 1234,
        "content_type": "text/html",
        "checksum": "BASE64_MD5",
        "sha256": "HEX_SHA256"
      }
    ]
  }'
```

Upload each file to its returned `data.publish_session.uploads[].upload.url`
using exactly the returned upload headers, then call the returned
`data.finalize.url` with `POST`. Do not send Revdoku auth headers to object
storage upload URLs.

If a direct upload URL expires or a storage provider rejects it before bytes are
sent, refresh the upload URLs and retry the failed paths:

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/publish/pus_.../uploads/refresh" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

If finalize returns `409` with `PUBLISH_SESSION_STALE`,
`PUBLISH_SESSION_EXPIRED`, or `PUBLISH_SESSION_NOT_PENDING`, recreate the
publish session from the same local manifest and retry once. That is the safe
agent recovery path because unchanged files are hash-reused.

Publish-session create, refresh, and finalize responses include
`deploy_summary` with `site_type`, `entrypoint`, `uploaded_files`,
`reused_files`, `total_files`, `public_url`, `publication_id`, and
`workspace_id`. Agents should surface this summary to users instead of dumping
the whole manifest.

Get one publication:

```sh
curl -fsS "$REVDOKU_URL/api/v1/publications/pub_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Get the published file manifest:

```sh
curl -fsS "$REVDOKU_URL/api/v1/publications/pub_.../manifest" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Update publication settings without re-uploading files:

```sh
curl -fsS -X PATCH "$REVDOKU_URL/api/v1/publications/pub_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{ "entrypoint": "index.html", "site_type": "spa", "permanent": true }'
```

When `site_type` / `spa_mode` is omitted during an update, the existing routing
mode is preserved.

List public workspace links:

```sh
curl -fsS "$REVDOKU_URL/api/v1/publications" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Filter by workspace:

```sh
curl -fsS "$REVDOKU_URL/api/v1/publications?workspace_id=wrk_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Unpublish a workspace while reserving the same public URL for later republish:

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/workspaces/wrk_.../unpublish" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

The older publication-id revoke endpoint is still accepted for compatibility:

```sh
curl -fsS -X DELETE "$REVDOKU_URL/api/v1/publications/pub_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

## Recommended Integration Pattern

1. Create or find a workspace using a clear title, optional labels, and optional metadata such as project, task, or run id.
2. Upload files into stable relative paths.
3. Keep using the workspace as private virtual storage.
4. Publish only when a public link is needed, and republish the same workspace to keep the same URL.
5. Unpublish with `/api/v1/workspaces/:id/unpublish` when the public site should stop serving.
6. List `/api/v1/publications` to discover active public links instead of
   inferring public state from workspace metadata.
