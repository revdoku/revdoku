---
name: revdoku
description: >
  Create, update, and publish websites with Revdoku buckets; store files
  privately until the user asks for a public or protected link.
---

# Revdoku Website Publishing

Create or update websites in Revdoku as durable bucket files. A bucket stores
files privately first and can be published or republished as a public or
password-protected website.

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
- Use `bucket_write_file`, `bucket_upload_file`, `bucket_read_file`,
  and `bucket_delete_file` for website/project file operations. Use
  `index.html` as the default website root unless the user asks for another
  entrypoint. Use `bucket_file_list` with `limit` and `offset` for large buckets
  when a partial file listing is enough; omit them only when the full list is needed.
- Use `bucket_version_list`, `bucket_version_get`, and
  `bucket_version_restore` when the user asks to inspect history or roll back
  a bucket. Restore creates a new latest version from the selected historical
  version; it does not delete newer versions from history.
- In shared buckets, use locks before editing. For broad folder uploads, site
  rewrites, or multi-file updates, call `bucket_lock` with a clear message and
  unlock with `bucket_unlock` after the work. For narrow edits, call
  `bucket_lock_files` with `path`, `file_id`, or `mask`, then unlock with
  `bucket_unlock_file`. Revdoku checks the bucket lock before file locks. If it
  returns `BUCKET_LOCKED` or `FILE_LOCKED`, do not overwrite; report who owns the
  lock and the lock message, then coordinate or wait.
- Use `bucket_publish` only when the user asks for a public website URL. For
  protected websites, use `bucket_publish_password_protected`; Revdoku generates
  a password when needed. Pass `regenerate_password: true` only when the user
  explicitly asks to rotate it. Never ask the user to type a protected-site
  password in chat, and never put the password in the URL. If the user asks to
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
  websites need available Pro protected-site capacity. If
  publishing returns `PUBLIC_STORAGE_NOT_CONFIGURED`, keep using the private
  bucket and tell the user public publishing is not configured for this
  deployment yet. If publishing returns `PRIVATE_PUBLICATION_STORAGE_NOT_CONFIGURED`,
  keep using the private bucket and tell the user protected website publishing
  is not configured for this deployment yet.
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

The CLI stores files privately and prints the bucket id. If no API key is
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

## Options

- `--expires-in-days DAYS`: advanced; make a website expire after DAYS instead of permanent.
- `--title TITLE`: bucket/publication title.
- `--description TEXT`: short bucket description.
- `--tag-path PATH`: explicit bucket label such as `website`; can be repeated. Do not use local path segments, parent folders, bucket titles, or domain/folder names as tags.
- `--bucket-id ID`: store into an existing bucket instead of creating a new one.
- `--list-versions`: with `--bucket-id`, print bucket version history as JSON.
- `--restore-version ID`: with `--bucket-id`, restore that bucket version as a new latest version.
- `--restore-comment TEXT`: optional reason appended to the restore version comment.
- `--metadata JSON`: optional bucket metadata for future agent lookup, e.g. `--metadata '{"project":"marketing-site","task":"landing-page"}'`.
- `--publish`: publish the bucket as a permanent website after storing files.
- `--protected`: with `--publish`, publish as a password-protected website.
- `--access-mode password_ask_info`: with `--publish`, publish as a protected website that asks visitors for email plus password.
- `--password PASSWORD`: advanced direct-terminal option for owners who choose their own protected website password. Do not ask users for this in chat, and do not put the password in a URL.
- `--generate-password`: with `--publish --protected`, rotate the protected website password and show it in the owner publish response. Use only when the user explicitly asks to rotate it.
- `--unpublish`: with `--bucket-id`, unpublish a website while keeping its reserved URL for later republish.
- `--archive`: with `--bucket-id`, archive a normal unpublished bucket.
- `--unarchive`: with `--bucket-id`, restore an archived bucket to the active bucket list.
- `--delete-bucket`: with `--bucket-id`, permanently delete an unpublished bucket. The CLI fetches and passes the server-returned `delete.confirmation` token internally; use only after explicit destructive confirmation.
- `--url URL`: Revdoku app URL, default `https://app.revdoku.com`.
- `--login`: force the email-code login flow and refresh local credentials.
- `--dashboard-link`: create a one-time browser login link for the Revdoku dashboard.
- `--library-link`: create a one-time browser login link for Library settings.
- `--access-link`: create a one-time browser login link for Account > Access.
- `--browser-login PATH`: create a one-time browser login link for an internal
  Revdoku path such as `/buckets`, `/library`, `/account/access`, or
  `/account/security`.
- `--exchange-grant TOKEN`: exchange a one-time grant copied from the Revdoku
  app and save the returned API key.
- `--list-buckets`: print available buckets and metadata as JSON.
- `--list-public-buckets`: print active website publications and URLs as JSON. Each publication includes `hits`, derived from `analytics.hits_all_time` in the HTTP API.
- `--account-status`: print account, plan, and storage status as JSON with full-account credentials. Bucket-scoped agent credentials may be denied; open Revdoku in a browser to review account status when needed.
- `--upload-mode MODE`: `auto` or `direct`; default `auto`. Private bucket storage uses bucket upload sessions so multi-file uploads become one bucket version.

## What To Tell The User

- By default, share the bucket id printed by the script. It is private storage, not a public URL.
- If `--publish` was used, share the website URL and keep the printed `Bucket: ...` id for future updates. For protected websites, give the owner the website URL and password to share; do not append the password as a URL parameter. For `password_ask_info`, also mention that visitors will enter email before the password.
- If publishing fails with `PUBLIC_STORAGE_NOT_CONFIGURED`, share the bucket
  id as private storage and say public publishing is not configured yet.
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
