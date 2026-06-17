---
name: revdoku
description: >
  Create, update, and publish websites with Revdoku buckets — including
  interactive app sites backed by a per-bucket server database (visitor
  submissions, voting/feedback dashboards, searchable support sites, owner
  notifications), not just static pages. Store files privately until the user
  asks for a public or protected link.
---

# Revdoku Website Publishing

Create or update websites in Revdoku as durable bucket files. A bucket stores
files privately first as a saved draft and can be published or republished as a
live public or password-protected website.

Revdoku is **not static-only**: a bucket can also publish an **interactive app
site backed by a per-bucket server database** (visitor submissions, voting /
feedback dashboards, searchable support sites, owner notifications) with safe
actions at `/_revdoku/app/<name>`. When the user asks for shared/multi-visitor
data, build that real backend — see "App websites with a database" below — and
do **not** fall back to browser `localStorage`.

Use this skill when the user asks to publish, host, deploy, share on the web,
create a public or protected website, upload, save, store, share through a
bucket, or make local output available to other agents through Revdoku. If the
user asks to publish, host, deploy, share on the web, or make a folder available
as a website, pass `--publish`. For a protected website, also pass
`--protected`; Revdoku generates a password when needed. Pass
`--generate-password` only when the user explicitly asks to rotate the protected
website password.

If the user says "publish it all to Revdoku", publish the current project or
current working directory with `--publish`, then return the website URL printed
by the script.

When the Revdoku MCP server is connected, prefer MCP tools over shell commands
for structured bucket work:

- Use `bucket_create`, `bucket_list`, `bucket_get`, and bucket
  metadata to find or create the right project bucket when useful.
  `bucket_list` and `bucket_get` include bucket ids, website metadata,
  publication lifecycle state, and action metadata such as
  `archive.required_action` and `delete.confirmation`; use those fields for
  follow-up tool calls instead of asking users to type bucket ids.
- Use `bucket_tag_list` before creating organized buckets. Prefer
  meaningful titles, concise descriptions, and simple reusable labels such as
  `website`, `draft`, `landing-page`, or `ai-agent`. Tags are user-facing
  labels, not filesystem breadcrumbs: do not derive tags from local parent
  folders, the current working directory, bucket titles, or domain/folder names.
  For website uploads, use `website` only when a type label is useful.
- Use `bucket_write_file`, `bucket_file_append_text`, `bucket_upload_file`,
  `bucket_read_file`, and `bucket_delete_file` for website/project file operations. Use
  `index.html` as the default website root unless the user asks for another
  entrypoint. A bucket of plain files with no `index.html` still publishes:
  Revdoku auto-generates an Auto-Index Page (a file listing with previews,
  README-aware), so do not author an `index.html` for a plain file
  bucket unless the user wants a custom landing page. Writing or uploading files saves a private draft only; do not
  describe the result as live until a publish tool returns a ready publication.
  Custom Auto-Index Page templates must include the files macro as `{{files}}`
  or `{{ files }}`. Supported macros are `{{title}}`, `{{description}}`,
  `{{files}}`, and `{{theme_switch}}`, with optional whitespace inside braces.
  Use `bucket_file_append_text` only for appending UTF-8 text to existing text
  files such as `.txt`, `.md`, `.csv`, `.jsonl`, `.js`/code files, and similar
  formats. It does not parse CSV or JSON; ordinary `.json` raw append can make
  invalid JSON. `newline_before` defaults to true and inserts one boundary
  newline only when the existing file lacks one.
  Use `bucket_file_list` with `limit` and `offset` for large buckets when a
  partial file listing is enough; omit them only when the full list is needed.
- Use `bucket_version_list`, `bucket_version_get`, and
  `bucket_version_restore` when the user asks to inspect history or roll back
  a bucket. Restore creates a new latest version from the selected historical
  version; it does not delete newer versions from history.
- In shared buckets, use locks before editing. For broad folder uploads, site
  rewrites, or multi-file updates, call `bucket_lock` with a clear message and
  unlock with `bucket_unlock` after the work. For narrow edits, call
  `bucket_lock_files` with `path`, `file_id`, or `mask`, then unlock with
  `bucket_unlock_file`. Revdoku checks the bucket lock before file locks. If an
  append returns `BUCKET_LOCKED` or `FILE_LOCKED`, retry briefly when the lock
  looks temporary. If it remains locked, do not overwrite; report who owns the
  lock, the lock message, and the expiry, then coordinate or wait.
- Use `bucket_publish` only when the user asks for a public live website URL.
  For protected websites, use `bucket_publish_password_protected`; Revdoku
  generates a password when needed. Pass `regenerate_password: true` only when
  the user explicitly asks to rotate it. Never ask the user to type a
  protected-site password in chat, and never put the password in the URL. If the user asks to
  set or change the bucket description while publishing, pass `description` on
  the publish tool or update the bucket first; password and password+email gates
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
- Publishing is asynchronous: the publish/finalize tools wait until the site is
  live before returning its URL (large folders no longer time out), and a
  settings/access-only change does not re-upload files. Direct API callers poll
  `GET /api/v1/publications/<id>` for `publish_state: "ready"` before sharing
  `public_url`, and can retry a `failed` one — see api.md.
- Bucket publishing creates a normal live website and does not set an expiration.
  Do not describe the current publish flow as a preview. Temporary preview
  deployments are a separate future concept, not the bucket publish flow.
- Public websites are not listed in `revdoku.com/featured` by default. Ask the
  owner before opting in with `featured_on_community: true` or
  `--feature-on-community`. For an already-published website, use
  `bucket_update_publication_settings` or `revdoku --bucket-id ... --feature-on-community`;
  do not republish only to change this setting.
- Any plan may pass `slug_suggestions` (ordered website names) to the publish
  tools to steer the public URL (first available wins, else a numeric suffix);
  otherwise the slug defaults to the bucket's name. Applies on first publish; the
  slug can be renamed later.
- Website analytics (visit/view counts) and browser-side event tracking are **on
  by default for every published website, including app sites** — do not pass
  analytics/tracking flags unless the user explicitly asks to turn tracking off.
  Disabling it makes the owner's dashboard show `0 views`.
- Use `bucket_unpublish` when the user asks to unpublish a website.
  Tell the user that republishing the same bucket restores the same URL.
- Use `bucket_archive` and `bucket_unarchive` for normal bucket
  lifecycle cleanup. Library buckets cannot be archived or unarchived.
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
- Use `revdoku_browser_login_link` when the user asks to open the Revdoku
  dashboard, manage agent/API access, or use another Revdoku UI
  page the tool cannot show directly. Use `/buckets` for the dashboard,
  `/library` for Library settings, `/account/access` for people/API key/agent
  access. Tell the user the link is single-use,
  expires quickly, and can usually be opened from a terminal with Cmd-click on
  macOS or Ctrl-click on Windows/Linux. If Revdoku says browser login links are
  disabled because two-factor authentication is enabled or required, tell the
  user to open Revdoku through the normal browser sign-in flow instead.
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

## Connect From A Revdoku Prompt

When the user copies an agent prompt from the Revdoku app, prefer
the MCP `revdoku_auth_exchange_grant` tool if it is available. If MCP is not
connected, run the local client with the one-time grant from the prompt:

```bash
~/.revdoku/bin/revdoku --url https://app.revdoku.com --exchange-grant GRANT_TOKEN
```

The grant can be used once and expires after 15 minutes. The client saves the
returned API key to `~/.revdoku/credentials`. For selected-bucket grants, it
also saves the granted bucket id to `~/.revdoku/credentials.bucket` so
later `~/.revdoku/bin/revdoku PATH` commands store into that bucket by
default. Do not print or repeat the API key.
Follow the returned guidance exactly; it tells you whether this connection is
account-wide or limited to selected buckets, reminds you that the Library is
read-only by default, and says to publish only when the user asks for a website
link.

## Store

```bash
~/.revdoku/bin/revdoku {file-or-dir}
```

The CLI stores files privately and prints the bucket id on stdout, plus a
`View in Revdoku:` dashboard link (and, after `--publish`, the live website URL)
on stderr. **When you report the result to the user, show the link — the
published website URL if you published, otherwise the `View in Revdoku:`
dashboard link — not the raw `bkt_` id.** Treat the id as an internal handle for
follow-up `--bucket-id` calls. If no API key is
available, run it interactively; it asks for the user's email, sends a
verification code, saves the returned key to `~/.revdoku/credentials`, then
reuses it on future runs. If Revdoku rejects a disposable or blocked email
address, ask for a permanent email address and retry.

When storing a directory, the CLI skips only Revdoku's fixed upload safety list:
local-only folders such as `.git`, `.revdoku`, `.terraform`, build caches, and
`node_modules`; exact sensitive filenames such as `.env` and private-key names;
and explicit safety masks/extensions such as `api-token.*`, `*.pem`, and
executable installers. Normal static website paths such as `revdoku.com/dist`
are allowed. If every file is skipped, it stops before creating an empty bucket.
If the user asks to store a skipped file intentionally, confirm that they
understand it may contain secrets before using the API directly.

To publish, pass `--publish`; publishing defaults to public. For a protected
website, add `--protected`; Revdoku generates a password when needed. Use
`--generate-password` only when the user explicitly asks to rotate the password.
To update an existing website, pass the same
`--bucket-id`; Revdoku republishes the existing URL instead of creating a new
live site. If publishing fails because storage or protected-site capacity is
unavailable, keep the stored bucket private and explain the specific error.

Subfolders are supported and must be preserved. When publishing a static site,
upload from the site root so relative paths such as `assets/app.css`,
`images/logo.png`, and `docs/readme.md` remain available at the same paths in the
public bucket.

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

## App websites with a database (real backend — do not use local storage)

A bucket can publish an interactive app website backed by a bucket-owned server
database (Cloudflare D1) with owner-defined named actions at
`/_revdoku/app/<name>`. Use this for any shared/multi-visitor data: voting and
feedback dashboards, suggestion boards, searchable support sites, shared prompt
libraries, research/link feeds. **When the user wants visitors to submit, vote,
search, or be counted, build this backend — never substitute browser
`localStorage`.**

Two ways to drive it. The `revdoku` CLI **binary itself is static-publish only**
and cannot create the database or publish an app site, so use one of:

- **MCP connector (preferred when connected):** `bucket_app_database_get`,
  `bucket_app_database_setup`, `bucket_app_database_run_operation`,
  `bucket_app_database_query`, `bucket_app_database_snapshot` /
  `bucket_app_database_snapshots`, `bucket_app_database_notifications`. Publish
  with `bucket_publish` and `site_type: "app"`.
- **REST API (use this for CLI-only sessions where MCP is not connected):** the
  same operations live at `/api/v1/buckets/:bucket_id/app_database/*`, and you
  publish with `site_type: "app"`. See the **"Bucket App Database Endpoints"**
  and `site_type: "app"` sections of `api.md`, authenticating with the API key
  in `~/.revdoku/credentials`.

Flow (identical for MCP and REST):

1. Get/create the bucket. If it already exists, inspect the live schema + named
   actions first (`bucket_app_database_get` / `GET .../app_database`) before
   changing schema, rows, or action definitions.
2. Optionally write a private `.revdoku.app.json` contract (purpose, data model,
   actions, rollback notes). Stored in the draft, excluded from the live bundle.
3. Create the database and apply SQL `schema` statements, optional `seed` rows,
   and an `operations` manifest of named SQL actions
   (`bucket_app_database_setup` / `POST .../app_database/{schema,seed,operations}`).
   `public: true` actions become visitor endpoints at `/_revdoku/app/<name>`;
   `public: false` actions are owner/agent-only (run via `run_operation`).
   `params` bind from `body`, `query`, `visitor` (`key` = stable visitor id,
   `email` on password+email sites), `system` (`uuid`, `now`), or `literal`.
4. Write the static frontend (HTML/JS calling `/_revdoku/app/<name>` with `fetch`
   on the same origin) into the bucket.
5. **Publish with `site_type: "app"`** (ordinary `website` sites stay static-only
   and reject app routes).
6. Owner notifications: have a public website action also insert a row into the
   reserved `_revdoku_events` table (or use an `AFTER INSERT` trigger so
   the public action stays one statement); Revdoku surfaces new rows as in-app
   account notifications and via `bucket_app_database_notifications`. Use
   `bucket_app_database_query` for owner-only ad hoc SQL; visitors never get raw SQL.

Starter schemas + named actions (waitlist, feedback/voting dashboard, searchable
support center, leaderboards, link feeds, …) are in
`templates/app-safe-actions.json`; see `app-building-guide.md` for conventions.

Anti-spam for anonymous-write actions: store the owner's own Cloudflare
Turnstile secret as `operations.turnstile.secret_key` and set
`turnstile: true` on the action; the page renders the Turnstile widget with
the owner's sitekey and sends `cf_turnstile_token` in the request body.

Data protection rules: one database per bucket, created once — no reset,
re-provision, or delete endpoint exists. Destructive SQL (`DROP`, WHERE-less
`DELETE`/`UPDATE`, `PRAGMA`) is rejected on every owner path; evolve schema
additively or create a new bucket for a fresh schema. The provider database is
deleted only when the bucket itself is permanently deleted through the
confirmed bucket-delete flow — warn the user that visitor-submitted data is
deleted with it, and offer an export first.

## Read existing bucket files

Uploading is write-only, but you can read back existing files. Use
`--list-files` to discover paths, then `--read-file PATH` to print one file's
content (or save it with `--output`):

```bash
~/.revdoku/bin/revdoku --bucket-id bkt_... --list-files
~/.revdoku/bin/revdoku --bucket-id bkt_... --read-file leads/q3.csv
~/.revdoku/bin/revdoku --bucket-id bkt_... --read-file report.pdf --output report.pdf
```

`PATH` is bucket-relative (as shown by `--list-files`). Reads need only read
access, so a bucket-scoped agent grant works. Prefer this over hand-rolling HTTP;
cloud MCP clients use `bucket_file_list` + `bucket_file_read` instead.

## Options

- `--title TITLE`: bucket/publication title.
- `--description TEXT`: short bucket description.
- `--tag-path PATH`: explicit bucket label such as `website`; can be repeated. Do not use local path segments, parent folders, bucket titles, or domain/folder names as tags.
- `--bucket-id ID`: store into an existing bucket instead of creating a new one.
- `--list-versions`: with `--bucket-id`, print bucket version history as JSON.
- `--restore-version ID`: with `--bucket-id`, restore that bucket version as a new latest version.
- `--restore-comment TEXT`: optional reason appended to the restore version comment.
- `--append-text-file PATH`: with `--bucket-id`, append UTF-8 text to an existing bucket text file only. Use `--content TEXT` or `--content-file PATH`; pass `--no-newline-before` only when exact append bytes are required.
- `--metadata JSON`: optional bucket metadata for future agent lookup, e.g. `--metadata '{"project":"marketing-site","task":"landing-page"}'`.
- `--publish`: publish the bucket as a normal non-expiring website after storing files.
- `--feature-on-community`: with `--publish`, opt the public website into the revdoku.com/featured listing. With only `--bucket-id`, update an already-published website's featured setting without republishing. Ask the owner before using this.
- `--protected`: with `--publish`, publish as a password-protected website.
- `--access-mode password_ask_info`: with `--publish`, publish as a protected website that asks visitors for email plus password on Builder and Pro plans.
- `--password PASSWORD`: advanced direct-terminal option for owners who choose their own protected website password. Do not ask users for this in chat, and do not put the password in a URL.
- `--generate-password`: with `--publish --protected`, rotate the protected website password and show it in the owner publish response. Use only when the user explicitly asks to rotate it.
- `--unpublish`: with `--bucket-id`, unpublish a website while keeping its reserved URL for later republish.
- `--archive`: with `--bucket-id`, archive a normal unpublished bucket.
- `--unarchive`: with `--bucket-id`, restore an archived bucket to the active bucket list.
- `--delete-bucket`: with `--bucket-id`, permanently delete an unpublished bucket. The CLI fetches and passes the server-returned `delete.confirmation` token internally; use only after explicit destructive confirmation.
- `--url URL`: Revdoku app URL, default `https://app.revdoku.com`.
- `--version`: print the installed CLI version (or `unknown` if not installed via `install.sh`). On normal runs the CLI also prints a non-blocking notice when a newer version is available; update by re-running `curl -fsSL <app-url>/install.sh | bash`. See `docs/connector-updates.md` for refreshing MCP connectors after an update.
- `--login`: open the browser device-code login flow and refresh local credentials, with privacy-preserving email-code fallback on older servers. With no path it saves credentials and exits; pass a path (for example `revdoku ./dist`) to also store files. To confirm a connection works, run `--status`.
- `--status`: print connection status as JSON (connected, account, scope, bucket access). Works with bucket-scoped agent credentials, so this is the right way to confirm a connection — not `--account-status`.
- `--agent NAME`: attribute uploads to a specific agent (for example `claude-code` or `codex`). The CLI auto-detects common agents and otherwise records `cli`; set this (or `REVDOKU_AGENT_NAME`) when running inside an agent that is not auto-detected so version history shows the real caller.
- `--dashboard-link`: create a one-time browser login link for the Revdoku dashboard.
- `--library-link`: create a one-time browser login link for Library settings.
- `--access-link`: create a one-time browser login link for Account > Access.
- `--browser-login PATH`: create a one-time browser login link for an internal
  Revdoku path such as `/buckets`, `/library`, `/account/access`, or
  `/account/security`.
- `--exchange-grant TOKEN`: exchange a one-time grant copied from the Revdoku
  app and save the returned API key.
- `--list-buckets`: print available buckets and metadata as JSON.
- `--list-files`: with `--bucket-id`, print the files in a bucket as JSON (path, size, content type, id). Use this to discover what to read.
- `--read-file PATH`: with `--bucket-id`, print the content of the bucket file at PATH (bucket-relative) to stdout. This is how you READ existing bucket files. Add `--output FILE` to save it instead. Reads need only read access.
- `--output FILE`: with `--read-file`, write content to FILE instead of stdout.
- `--list-public-buckets`: print active website publications and URLs as JSON. Each publication includes `hits`, derived from `analytics.hits_all_time` in the HTTP API.
- `--account-status`: print account, plan, and storage status as JSON with full-account credentials. Bucket-scoped agent credentials are denied this; to confirm a bucket-scoped agent connection works use `--status`, or open Revdoku in a browser to review account status when needed.
- `--upload-mode MODE`: `auto` or `direct`; default `auto`. Private bucket storage uses bucket upload sessions so multi-file uploads become one bucket version.

## What To Tell The User

- By default, share the **`View in Revdoku:` dashboard link** the CLI prints (it
  opens the private bucket in Revdoku), not the raw `bkt_` id. Keep the id only
  as an internal handle for future `--bucket-id` calls.
- If `--publish` was used, share the **website URL** and keep the printed
  `Bucket: ...` id for future updates. For protected websites, give the owner the
  website URL and password to share; do not append the password as a URL
  parameter. For `password_ask_info`, also mention that visitors will enter email
  before the password.
- If publishing fails with `PUBLIC_STORAGE_NOT_CONFIGURED`, share the
  `View in Revdoku:` dashboard link as private storage and say public publishing
  is not configured yet.
- If asked which buckets are public, run `~/.revdoku/bin/revdoku --list-public-buckets` and summarize the bucket ids, URLs, and hit totals when useful.
- If asked to archive, unarchive, or permanently delete a bucket using only the CLI, first run `~/.revdoku/bin/revdoku --list-buckets` and resolve the right bucket by title/status. Use `--unpublish` first only after confirmation when `delete.required_action` or `archive.required_action` says `unpublish_first`.
- If asked to roll back a bucket, list versions first, confirm the target
  version, then run `~/.revdoku/bin/revdoku --bucket-id bkt_... --restore-version bktrv_...`.
  Explain that Revdoku creates a new latest version and keeps newer versions in
  history.
- If asked to open Revdoku, the dashboard, Library, all access, agents, API
  keys, or another UI-only page, create a browser login link with
  `~/.revdoku/bin/revdoku --dashboard-link`, `--library-link`,
  `--access-link`, or `--browser-login /buckets`. Tell the user it is
  single-use and expires quickly. If Revdoku says browser login links are
  disabled because two-factor authentication is enabled or required, tell the
  user to open Revdoku through the normal browser sign-in flow instead.
- If using MCP, summarize `bucket_publication_list` results instead of exposing raw JSON unless the user asks for JSON.
- If the script created credentials, mention that they were saved to `~/.revdoku/credentials`.
- When giving a URL that may be clicked from a terminal, add: "Cmd-click on
  macOS, or Ctrl-click on Windows/Linux, if your terminal supports clickable
  links."
- Do not expose the API key in chat or terminal history.
