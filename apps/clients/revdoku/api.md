# Revdoku API

Use the Revdoku API to create buckets, store files, publish static websites,
attach custom domains, and read publication analytics.

Most AI-agent users should start with the Revdoku app's copied prompt or the
Revdoku MCP tool. Use this HTTP API for custom clients, CI jobs, backend workers,
or direct integrations.

## Quick Start

### Base URL

```sh
export REVDOKU_URL=https://app.revdoku.com
export REVDOKU_API_KEY=revdoku_...
```

### Authentication Header

Send the API key as a bearer token:

```http
Authorization: Bearer $REVDOKU_API_KEY
```

### JSON Headers

Use JSON for request bodies unless an endpoint explicitly uses multipart upload:

```http
Content-Type: application/json
Accept: application/json
```

### Agent Headers

Agent clients should identify themselves. These headers are used for audit logs
and user-visible activity history.

```http
User-Agent: RevdokuMCP/0.1.0 (codex)
X-Revdoku-Agent: codex
X-Revdoku-Agent-Client: chatgpt
X-Revdoku-Agent-Version: 0.1.0
X-Revdoku-Agent-Run-Id: run_20260520_001
X-Revdoku-Agent-Project: marketing-site
X-Revdoku-Agent-Task: landing-page-refresh
```

### Response Format

Successful responses are wrapped in `data`:

```json
{
  "data": {
    "id": "bkt_..."
  }
}
```

Errors are wrapped in `error`:

```json
{
  "error": {
    "message": "Bucket not found",
    "code": "BUCKET_NOT_FOUND",
    "request_id": "req_...",
    "docs_url": "https://revdoku.com/api.md"
  }
}
```

Use `error.code` for recovery logic. Use `request_id` when debugging with
support.

## Hosted MCP for Claude/ChatGPT Cloud

Cloud agents that support custom remote MCP connectors connect to Revdoku through
the production remote MCP endpoint:

```text
https://app.revdoku.com/mcp
```

Add that URL as a Claude custom connector, or in ChatGPT use the custom
connector/custom MCP app/developer-mode MCP surface available to the account. If
that ChatGPT surface is not available, use the local CLI or local stdio MCP
instead. The connector uses Revdoku OAuth discovery, authorization-code PKCE,
and Bearer tokens. Users approve the connection in Revdoku and can revoke it
later from `/account/access`.

Hosted MCP supports JSON-response Streamable HTTP and stateful Streamable
HTTP/SSE sessions. OAuth metadata uses `REVDOKU_MCP_PUBLIC_BASE_URL` when set,
so local HTTPS tunnels and reverse-proxy deployments can publish a stable public
resource URL.

Hosted MCP exposes cloud-safe bucket tools for reading, creating, updating,
archiving, unarchiving, permanent delete, publishing, republishing, and
analytics. It intentionally does not expose local-path tools because cloud
connectors cannot read a user's local filesystem. Use the Revdoku CLI or local
stdio MCP for local folder uploads; hosted MCP can then update and republish the
same `bucket_id`. `bucket_list` and `bucket_get` include bucket ids,
website metadata, publication lifecycle state, and action metadata such as
`archive.required_action` and `delete.confirmation` so agents can handle ids
internally instead of asking users to type them.

## Common Workflows

### Connect an Agent

The lowest-friction flow is the app's **Copy prompt** button. It gives the agent
a one-time grant token. Exchange it for a normal API key:

```sh
curl -fsS "$REVDOKU_URL/api/v1/agent_auth/exchange_grant" \
  -H "Content-Type: application/json" \
  -d '{
    "grant_token": "GRANT_TOKEN_FROM_REVDOKU",
    "label": "Codex on laptop"
  }'
```

Fallback email-code flow:

```sh
curl -fsS "$REVDOKU_URL/api/v1/agent_auth/request_code" \
  -H "Content-Type: application/json" \
  -d '{ "email": "person@example.com" }'

curl -fsS "$REVDOKU_URL/api/v1/agent_auth/verify_code" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "person@example.com",
    "code": "123456",
    "label": "Codex on laptop",
    "bucket_access": "all"
  }'
```

Store the returned `data.api_key` securely. Follow `data.guidance` when the
server includes it. Do not print or log the key.

### Create a Bucket

```sh
curl -fsS "$REVDOKU_URL/api/v1/buckets" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "bucket": {
      "title": "Marketing site",
      "description": "Generated launch assets",
      "tag_paths": ["website", "ai-agent"],
      "metadata": {
        "project": "marketing-site",
        "task": "landing-page"
      }
    }
  }'
```

Example response:

```json
{
  "data": {
    "id": "bkt_...",
    "title": "Marketing site",
    "published": false
  }
}
```

### Upload a File

Multipart upload is easiest for small and medium files:

```sh
curl -fsS "$REVDOKU_URL/api/v1/buckets/bkt_.../files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -F "path=index.html" \
  -F "file=@dist/index.html;type=text/html"
```

Uploading the same `path` creates a new version of that file.

### Publish a Bucket

Publish explicitly when the bucket should have a website URL:

```sh
curl -fsS "$REVDOKU_URL/api/v1/buckets/bkt_.../publication" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "entrypoint": "index.html",
    "site_mode": "spa",
    "access_mode": "public",
    "permanent": true
  }'
```

For a Pro protected website, use `"access_mode": "password"`. Omit
`password` and set `"regenerate_password": true` to generate a copyable
password, or provide a password in the JSON body. Never put the password in the
URL.

Example response:

```json
{
  "data": {
    "id": "pub_...",
    "bucket_id": "bkt_...",
    "public_slug": "bright-canvas-meadow",
    "public_url": "https://bright-canvas-meadow.revdoku.site/",
    "status": "published",
    "site_mode": "spa",
    "access_mode": "public",
    "permanent": true
  }
}
```

Use `site_mode: "static"` for ordinary static sites. Use `site_mode: "spa"` for
React/Vite-style apps where deep links should fall back to `index.html`.

### Publish a Folder Efficiently

Use publish sessions for larger folders. Revdoku compares file hashes, uploads
only changed bytes, then finalizes the publication.

Create the session:

```sh
curl -fsS "$REVDOKU_URL/api/v1/publish_sessions" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "bucket_title": "Marketing site",
    "entrypoint": "index.html",
    "site_mode": "spa",
    "access_mode": "password",
    "regenerate_password": true,
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

Upload each file to `data.publish_session.uploads[].upload.url` using exactly
the returned upload headers. Do not send Revdoku auth headers to object-storage
upload URLs.

Finalize the session:

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/publish_sessions/pus_.../finalize" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

If an upload URL expires, refresh it:

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/publish_sessions/pus_.../uploads/refresh" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

### Add a Custom Domain

Custom domains are available on paid plans. Publish the bucket first.

```sh
curl -fsS "$REVDOKU_URL/api/v1/buckets/bkt_.../custom_domains" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{ "hostname": "example.com" }'
```

Example response while DNS is still pending:

```json
{
  "data": {
    "custom_domain": {
      "id": "pcd_...",
      "hostname": "example.com",
      "status": "pending_validation",
      "ssl_status": "pending_validation",
      "public_url": null,
      "required_dns_records": [
        {
          "type": "CNAME",
          "name": "example.com",
          "value": "custom.revdoku.site",
          "purpose": "traffic",
          "apex": true,
          "supported_types": ["ALIAS", "ANAME", "CNAME flattening"]
        },
        {
          "type": "TXT",
          "name": "_cf-custom-hostname.example.com",
          "value": "...",
          "purpose": "ownership"
        }
      ]
    },
    "publication": {
      "public_url": "https://bright-canvas-meadow.revdoku.site/"
    },
    "limits": {
      "active_count": 1,
      "max_custom_domains": 25
    }
  }
}
```

Add every returned DNS record. Then refresh until `custom_domain.status` is
`active`:

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/buckets/bkt_.../custom_domains/pcd_.../refresh" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

When active, the publication `public_url` switches to the custom domain.
The managed `https://<bucket-slug>.revdoku.site/` URL keeps working.

For apex domains such as `example.com`, the DNS provider must support ALIAS,
ANAME, or CNAME flattening. If it does not, use `www.example.com` as the custom
domain and redirect `example.com` to `www.example.com` at the DNS/hosting
provider.

### Read Analytics

Publication analytics are visible on paid plans. Free plans receive the same
shape with numbers hidden.

```sh
curl -fsS "$REVDOKU_URL/api/v1/analytics?range=30d" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Example paid response:

```json
{
  "data": {
    "range": "30d",
    "first_event_at": "2026-05-22T09:12:33.000Z",
    "last_event_at": "2026-05-26T18:32:14.000Z",
    "totals": {
      "hits_all_time": 8420,
      "hits": 1204,
      "visitors": 822,
      "hits_not_found": 18,
      "hits_bots": 91
    },
    "daily": [
      { "date": "2026-05-26", "hits": 120, "visitors": 84, "hits_not_found": 2, "hits_bots": 9 }
    ],
    "buckets": [
      {
        "bucket_id": "bkt_abc123",
        "bucket_title": "Docs",
        "publication_id": "pub_abc123",
        "public_slug": "docs",
        "url": "https://docs.revdoku.site/",
        "hits": 1204
      }
    ],
    "paths": [
      { "path": "/", "hits": 650 }
    ],
    "referrers": [
      { "referrer": "direct", "hits": 420 }
    ],
    "countries": [
      { "country": "US", "hits": 510 }
    ],
    "bots": [
      { "bot": "GPTBot", "hits": 91 }
    ],
    "paths_not_found": [
      { "bucket_id": "bkt_abc123", "publication_id": "pub_abc123", "public_slug": "docs", "path": "/old-page", "hits": 18 }
    ]
  }
}
```

`visitors` is a sum of each day's unique visitor count, not a global unique
visitor count across the whole range.

## API Reference

### Authentication Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `POST` | `/api/v1/agent_auth/request_code` | Send an email verification code. |
| `POST` | `/api/v1/agent_auth/verify_code` | Verify the email code and create an API key. |
| `POST` | `/api/v1/agent_auth/exchange_grant` | Exchange an app-created grant for an API key. |
| `POST` | `/api/v1/agent_auth/browser_login_link` | Create a one-time dashboard login link. |

#### POST /api/v1/agent_auth/request_code

```json
{
  "email": "person@example.com"
}
```

#### POST /api/v1/agent_auth/verify_code

```json
{
  "email": "person@example.com",
  "code": "123456",
  "label": "Codex on laptop",
  "bucket_access": "all"
}
```

For selected-bucket access, use:

```json
{
  "bucket_access": "selected",
  "bucket_ids": ["bkt_..."],
  "bucket_permissions": {
    "bkt_...": "write"
  }
}
```

#### POST /api/v1/agent_auth/exchange_grant

```json
{
  "grant_token": "GRANT_TOKEN_FROM_REVDOKU",
  "label": "Codex on laptop"
}
```

#### POST /api/v1/agent_auth/browser_login_link

Requires `Authorization`.
Disabled when the authenticated user has two-factor authentication enabled or
the account requires two-factor authentication. In that case, open the Revdoku
dashboard through the normal browser sign-in flow.

```json
{
  "redirect_path": "/account/access"
}
```

Common `redirect_path` values:

| Path | Destination |
| --- | --- |
| `/buckets` | Bucket dashboard. |
| `/library` | Library settings. |
| `/account/access` | Members, agents, and API keys. |
| `/pricing` | Plans and upgrades. |

### Bucket Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/v1/buckets` | List active buckets by default. Use `?archived=true` to list archived buckets. |
| `POST` | `/api/v1/buckets` | Create a bucket. |
| `GET` | `/api/v1/buckets/:id` | Read a bucket. |
| `PATCH` | `/api/v1/buckets/:id` | Update bucket metadata. |
| `POST` | `/api/v1/buckets/:id/archive` | Archive a normal unpublished bucket. |
| `POST` | `/api/v1/buckets/:id/unarchive` | Restore an archived normal bucket. |
| `DELETE` | `/api/v1/buckets/:id` | Permanently delete a normal archived unpublished bucket with confirmation. |
| `GET` | `/api/v1/tags` | List reusable bucket labels. |

#### GET /api/v1/buckets

```sh
curl -fsS "$REVDOKU_URL/api/v1/buckets" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

By default, this returns active buckets. To list archived buckets, call:

```sh
curl -fsS "$REVDOKU_URL/api/v1/buckets?archived=true" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Bucket list/detail responses include effective lifecycle action metadata:

| Field | Meaning |
| --- | --- |
| `website` | Current or latest website publication metadata, including `public_url`, `status`, `published`, and `lifecycle_active`. |
| `publication_lifecycle_active` | `true` when a publication is active enough to block archive/delete, even if the public artifacts are unavailable. |
| `archive.allowed` | Whether the current principal can archive now. |
| `archive.required_action` | `unpublish_first` when the bucket must be unpublished before archive. |
| `unarchive.allowed` | Whether the current principal can restore an archived bucket now. |
| `delete.allowed` | Whether the current principal can permanently delete now. |
| `delete.required_action` | `unpublish_first` when the bucket must be unpublished before permanent delete; `archive_first` when it must be archived before permanent delete. |
| `delete.confirmation` | Opaque internal confirmation token returned by the API; clients should pass it exactly to DELETE after human confirmation, not ask users to type bucket ids. |

Archived buckets are read-only until unarchived. Metadata edits, label changes,
file changes, direct upload targets, reference file uploads, thumbnail uploads,
bucket duplication, publication updates, and custom-domain mutations return
`BUCKET_ARCHIVED`. Read/list endpoints, unarchive, permanent delete, and
publication cleanup remain available when otherwise permitted. Copying files
out of an archived bucket is allowed when the caller has read access to the
source and write access to an active target bucket.

#### POST /api/v1/buckets

```json
{
  "bucket": {
    "title": "Marketing site",
    "description": "Generated launch assets",
    "tag_paths": ["website", "ai-agent"],
    "metadata": {
      "project": "marketing-site"
    }
  }
}
```

#### PATCH /api/v1/buckets/:id

```json
{
  "bucket": {
    "description": "Updated purpose",
    "metadata": {
      "run": "revision-2"
    }
  }
}
```

#### Archive, unarchive, and permanent delete

Library buckets cannot be archived, unarchived, or deleted. Normal buckets
with active published websites must be unpublished first. Permanent delete also
requires the bucket to be archived first.

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/buckets/bkt_.../archive" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/buckets/bkt_.../unarchive" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

Permanent delete requires an archived bucket and the opaque confirmation
token returned by `GET /api/v1/buckets` or `GET /api/v1/buckets/:id` in
`delete.confirmation`.

```sh
curl -fsS -X DELETE "$REVDOKU_URL/api/v1/buckets/bkt_..." \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{ "confirmation": "<delete.confirmation from bucket list/detail>" }'
```

UI and agent clients should ask users to confirm by bucket title or natural
language, then pass `delete.confirmation` internally.

Permanent deletion is **not** a bulk operation. Buckets must be
deleted one at a time via `DELETE /api/v1/buckets/:id` so each removal is
confirmed individually. The `POST /api/v1/buckets/bulk` endpoint accepts
only `archive` and `unarchive` operations and rejects `delete`.

### File Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/v1/buckets/:bucket_id/files` | List files. |
| `POST` | `/api/v1/buckets/:bucket_id/files` | Upload or attach a file. |
| `GET` | `/api/v1/buckets/:bucket_id/files/:id` | Read file metadata. |
| `GET` | `/api/v1/buckets/:bucket_id/files/:id/download` | Download file bytes. |
| `GET` | `/api/v1/buckets/:bucket_id/files/:id/text` | Read a text file. |
| `DELETE` | `/api/v1/buckets/:bucket_id/files/:id` | Delete a file. |
| `POST` | `/api/v1/buckets/:bucket_id/files/lock` | Lock by path. |
| `POST` | `/api/v1/buckets/:bucket_id/files/:id/lock` | Lock by file id. |
| `DELETE` | `/api/v1/buckets/:bucket_id/files/:id/lock` | Unlock a file. |
| `POST` | `/api/v1/direct_uploads` | Create a direct-upload URL. |

#### POST /api/v1/buckets/:bucket_id/files

Multipart upload:

```sh
curl -fsS "$REVDOKU_URL/api/v1/buckets/bkt_.../files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -F "path=assets/app.js" \
  -F "file=@dist/assets/app.js;type=application/javascript"
```

Attach an already uploaded blob:

```json
{
  "signed_blob_id": "...",
  "path": "assets/app.js",
  "name": "app.js"
}
```

#### POST /api/v1/buckets/:bucket_id/files/lock

```json
{
  "path": "index.html",
  "message": "Updating the landing page",
  "duration_seconds": 900
}
```

Active locks block writes and deletes by other API keys. Lock conflicts return
HTTP `423` with code `FILE_LOCKED`.

#### POST /api/v1/direct_uploads

Create an upload descriptor:

```json
{
  "bucket_id": "bkt_...",
  "path": "dist/index.html",
  "blob": {
    "filename": "index.html",
    "byte_size": 1234,
    "checksum": "BASE64_MD5",
    "content_type": "text/html",
    "sha256": "HEX_SHA256",
    "purpose": "bucket_file"
  }
}
```

Upload bytes to `data.direct_upload.url` using `data.direct_upload.headers`.
Then attach `data.signed_id` with `POST /api/v1/buckets/:bucket_id/files`.

### Version Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/v1/buckets/:id/versions` | List bucket versions. |
| `GET` | `/api/v1/buckets/:id/versions/:version_id` | Read one bucket version. |
| `POST` | `/api/v1/buckets/:id/versions/restore` | Restore a historical version. |
| `GET` | `/api/v1/buckets/:bucket_id/files/:id/versions` | List file versions. |
| `GET` | `/api/v1/buckets/:bucket_id/files/:id/versions/:version_id/content` | Download one file version. |

#### POST /api/v1/buckets/:id/versions/restore

```json
{
  "version_id": "bktrv_...",
  "comment": "Return to the first published draft"
}
```

Restore is non-destructive. Revdoku creates a new latest version linked to the
selected historical version.

### Publishing Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `POST` | `/api/v1/buckets/:id/publication` | Publish a bucket. |
| `DELETE` | `/api/v1/buckets/:id/publication` | Stop serving a bucket. |
| `GET` | `/api/v1/publications` | List public bucket links. |
| `GET` | `/api/v1/publications/:id` | Read one publication. |
| `PATCH` | `/api/v1/publications/:id` | Update publication settings. |
| `DELETE` | `/api/v1/publications/:id` | Revoke a publication. |
| `GET` | `/api/v1/publications/:id/manifest` | Read the published file manifest. |
| `POST` | `/api/v1/publish_sessions` | Create a publish session. |
| `POST` | `/api/v1/publish_sessions/:id/uploads/refresh` | Refresh upload URLs. |
| `POST` | `/api/v1/publish_sessions/:id/finalize` | Finalize a publish session. |

Archived buckets cannot be published, republished, direct-publish finalized,
or have publication settings updated until they are unarchived. Unpublish and
publication revoke endpoints remain available for cleanup.

#### POST /api/v1/buckets/:id/publication

```json
{
  "entrypoint": "index.html",
  "site_mode": "spa",
  "access_mode": "password",
  "regenerate_password": true,
  "permanent": true
}
```

Publication response fields:

| Field | Meaning |
| --- | --- |
| `public_url` | Same public website URL returned for users and agents. |
| `asset_base_url` | Direct public object-storage/CDN directory. |
| `public_slug` | Stable DNS-safe bucket publication slug. |
| `status` | `published`, `unpublished`, or another lifecycle status. |
| `permanent` | `true` when there is no expiration. |
| `expires_at` | Expiration timestamp for temporary publications. |
| `site_mode` | Whether deep links fall back to the entrypoint. |
| `access_mode` | `public` or `password`. Password-protected websites are a Pro entitlement. |
| `password_configured` | Whether a protected website password is configured. |
| `access_password` | Copyable stored password, returned only to account-owner publish keys. |
| `generated_password` | Newly generated password, returned only to account-owner publish keys. |
| `analytics.hits_all_time` | Cached all-time website hits; `null` when analytics numbers are hidden. |
| `analytics.last_event_at` | Latest recorded analytics event timestamp; `null` when hidden or not recorded yet. |

#### POST /api/v1/publish_sessions

Use this for larger folders and AI-generated websites.

```json
{
  "bucket_title": "Marketing site",
  "bucket_description": "Generated launch assets",
  "bucket_tag_paths": ["website", "ai-agent"],
  "entrypoint": "index.html",
  "site_mode": "spa",
  "access_mode": "password",
  "regenerate_password": true,
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
}
```

The response includes:

| Field | Meaning |
| --- | --- |
| `publish_session` | Session id, files, uploads, and status. |
| `publish_session.uploads` | Direct upload URLs for changed files only. |
| `finalize.url` | URL to finalize after uploads finish. |
| `deploy_summary` | Short user-facing deployment summary. |

If finalize returns `409` with `PUBLISH_SESSION_STALE`,
`PUBLISH_SESSION_EXPIRED`, or `PUBLISH_SESSION_NOT_PENDING`, recreate the
publish session from the same manifest and retry once.

### Custom Domain Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/v1/buckets/:bucket_id/custom_domains` | Read the bucket custom-domain state. |
| `POST` | `/api/v1/buckets/:bucket_id/custom_domains` | Create or replace a custom domain. |
| `GET` | `/api/v1/buckets/:bucket_id/custom_domains/:id` | Read one custom domain. |
| `POST` | `/api/v1/buckets/:bucket_id/custom_domains/:id/refresh` | Refresh DNS and certificate state. |
| `DELETE` | `/api/v1/buckets/:bucket_id/custom_domains/:id` | Remove a custom domain. |

#### POST /api/v1/buckets/:bucket_id/custom_domains

```json
{
  "hostname": "example.com"
}
```

Plan rules:

| Plan | Custom-domain behavior |
| --- | --- |
| Free | `max_custom_domains` is `0`; custom domains are disabled. |
| Paid | `max_custom_domains` equals the plan's max live public websites. |
| Downgrade | Domains above the new limit are disabled. On Free, all custom domains are disabled. |

Replacing a custom domain keeps the previous active domain serving until the new
domain becomes active.

### Analytics Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/v1/analytics?range=30d` | Account-wide publication analytics. |
| `GET` | `/api/v1/publications/:id/analytics?range=30d` | Analytics for one publication. |

#### GET /api/v1/analytics

Supported ranges are `7d`, `30d`, and `90d`.

Paid responses include:

| Field | Meaning |
| --- | --- |
| `first_event_at` | First recorded event timestamp in the selected range. |
| `last_event_at` | Last recorded event timestamp in the selected range. |
| `totals.hits_all_time` | Total recorded website hits. |
| `totals.hits` | Website hits in the selected range. |
| `totals.visitors` | Sum of daily unique visitors in the selected range. |
| `totals.hits_not_found` | Missing-path hits. |
| `totals.hits_bots` | Likely or known bot hits. |
| `daily` | Daily website hits and visitors. |
| `buckets` | Highest-traffic published buckets. |
| `paths` | Highest-traffic paths. |
| `referrers` | Referrer hosts, with `direct` for no referrer. |
| `countries` | Country codes. |
| `bots` | Bot hits grouped by bot name. |
| `paths_not_found` | Highest-traffic missing paths. |

Free responses hide numbers:

```json
{
  "data": {
    "range": "30d",
    "first_event_at": null,
    "last_event_at": null,
    "totals": {
      "hits_all_time": null,
      "hits": null,
      "visitors": null,
      "hits_not_found": null,
      "hits_bots": null
    },
    "daily": [],
    "buckets": [],
    "paths": [],
    "referrers": [],
    "countries": [],
    "bots": [],
    "paths_not_found": []
  }
}
```

## Common Errors

### Authentication Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `401` | `UNAUTHORIZED` | Missing, invalid, or expired API key. |
| `403` | `FORBIDDEN` | API key is valid but not allowed for this action. |

### Bucket and File Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `404` | `BUCKET_NOT_FOUND` | Bucket does not exist or is not visible to this key. |
| `404` | `FILE_NOT_FOUND` | File does not exist or is not visible to this key. |
| `403` | `LIBRARY_BUCKET_IMMUTABLE` | Library bucket cannot be archived, unarchived, or deleted. |
| `403` | `BUCKET_DELETE_ADMIN_REQUIRED` | Only an account administrator can permanently delete this bucket, except for empty archived unpublished cleanup buckets created by the same user. |
| `409` | `BUCKET_PUBLICATION_ACTIVE` | Unpublish this bucket before archiving or deleting it. |
| `409` | `BUCKET_ALREADY_ARCHIVED` | Bucket is already archived. |
| `409` | `BUCKET_NOT_ARCHIVED` | Bucket is not archived; archive it before permanent delete, or only unarchive archived buckets. |
| `422` | `BUCKET_DELETE_CONFIRMATION_REQUIRED` | Pass the opaque `delete.confirmation` value returned by bucket list/detail with the delete request. |
| `403` | `BUCKET_ARCHIVED` | Bucket is archived and cannot be edited until it is unarchived. |
| `423` | `FILE_LOCKED` | Another key owns an active file lock. |

### Publishing Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `403` | `PUBLICATION_LIMIT_REACHED` | Account is at the public-site limit. |
| `403` | `LIBRARY_BUCKET_PUBLISH_FORBIDDEN` | Library bucket cannot be published. |
| `409` | `PUBLISH_SESSION_STALE` | Publish session is out of date; recreate or refresh. |
| `410` | `PUBLISH_SESSION_EXPIRED` | Publish session expired; create a new one. |
| `503` | `PUBLIC_STORAGE_NOT_CONFIGURED` | Public publishing is not configured for this deployment. |

### Custom Domain Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `403` | `CUSTOM_DOMAIN_PLAN_REQUIRED` | Current plan has no custom domains. |
| `403` | `CUSTOM_DOMAIN_LIMIT_REACHED` | Account has reached its custom-domain limit. |
| `422` | `CUSTOM_DOMAIN_INVALID` | Hostname is invalid or already assigned. |
| `422` | `CUSTOM_DOMAIN_REQUIRES_PUBLICATION` | Publish the bucket before assigning a domain. |
| `503` | `CUSTOM_DOMAINS_NOT_CONFIGURED` | Deployment custom-domain support is not configured. |

## Integration Guidelines

### Keep Bucket URLs Stable

Republish the same bucket when updating a website. Revdoku keeps the same
`public_slug` and public URL across unpublish and republish.

### Prefer Publish Sessions for Agents

Agents publishing generated sites should use `POST /api/v1/publish_sessions` instead of
uploading every file manually. Publish sessions reuse unchanged files and return
a short `deploy_summary` that is easy to show to users.

### Surface Plan Limits Clearly

When the API returns a limit error, tell the user what happened and suggest the
least disruptive next action: unpublish an older site, remove an unused custom
domain, or open `/pricing` with a browser login link.

### Do Not Leak Secrets

Never print, paste, commit, or log `revdoku_...` API keys, one-time grant
tokens, direct-upload URLs, or browser login links.
