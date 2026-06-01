# Revdoku API

Use the Revdoku API to create workspaces, store files, publish static websites,
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
    "id": "wrk_..."
  }
}
```

Errors are wrapped in `error`:

```json
{
  "error": {
    "message": "Workspace not found",
    "code": "WORKSPACE_NOT_FOUND",
    "request_id": "req_...",
    "docs_url": "https://revdoku.com/api.md"
  }
}
```

Use `error.code` for recovery logic. Use `request_id` when debugging with
support.

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
    "workspace_access": "all"
  }'
```

Store the returned `data.api_key` securely. Follow `data.guidance` when the
server includes it. Do not print or log the key.

### Create a Workspace

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "workspace": {
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
    "id": "wrk_...",
    "title": "Marketing site",
    "published": false
  }
}
```

### Upload a File

Multipart upload is easiest for small and medium files:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -F "relative_path=index.html" \
  -F "file=@dist/index.html;type=text/html"
```

Uploading the same `relative_path` creates a new version of that file.

### Publish a Workspace

Publish explicitly when the workspace should have a public URL:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../publish" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "entrypoint": "index.html",
    "site_type": "spa",
    "permanent": true
  }'
```

Example response:

```json
{
  "data": {
    "id": "pub_...",
    "workspace_id": "wrk_...",
    "public_id": "bright-canvas-a7k2",
    "url": "https://bright-canvas-a7k2.revdoku.site/",
    "public_url": "https://bright-canvas-a7k2.revdoku.site/",
    "managed_url": "https://bright-canvas-a7k2.revdoku.site/",
    "active": true,
    "permanent": true
  }
}
```

Use `site_type: "static"` for ordinary static sites. Use `site_type: "spa"` for
React/Vite-style apps where deep links should fall back to `index.html`.

### Publish a Folder Efficiently

Use publish sessions for larger folders. Revdoku compares file hashes, uploads
only changed bytes, then finalizes the publication.

Create the session:

```sh
curl -fsS "$REVDOKU_URL/api/v1/publish" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "workspace_title": "Marketing site",
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

Upload each file to `data.publish_session.uploads[].upload.url` using exactly
the returned upload headers. Do not send Revdoku auth headers to object-storage
upload URLs.

Finalize the session:

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/publish/pus_.../finalize" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

If an upload URL expires, refresh it:

```sh
curl -fsS -X POST "$REVDOKU_URL/api/v1/publish/pus_.../uploads/refresh" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

### Add a Custom Domain

Custom domains are available on paid plans. Publish the workspace first.

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../custom_domains" \
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
      "public_url": "https://bright-canvas-a7k2.revdoku.site/"
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
curl -fsS -X POST "$REVDOKU_URL/api/v1/workspaces/wrk_.../custom_domains/pcd_.../refresh" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

When active, the publication `url` and `public_url` switch to the custom domain.
The managed `https://<workspace-slug>.revdoku.site/` URL keeps working.

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
    "analyticsStartedAt": "2026-05-22T00:00:00.000Z",
    "lastEventAt": "2026-05-26T18:32:14.000Z",
    "totals": {
      "allTimeViews": 8420,
      "rangeViews": 1204,
      "rangeVisitors": 822,
      "assetHits": 330,
      "notFoundHits": 18,
      "botHits": 91
    },
    "series": [
      { "bucket": "2026-05-26", "views": 120, "visitors": 84 }
    ],
    "topReferrers": [
      { "referrer": "Direct", "views": 420 }
    ],
    "topCountries": [
      { "country": "US", "views": 510 }
    ],
    "topCrawlers": [
      { "crawler": "GPTBot", "hits": 91 }
    ]
  }
}
```

`rangeVisitors` is a sum of each day's unique visitor count, not a global unique
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
  "workspace_access": "all"
}
```

For selected-workspace access, use:

```json
{
  "workspace_access": "selected",
  "workspace_ids": ["wrk_..."],
  "workspace_permissions": {
    "wrk_...": "write"
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

```json
{
  "redirect_path": "/account/access"
}
```

Common `redirect_path` values:

| Path | Destination |
| --- | --- |
| `/workspaces` | Workspace dashboard. |
| `/library` | Library settings. |
| `/account/access` | Members, agents, and API keys. |
| `/pricing` | Plans and upgrades. |

### Workspace Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/v1/workspaces` | List workspaces. |
| `POST` | `/api/v1/workspaces` | Create a workspace. |
| `GET` | `/api/v1/workspaces/:id` | Read a workspace. |
| `PATCH` | `/api/v1/workspaces/:id` | Update workspace metadata. |
| `DELETE` | `/api/v1/workspaces/:id` | Archive a workspace. |
| `GET` | `/api/v1/tags` | List reusable workspace labels. |

#### GET /api/v1/workspaces

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

#### POST /api/v1/workspaces

```json
{
  "workspace": {
    "title": "Marketing site",
    "description": "Generated launch assets",
    "tag_paths": ["website", "ai-agent"],
    "metadata": {
      "project": "marketing-site"
    }
  }
}
```

#### PATCH /api/v1/workspaces/:id

```json
{
  "workspace": {
    "description": "Updated purpose",
    "metadata": {
      "run": "revision-2"
    }
  }
}
```

### File Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/v1/workspaces/:workspace_id/files` | List files. |
| `POST` | `/api/v1/workspaces/:workspace_id/files` | Upload or attach a file. |
| `GET` | `/api/v1/workspaces/:workspace_id/files/:id` | Read file metadata. |
| `GET` | `/api/v1/workspaces/:workspace_id/files/:id/download` | Download file bytes. |
| `GET` | `/api/v1/workspaces/:workspace_id/files/:id/text` | Read a text file. |
| `DELETE` | `/api/v1/workspaces/:workspace_id/files/:id` | Delete a file. |
| `POST` | `/api/v1/workspaces/:workspace_id/files/lock` | Lock by path. |
| `POST` | `/api/v1/workspaces/:workspace_id/files/:id/lock` | Lock by file id. |
| `DELETE` | `/api/v1/workspaces/:workspace_id/files/:id/lock` | Unlock a file. |
| `POST` | `/api/v1/direct_uploads` | Create a direct-upload URL. |

#### POST /api/v1/workspaces/:workspace_id/files

Multipart upload:

```sh
curl -fsS "$REVDOKU_URL/api/v1/workspaces/wrk_.../files" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -F "relative_path=assets/app.js" \
  -F "file=@dist/assets/app.js;type=application/javascript"
```

Attach an already uploaded blob:

```json
{
  "signed_blob_id": "...",
  "relative_path": "assets/app.js",
  "name": "app.js"
}
```

#### POST /api/v1/workspaces/:workspace_id/files/lock

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
}
```

Upload bytes to `data.direct_upload.url` using `data.direct_upload.headers`.
Then attach `data.signed_id` with `POST /api/v1/workspaces/:workspace_id/files`.

### Version Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/api/v1/workspaces/:id/versions` | List workspace versions. |
| `GET` | `/api/v1/workspaces/:id/versions/:version_id` | Read one workspace version. |
| `POST` | `/api/v1/workspaces/:id/rollback` | Restore a historical version. |
| `GET` | `/api/v1/workspaces/:workspace_id/files/:id/versions` | List file versions. |
| `GET` | `/api/v1/workspaces/:workspace_id/files/:id/versions/:version_id/content` | Download one file version. |

#### POST /api/v1/workspaces/:id/rollback

```json
{
  "version_id": "wrkrv_...",
  "comment": "Return to the first published draft"
}
```

Rollback is non-destructive. Revdoku creates a new latest version linked to the
selected historical version.

### Publishing Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `POST` | `/api/v1/workspaces/:id/publish` | Publish a workspace. |
| `POST` | `/api/v1/workspaces/:id/unpublish` | Stop serving a workspace. |
| `GET` | `/api/v1/publications` | List public workspace links. |
| `GET` | `/api/v1/publications/:id` | Read one publication. |
| `PATCH` | `/api/v1/publications/:id` | Update publication settings. |
| `DELETE` | `/api/v1/publications/:id` | Revoke a publication. |
| `GET` | `/api/v1/publications/:id/manifest` | Read the published file manifest. |
| `POST` | `/api/v1/publish` | Create a publish session. |
| `POST` | `/api/v1/publish/:id/uploads/refresh` | Refresh upload URLs. |
| `POST` | `/api/v1/publish/:id/finalize` | Finalize a publish session. |

#### POST /api/v1/workspaces/:id/publish

```json
{
  "entrypoint": "index.html",
  "site_type": "spa",
  "permanent": true
}
```

Publication response fields:

| Field | Meaning |
| --- | --- |
| `url` | Best share URL. Custom domain when active, otherwise managed URL. |
| `public_url` | Same public website URL returned for users and agents. |
| `managed_url` | Stable `*.revdoku.site` URL when configured. |
| `asset_base_url` | Direct public object-storage/CDN directory. |
| `public_id` | Stable DNS-safe workspace publication slug. |
| `active` | Whether the publication currently serves. |
| `permanent` | `true` when there is no expiration. |
| `expires_at` | Expiration timestamp for temporary publications. |
| `spa_mode` | Whether deep links fall back to the entrypoint. |

#### POST /api/v1/publish

Use this for larger folders and AI-generated websites.

```json
{
  "workspace_title": "Marketing site",
  "workspace_description": "Generated launch assets",
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
| `GET` | `/api/v1/workspaces/:workspace_id/custom_domains` | Read the workspace custom-domain state. |
| `POST` | `/api/v1/workspaces/:workspace_id/custom_domains` | Create or replace a custom domain. |
| `GET` | `/api/v1/workspaces/:workspace_id/custom_domains/:id` | Read one custom domain. |
| `POST` | `/api/v1/workspaces/:workspace_id/custom_domains/:id/refresh` | Refresh DNS and certificate state. |
| `DELETE` | `/api/v1/workspaces/:workspace_id/custom_domains/:id` | Remove a custom domain. |

#### POST /api/v1/workspaces/:workspace_id/custom_domains

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
| `totals.allTimeViews` | Total recorded page views. |
| `totals.rangeViews` | Page views in the selected range. |
| `totals.rangeVisitors` | Sum of daily unique visitors in the selected range. |
| `totals.assetHits` | Static asset hits. |
| `totals.notFoundHits` | 404 hits. |
| `totals.botHits` | Likely or known crawler hits. |
| `series` | Daily views and visitors. |
| `topSites` | Highest-traffic publication slugs. |
| `topPaths` | Highest-traffic paths. |
| `topReferrers` | Top referrer hosts, with `Direct` for no referrer. |
| `topCountries` | Top country codes. |
| `topCrawlers` | Known crawler hits. |
| `top404Paths` | Highest-traffic missing paths. |

Free responses hide numbers:

```json
{
  "data": {
    "analyticsStartedAt": null,
    "lastEventAt": null,
    "analytics": {
      "access": "locked",
      "locked": true,
      "redacted": true,
      "upgrade_required": true,
      "value_label": "[hidden]"
    },
    "totals": {
      "allTimeViews": null,
      "rangeViews": null
    },
    "series": []
  }
}
```

## Common Errors

### Authentication Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `401` | `UNAUTHORIZED` | Missing, invalid, or expired API key. |
| `403` | `FORBIDDEN` | API key is valid but not allowed for this action. |

### Workspace and File Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `404` | `WORKSPACE_NOT_FOUND` | Workspace does not exist or is not visible to this key. |
| `404` | `FILE_NOT_FOUND` | File does not exist or is not visible to this key. |
| `423` | `FILE_LOCKED` | Another key owns an active file lock. |

### Publishing Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `403` | `PUBLICATION_LIMIT_REACHED` | Account is at the public-site limit. |
| `403` | `LIBRARY_WORKSPACE_PUBLISH_FORBIDDEN` | Library workspace cannot be published. |
| `409` | `PUBLISH_SESSION_STALE` | Publish session is out of date; recreate or refresh. |
| `410` | `PUBLISH_SESSION_EXPIRED` | Publish session expired; create a new one. |
| `503` | `PUBLIC_STORAGE_NOT_CONFIGURED` | Public publishing is not configured for this deployment. |

### Custom Domain Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `403` | `CUSTOM_DOMAIN_PLAN_REQUIRED` | Current plan has no custom domains. |
| `403` | `CUSTOM_DOMAIN_LIMIT_REACHED` | Account has reached its custom-domain limit. |
| `422` | `CUSTOM_DOMAIN_INVALID` | Hostname is invalid or already assigned. |
| `422` | `CUSTOM_DOMAIN_REQUIRES_PUBLICATION` | Publish the workspace before assigning a domain. |
| `503` | `CUSTOM_DOMAINS_NOT_CONFIGURED` | Deployment custom-domain support is not configured. |

## Integration Guidelines

### Keep Workspace URLs Stable

Republish the same workspace when updating a website. Revdoku keeps the same
`public_id` and managed URL across unpublish and republish.

### Prefer Publish Sessions for Agents

Agents publishing generated sites should use `POST /api/v1/publish` instead of
uploading every file manually. Publish sessions reuse unchanged files and return
a short `deploy_summary` that is easy to show to users.

### Surface Plan Limits Clearly

When the API returns a limit error, tell the user what happened and suggest the
least disruptive next action: unpublish an older site, remove an unused custom
domain, or open `/pricing` with a browser login link.

### Do Not Leak Secrets

Never print, paste, commit, or log `revdoku_...` API keys, one-time grant
tokens, direct-upload URLs, or browser login links.
