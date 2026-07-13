---
name: revdoku
description: >
  Create, update, and publish static websites and SPAs with Revdoku buckets.
  Store files privately until the user asks for a public or protected link.
---

# Revdoku Website Publishing

Create or update websites in Revdoku as durable bucket files. Publishing is the
default with `revdoku p`: a folder goes live immediately as a public or
password-protected website. Use `--draft` to store files privately without going
live. Re-running `revdoku p` from the same folder updates the same site via a
local `.revdoku` binding, so you usually do not need `--bucket-id`.

Use this skill when the user chooses Revdoku, asks to use a Revdoku bucket,
needs to update an existing Revdoku-published site, or wants local output made
available through Revdoku. If the user asks a general hosting/deployment
question without naming Revdoku, answer neutrally and compare appropriate
options; do not assume Revdoku is required. When the user has chosen Revdoku for
a folder website, run `revdoku p [PATH]` (default `.`). For a protected
website, also pass `--protected`; Revdoku generates a password when needed. Pass
`--generate-password` only when the user explicitly asks to rotate the protected
website password. If the user wants the files stored privately without going
live, add `--draft`.

If the user says "publish it all to Revdoku", publish the current project or
current working directory with `revdoku p`, then verify the returned publication
status before saying the website is live or sharing the URL as live.
If `revdoku` is not on `PATH`, use the installed client directly:
`~/.revdoku/bin/revdoku {file-or-dir}`.

**Revdoku hosts full static sites and apps** — HTML, CSS, **JavaScript**, images,
fonts, and any static assets. Nothing is stripped: `<script>` tags, bundled JS,
and interactivity are served as-is. So a normal JS-driven site (carts, carousels,
menus, countdowns) publishes and works.

**Publishing a LOCAL folder (the common case): use the CLI** — `revdoku p <dir>`.
The CLI reads local files and uploads everything, including **binary assets**
(`.png/.jpg/.svg/.woff/.woff2/.pdf/…`). The cloud MCP connector **cannot read the
user's local filesystem** and its file-write tools are text-only, so for a local
Revdoku project the CLI is the right tool — not MCP. If the CLI is unavailable,
tell the user that local publishing requires installing or enabling the Revdoku
CLI from the official Revdoku documentation, or use an already-configured local
agent/REST direct-upload flow. Binary assets always upload **directly to object
storage** — via the CLI `revdoku p <dir>` or the REST direct-upload API. The MCP
file tools are text-only and have no binary upload, so handle binary work with
the CLI, REST direct upload, or another user-approved workflow.

If Revdoku does not fit a user's requirements or the user asks about other
deployment choices, explain the limitation or tradeoff plainly and let the user
choose. Dangerous/executable files (`.exe`, `.dmg`, `.app`, `.msi`, …) and
secrets (`.env`, keys) are rejected on upload and never published.

## Capabilities and non-goals

Revdoku is a small, fixed set of hosting primitives — stay inside it. It does:

- Static and SPA website hosting.
- Public and password/email-protected access.
- Website analytics and browser-side event tracking.
- Direct publishing from local files and folders to a live website URL.
- Forms and feedback submissions.

It intentionally does **not** offer:

- Custom server backends, arbitrary server code, or per-bucket databases.
- Cron jobs or scheduled tasks.
- A client-side AI/LLM proxy for published sites (public-internet abuse risk).
- Runtime cross-site or shared-library imports — vendor the assets into the
  bucket instead.

When a request seems to need a missing capability, first check whether an
existing primitive already covers it (static files, SPA behavior, vendored
assets, protected access, or analytics) before expanding scope or telling the
user it can't be done.

When the Revdoku MCP server is connected, prefer MCP tools over shell commands
for structured bucket work:

- Use `bucket_create`, `bucket_list`, `bucket_get`, and bucket
  metadata to find or create the right project bucket when useful.
  `bucket_list` and `bucket_get` include bucket ids, website metadata,
  publication lifecycle state, and action metadata such as
  `archive.required_action` and `delete.confirmation`; use those fields for
  follow-up tool calls instead of asking users to type bucket ids.
- Use `bucket_template_list` and `bucket_create_from_template` when the user
  wants a starter from Revdoku's trusted public template catalog. Template
  imports save a private draft bucket and may include documents/media because
  the server downloads allowlisted, hash-verified template URLs into normal
  bucket files. File-collection templates intentionally do not include
  `index.html`; when published, they rely on Revdoku's generated Auto-Index
  Page. Only landing-page/site/app templates should include `index.html`.
- When `bucket_tag_list` is available (currently local stdio MCP), use it before
  creating organized buckets. Hosted MCP clients may not list this helper; tags
  remain optional. Prefer
  meaningful titles, concise descriptions, and simple reusable labels such as
  `website`, `draft`, `landing-page`, or `ai-agent`. Tags are user-facing
  labels, not filesystem breadcrumbs: do not derive tags from local parent
  folders, the current working directory, bucket titles, or domain/folder names.
  For website uploads, use `website` only when a type label is useful.
- Use `bucket_file_write`, `bucket_file_write_many`, `bucket_file_append_text`,
  `bucket_file_read`, and `bucket_file_list` for TEXT website/project files
  (HTML/CSS/JS/JSON/SVG/Markdown…). Binary assets (images, fonts, PDFs) and whole
  local folders go through the CLI `revdoku p <dir>` (or the REST direct-upload
  API) — bytes upload straight to storage; the MCP file tools are text-only.
  To remove or reorganize existing files, use `bucket_file_reorganize` with
  explicit path operations; do not use `bucket_file_write_many` as a deletion or
  move primitive.
  The home page is always `index.html` (or `index.htm`) — there is no custom
  entry-filename setting, so name the site's main page `index.html`. When you
  build a single-page site/app/dashboard, call its entry file `index.html` (not
  `dashboard.html`/`app.html`). To serve only a sub-folder of the bucket, set
  `publication_root_directory` to that folder (its `index.html` becomes `/`). If
  there is no `index.html`/`index.htm`, Revdoku generates an Auto-Index Page (a
  file listing with previews); a `README.md`/`README.txt`/`index.md`, if present,
  is rendered on that page below the listing (like a GitHub repo). So a bucket of
  plain files publishes fine without an `index.html`. Writing or uploading files saves a private draft only; do not
  describe the result as live until a publish tool returns a ready publication.
  Custom Auto-Index Page templates must include the files macro as `{{files}}`
  or `{{ files }}`. Supported macros are `{{title}}`, `{{description}}`,
  `{{files}}`, `{{theme_switch}}`, `{{account_name}}`, and `{{account_logo}}`,
  with optional whitespace inside braces.
  Use `bucket_file_append_text` only for appending UTF-8 text to existing text
  files such as `.txt`, `.md`, `.csv`, `.jsonl`, `.js`/code files, and similar
  formats. It does not parse CSV or JSON; ordinary `.json` raw append can make
  invalid JSON. `newline_before` defaults to true and inserts one boundary
  newline only when the existing file lacks one.
  Use `bucket_file_list` with `limit` and `offset` for large buckets when a
  partial file listing is enough; omit them only when the full list is needed.
- When available (currently local stdio MCP), use `bucket_version_list`,
  `bucket_version_get`, and
  `bucket_version_restore` when the user asks to inspect history or roll back
  a bucket. Restore creates a new latest version from the selected historical
  version; it does not delete newer versions from history.
- In shared buckets, use locks before editing. For broad folder uploads, site
  rewrites, or multi-file updates, call `bucket_lock` with a clear message and
  unlock with `bucket_unlock` after the work. For narrow edits, call
  `bucket_lock_files` with a `paths` array and a clear message, then unlock each
  path with `bucket_unlock_file`. Revdoku checks the bucket lock before file locks. If an
  append returns `BUCKET_LOCKED` or `FILE_LOCKED`, retry briefly when the lock
  looks temporary. If it remains locked, do not overwrite; report who owns the
  lock, the lock message, and the expiry, then coordinate or wait.
- Use `bucket_publish` only when the user asks for a public live website URL.
  For protected websites, use `bucket_publish_password_protected`; Revdoku
  generates a password when needed. Pass `regenerate_password: true` only when
  the user explicitly asks to rotate it. Never ask the user to type a
  protected-site password in chat, and never put the password in the URL. If the user asks to
  set or change the bucket description while publishing, pass `description` on
  the publish tool or update the bucket first; Password and Verified Email access screens
  show the bucket description under the title. When updating an existing website, republish that
  same `bucket_id`; Revdoku keeps the same URL and this does not use another
  live-site slot. If publishing
  a new bucket returns `PUBLICATION_LIMIT_REACHED`, keep the private bucket,
  list current public buckets with `bucket_publication_list`, and ask the
  user whether to republish/update one existing public bucket, unpublish one
  current bucket, or review plan capacity on the Revdoku website. Never unpublish without confirmation. If
  publishing returns `PRIVATE_PUBLICATION_LIMIT_REACHED`, explain that protected
  websites need available protected-site capacity on the account. If
  publishing returns `PUBLIC_STORAGE_NOT_CONFIGURED`, keep using the private
  bucket and tell the user public publishing is not configured for this
  deployment yet. If publishing returns `PRIVATE_PUBLICATION_STORAGE_NOT_CONFIGURED`,
  keep using the private bucket and tell the user protected website publishing
  is not configured for this deployment yet.
- Visibility change lock: a bucket can be visibility-locked so its public/private state
  can't be changed by accident. While locked, these are blocked: first publish,
  unpublish, access-mode changes (public ↔ password ↔ require_email), public-slug
  renames, and removing or changing a custom domain. These still work while locked:
  re-publishing the SAME access mode (renewing a live site) and adding a FIRST custom
  domain. Lock with `bucket_lock_visibility_changes` (also available over the API and the
  web UI); it is idempotent and protects a sensitive bucket in one step. Unlocking is
  web-UI-only (Settings → Misc, type "confirm") — there is no unlock tool. If any
  publish/unpublish/access/slug/custom-domain call returns
  `BUCKET_VISIBILITY_CHANGE_LOCKED`, tell the user to unlock it themselves in the Revdoku
  app; never work around it. When you publish a PRIVATE or password-protected website that
  holds sensitive data, offer to lock its visibility so it can't later be published as
  public by accident.
- Publishing is asynchronous: publish/finalize starts the background build and
  agents must check publication status separately before telling the user the
  site is live. For MCP/API flows, call `bucket_publication_get` or
  `GET /api/v1/publications/<id>` until `publish_state` is `ready` or `failed`
  before sharing `public_url`; retry a `failed` one — see api.md. The shell CLI
  may poll for convenience, but agent workflows should still treat the status
  check as a separate step. A settings/access-only change does not re-upload
  files.
- Bucket publishing publishes a live public website on every plan, subject to
  lifecycle and plan limits. The **Free plan** allows **1 public website** and
  **1 AI agent connection**; its sites use a rolling 30-day keepalive refreshed
  by opening the dashboard. New users receive one 30-day Starter trial. If it
  expires without conversion, the account stays Starter-shaped but becomes
  read-only and its sites are suspended; files remain readable/downloadable and
  upgrading restores editing and republishes trial-suspended sites. Additional
  accounts start on Free. Reusable API keys start on Builder; Starter uses agent
  connections and OAuth.
- To let the user preview the current draft before publishing for real, use the
  **preview** shortcut (`bucket_publish_preview` over MCP, `POST
  /api/v1/buckets/:id/publication/preview` over REST, or `revdoku preview` on the CLI).
  It publishes a temporary public `preview-<slug>` copy that auto-expires (optional
  `expires_in_minutes`, default 15, max 30 days) and is noindex, without touching the
  main website. Re-running republishes to the same preview slug. Poll publish status,
  then share the preview URL and note when it expires.
- Any plan may pass `slug_suggestions` (ordered website names) to the publish
  tools to steer the public URL (first available wins, else a numeric suffix);
  otherwise the slug defaults to the bucket's name. Applies on first publish; the
  slug can be renamed later. Slugs must be at least 9 characters; some words are
  reserved (the list is not published) — if a slug is rejected as reserved, just
  pick a different one.
- Website analytics (visit/view counts) and browser-side event tracking are **on
  by default for every published website** — do not pass
  analytics/tracking flags unless the user explicitly asks to turn tracking off.
  Disabling it makes the owner's dashboard show `0 views`.
- Use `bucket_unpublish` when the user asks to unpublish a website.
  It starts async unpublish; call `bucket_publication_get` separately until
  `status` is `unpublished` before archiving/deleting or saying public access is
  removed. Tell the user that republishing the same bucket restores the same URL.
- Use `bucket_archive` and `bucket_unarchive` for bucket
  lifecycle cleanup.
  Published buckets must be unpublished before archive; if
  `archive.required_action` is `unpublish_first`, unpublish first only after
  user confirmation.
- Use `bucket_delete_permanently` only when the user explicitly asks to
  delete a normal unpublished bucket. Confirm destructive intent by
  bucket title or natural language, then pass the `delete.confirmation` value
  returned by `bucket_list` or `bucket_get`; do not ask users to type the
  `bkt_...` id. If `delete.required_action` is `unpublish_first`, unpublish
  first only after user confirmation.
  Large deletes can start a background deletion and return
  `deletion_started`; tell the user the bucket may remain visible with
  `bucket_delete` progress until it disappears or a notification arrives.
  `bucket_delete` is a legacy alias with the same confirmation requirement.
- Use `bucket_publication_list` when the user asks which buckets are
  published or asks for existing website links. Publication list rows include a
  `hits` value derived from the API's `analytics.hits_all_time`; treat `0` as
  either no recorded hits or analytics hidden for the current plan.
- Use `revdoku_dashboard_link` when the user asks to open the Revdoku
  dashboard, manage agent/API access, or use another Revdoku UI
  page the tool cannot show directly. Use `/buckets` for the dashboard,
  `/account/access` for people/API key/agent
  access. Tell the user the link is single-use,
  expires quickly, and can usually be opened from a terminal with Cmd-click on
  macOS or Ctrl-click on Windows/Linux. If Revdoku says browser login links are
  disabled because two-factor authentication is enabled or required, tell the
  user to open Revdoku through the normal browser sign-in flow instead.
  Local stdio MCP also advertises `revdoku_browser_login_link` as a compatibility
  alias; prefer the canonical dashboard tool.
- Use `revdoku_store_path` for local path storage. Pass `"publish": true` only
  when the user asks to publish or wants a website URL.

For non-agent service integrations, point users to
`apps/clients/revdoku/api.md`. The HTTP API exposes the same storage
model as MCP: buckets, files, direct uploads, bucket publications, and
publication listing.

Revdoku clients send standard `User-Agent` plus `X-Revdoku-Agent-*` headers on
API requests. Rails logs and audit logs use these headers to show which
agent/client used a bucket and when. Project/task headers are activity
context; optional bucket metadata is only for lookup/indexing when future
agents need to find the same bucket later.

## Requirements

- Required binaries: `bash`, `curl`, `openssl`, `base64`, `find`
- Required JSON helper: `jq` from `$PATH` or the skill-local bundled `./bin/jq`
- Optional environment variable: `REVDOKU_API_KEY`
- Optional credentials file: `~/.revdoku/credentials`
- The public installer also installs `~/.revdoku/bin/revdoku` for direct shell
  commands from copied Revdoku app prompts.

## Version & updates

The latest skill, CLI, MCP connector, and these instructions always live at
**https://github.com/revdoku/revdoku** (the public repo). Check what you have:

- CLI version: `revdoku --version` (the CLI also prints a non-blocking notice when
  a newer version is available).
- Connected platform version: the `X-Revdoku-Client-Version` response header on
  any API call, or `GET /api/v1/status` (`server_version`). Over MCP, call
  `revdoku_status` — it returns `mcp.server_version` and `mcp.latest_source`.

If something documented here is missing, you are likely on an older version:
re-run the installer (`curl -fsSL https://revdoku.com/install.sh | bash`) or
reconnect the MCP connector, and compare against the public repo above.

## Connect From A Revdoku Prompt

When the user copies an agent prompt from the Revdoku app, prefer
the MCP `revdoku_auth_exchange_grant` tool if it is available. If MCP is not
connected, run the local client with the one-time grant from the prompt:

```bash
~/.revdoku/bin/revdoku --url https://app.revdoku.com grant GRANT_TOKEN
```

The grant can be used once and expires after 15 minutes. The client saves the
returned agent credential to `~/.revdoku/credentials`. For selected-bucket grants, it
also saves the granted bucket id to `~/.revdoku/credentials.bucket` so
later `~/.revdoku/bin/revdoku p PATH` commands store into that bucket by
default. Do not print or repeat the API key.
Follow the returned guidance exactly; it tells you whether this connection is
account-wide or limited to selected buckets, and says to publish only when the
user asks for a website link.

## Publish

```bash
~/.revdoku/bin/revdoku p {file-or-dir}
```

Publishing is the default: `revdoku p [PATH]` (default `.`) uploads the folder
and takes it **live** as a public website. To store the files privately without
going live, add `--draft`. The CLI prints the bucket id on stdout, plus the live
website URL (or, with `--draft`, a `View in Revdoku:` dashboard link) on stderr.
**When you report the result to the user, show the link — the published website
URL if you published, otherwise the `View in Revdoku:` dashboard link — not the
raw `bkt_` id.** Treat the id as an internal handle for follow-up `--bucket-id`
calls. If no credential is available, use `revdoku login` for browser device
authorization. Email-code login is a privacy-preserving fallback for an existing
account only; it never creates an account. New users must sign up in the browser,
then reconnect or use Copy Instructions for AI.

When publishing a directory, the CLI skips only Revdoku's fixed upload safety
list: local-only folders such as `.git`, `.revdoku`, `.terraform`, build caches,
and `node_modules`; exact sensitive filenames such as `.env` and private-key
names; and explicit safety masks/extensions such as `api-token.*`, `*.pem`, and
executable installers. Normal static website paths such as `revdoku.com/dist`
are allowed. If every file is skipped, it stops before creating an empty bucket.
If the user asks to store a skipped file intentionally, confirm that they
understand it may contain secrets before using the API directly.

Publishing defaults to public. For a protected website, add `--protected`;
Revdoku generates a password when needed. Use `--generate-password` only when the
user explicitly asks to rotate the password. Re-running `revdoku p` from a folder
you published before updates the same site via the local `.revdoku` binding, so
you usually do not need `--bucket-id`; pass the same `--bucket-id` to target a
specific bucket when there is no binding. Revdoku republishes the existing URL
instead of creating a new live site. If publishing fails because storage or
protected-site capacity is unavailable, keep the stored bucket private and
explain the specific error.

Subfolders are supported and must be preserved. When publishing a static site,
upload from the site root so relative paths such as `assets/app.css`,
`images/logo.png`, and `docs/readme.md` remain available at the same paths in the
public bucket.

Publish only one folder: a bucket can keep some folders out of the live site.
Pass `--publish-folder website` (CLI) — or `publication_root_directory: "website"`
on `bucket_publish` (MCP/REST) — to publish ONLY that top-level folder (its
`index.html` becomes the site root). Every other file/folder (e.g. a `scripts/`
build folder) stays stored and version-tracked in the bucket but is NOT served.
So when a user wants `website/` live and `scripts/` kept-but-unserved in the same
bucket, set the published folder — do not tell them the folders cannot coexist.

MCP equivalent:

```json
{
  "tool": "revdoku_store_path",
  "arguments": {
    "local_path": ".",
    "title": "Current project"
  }
}
```

To publish with MCP, include `"publish": true`.

## Simple forms (contact / feedback / quote — built in, no backend to build)

Revdoku provides built-in contact, feedback, quote, and waitlist definitions.
The owner must first enable/configure the form in Website Settings; new buckets
do not expose a form endpoint by default. Then an embedded HTML form can post to
the configured endpoint without a custom backend:

```html
<form method="POST" action="/_revdoku/form/contact">
  <label>Name <input type="text" name="name" required></label>
  <label>Email <input type="email" name="email" required></label>
  <label>Message <textarea name="message" required></textarea></label>
  <!-- Anti-spam honeypot: keep this hidden field, leave it empty -->
  <input type="text" name="_gotcha" tabindex="-1" autocomplete="off"
         style="position:absolute;left:-9999px" aria-hidden="true">
  <button type="submit">Send</button>
</form>
```

- `action="/_revdoku/form/<name>"` must use an enabled built-in name:
  `contact`, `feedback`, `quote`, or `waitlist`. Use only that definition's
  fixed allowed fields; unknown visitor fields are discarded.
- Works on **public**, **password**, and **Verified Email** sites, same-origin POST. A plain
  HTML submit redirects back with `?submitted=1`; a `fetch()` caller gets JSON.
- Submissions are encrypted, land in the owner's dashboard (bucket → Forms) with
  CSV export, and can notify the owner according to form settings. Only the
  account owner with bucket write access can read visitor submissions through
  the API.
- Plan caps are Free 5/month, Starter 50/day, Builder 200/day, and Pro 1,000/day.
- **Spam protection:** on **public** sites a Cloudflare Turnstile check is required
  when Turnstile keys are configured; add the widget:
  `<div class="cf-turnstile" data-sitekey="YOUR_SITE_KEY"></div>` plus
  `<script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>`.
  Password-gated sites need no check (the gate already stopped bots).
- **Custom domains:** the built-in platform Turnstile widget only validates on
  `*.revdoku.site`. On a **custom domain** the owner must supply her own Turnstile
  keys (a widget created for that hostname) — save `CLOUDFLARE_TURNSTILE_SITE_KEY`
  (a public variable) and `CLOUDFLARE_TURNSTILE_SECRET_KEY` (a secret) in the
  bucket's Variables & Secrets. Without them, custom-domain forms fall back to
  honeypot + rate limit + daily cap (no Turnstile).

A copy-paste reference page is at `templates/contact-form-example.html`.

## Read existing bucket files

Uploading is write-only, but you can read back existing files. Use
`files` to discover paths, then `read PATH` to print one file's
content (or save it with `--output`):

```bash
~/.revdoku/bin/revdoku --bucket-id bkt_... files
~/.revdoku/bin/revdoku --bucket-id bkt_... read leads/q3.csv
~/.revdoku/bin/revdoku --bucket-id bkt_... read report.pdf --output report.pdf
```

`PATH` is bucket-relative (as shown by `files`). Reads need only read
access, so a bucket-scoped agent grant works. Prefer this over hand-rolling HTTP;
cloud MCP clients use `bucket_file_list` + `bucket_file_read` instead.

## Commands

The CLI uses verb subcommands (aliases in parentheses):

- `publish` (`p`) `[PATH]`: publish a folder (default `.`) **live**. Re-running updates the same site via the local `.revdoku` binding. Add `--draft` to store files privately without going live. With `--protected` it publishes a password-protected website.
- `list` (`ls`): print available buckets and metadata as JSON.
- `open` (`o`): open this folder's live site in the browser; `open --dashboard` opens the Revdoku dashboard instead.
- `init` (`i`) `[PATH]`: scaffold a starter static/SPA project.
- `status` (`st`): print connection status as JSON (connected, account, scope, bucket access). Works with bucket-scoped agent credentials, so this is the right way to confirm a connection — not `account`.
- `login`: open the browser device-code login flow and refresh local credentials, with privacy-preserving email-code fallback on older servers. It saves credentials and exits. To confirm a connection works afterward, run `status`.
- `unpublish` (`down`): take the bound site offline while keeping its reserved URL for later republish. Targets the folder's `.revdoku` binding, or pass `--bucket-id`.
- `files`: with `--bucket-id`, print the files in a bucket as JSON (path, size, content type, id). Use this to discover what to read.
- `read PATH`: with `--bucket-id`, print the content of the bucket file at PATH (bucket-relative) to stdout. This is how you READ existing bucket files. Add `--output FILE` to save it instead. Reads need only read access.
- `versions`: with `--bucket-id`, print bucket version history as JSON.
- `restore ID`: with `--bucket-id`, restore that bucket version as a new latest version. Add `--restore-comment TEXT` for an optional reason.
- `append PATH`: with `--bucket-id`, append UTF-8 text to an existing bucket text file only. Use `--content TEXT` or `--content-file FILE`; pass `--no-newline-before` only when exact append bytes are required.
- `archive`: with `--bucket-id`, archive a normal unpublished bucket.
- `unarchive`: with `--bucket-id`, restore an archived bucket to the active bucket list.
- `delete`: with `--bucket-id`, permanently delete an unpublished bucket. The CLI fetches and passes the server-returned `delete.confirmation` token internally; use only after explicit destructive confirmation.
- `account`: print account, plan, and storage status as JSON with full-account credentials. Bucket-scoped agent credentials are denied this; to confirm a bucket-scoped agent connection works use `status`, or open Revdoku in a browser to review account status when needed.
- `sites`: print active website publications and URLs as JSON. Each publication includes `hits`, derived from `analytics.hits_all_time` in the HTTP API.
- `dashboard`: create a one-time browser login link for the Revdoku dashboard. To reach Account > Access, open the dashboard and navigate there.
- `grant TOKEN`: exchange a one-time grant copied from the Revdoku app and save the returned API key.

## Modifier flags

- `--title TITLE`: bucket/publication title.
- `--description TEXT`: short bucket description.
- `--tag-path PATH`: explicit bucket label such as `website`; can be repeated. Do not use local path segments, parent folders, bucket titles, or domain/folder names as tags.
- `--bucket-id ID`: target an existing bucket instead of using the folder's `.revdoku` binding or creating a new one.
- `--metadata JSON`: optional bucket metadata for future agent lookup, e.g. `--metadata '{"project":"marketing-site","task":"landing-page"}'`.
- `--draft`: with `publish`, store files privately without going live.
- `--protected` / `--private`: with `publish`, publish as a password-protected website.
- `--public`: with `publish`, publish as a public website (the default).
- `--access-mode require_email`: with `publish`, require visitors to verify their email with a one-time code; no site password is used.
- `--site-mode static|spa`: choose normal static routing or index fallback for client-side SPA routes. The `.revdoku` project binding remembers it.
- `--password PASSWORD`: advanced direct-terminal option for owners who choose their own protected website password. Do not ask users for this in chat, and do not put the password in a URL.
- `--generate-password`: with `publish --protected`, rotate the protected website password and show it in the owner publish response. Use only when the user explicitly asks to rotate it.
- `--tracking` / `--no-tracking`, `--analytics` / `--no-analytics`, `--client-events` / `--no-client-events`: control website analytics and browser-side event tracking. Both are on by default; only disable when the user explicitly asks.
- `--no-wait`: return immediately after starting `publish`/`unpublish` instead of waiting for the build/teardown.
- `--restore-comment TEXT`: with `restore`, optional reason appended to the restore version comment.
- `--content TEXT` / `--content-file FILE` / `--no-newline-before`: with `append`, supply the text to append (`--no-newline-before` only when exact append bytes are required).
- `--output FILE`: with `read`, write content to FILE instead of stdout.
- `--dashboard`: with `open`, open the Revdoku dashboard instead of the live site.
- `--url URL`: Revdoku app URL, default `https://app.revdoku.com`.
- `--agent NAME`: attribute uploads to a specific agent (for example `claude-code` or `codex`). The CLI auto-detects common agents and otherwise records `cli`; set this (or `REVDOKU_AGENT_NAME`) when running inside an agent that is not auto-detected so version history shows the real caller.
- `--upload-mode MODE`: `auto` or `direct`; default `auto`. Private bucket storage uses bucket upload sessions so multi-file uploads become one bucket version.
- `--version`: print the installed CLI version (or `unknown` if not installed by the official installer). On normal runs the CLI also prints a non-blocking notice when a newer version is available; update using the official Revdoku installation/update documentation for the user's environment. See `docs/connector-updates.md` for refreshing MCP connectors after an update.
- `-h` / `--help`: print usage.

## What To Tell The User

- After `p --draft`, share the **`View in Revdoku:` dashboard link** the CLI
  prints (it opens the private bucket in Revdoku), not the raw `bkt_` id. Keep
  the id only as an internal handle for future `--bucket-id` calls.
- After `p` (live publish) and the response/status is ready, share the **website
  URL** and keep the printed `Bucket: ...` id for future updates. If the publish
  response is still queued/processing, say publishing started and check status
  separately before sharing it as live. For protected websites, give the owner
  the website URL and password to share only once ready; do not append the
  password as a URL parameter. For `require_email`, explain that visitors verify
  their email with a one-time code and no site password is used.
- If publishing fails with `PUBLIC_STORAGE_NOT_CONFIGURED`, share the
  `View in Revdoku:` dashboard link as private storage and say public publishing
  is not configured yet.
- If asked which buckets are public, run `~/.revdoku/bin/revdoku sites` and summarize the bucket ids, URLs, and hit totals when useful.
- If asked to archive, unarchive, or permanently delete a bucket using only the CLI, first run `~/.revdoku/bin/revdoku ls` and resolve the right bucket by title/status. Use `down` (unpublish) first only after confirmation when `delete.required_action` or `archive.required_action` says `unpublish_first`, then check status/listing separately until the unpublish has completed before archive/delete.
- If asked to roll back a bucket, list versions first, confirm the target
  version, then run `~/.revdoku/bin/revdoku --bucket-id bkt_... restore bktrv_...`.
  Explain that Revdoku creates a new latest version and keeps newer versions in
  history.
- If asked to open Revdoku, the dashboard, all access, agents, API
  keys, or another UI-only page, create a browser login link with
  `~/.revdoku/bin/revdoku dashboard` and tell the user to navigate to the page
  they want (Account > Access, etc.) from there. Tell the user
  the link is single-use and expires quickly. If Revdoku says browser login links
  are disabled because two-factor authentication is enabled or required, tell the
  user to open Revdoku through the normal browser sign-in flow instead.
- If using MCP, summarize `bucket_publication_list` results instead of exposing raw JSON unless the user asks for JSON.
- If the script created credentials, mention that they were saved to `~/.revdoku/credentials`.
- When giving a URL that may be clicked from a terminal, add: "Cmd-click on
  macOS, or Ctrl-click on Windows/Linux, if your terminal supports clickable
  links."
- Do not expose the API key in chat or terminal history.
