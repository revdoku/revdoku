---
name: revdoku
description: >
  Create, update, and publish websites with Revdoku buckets; store files
  privately until the user asks for a public link.
---

# Revdoku Website Publishing

Create or update websites in Revdoku as durable bucket files. A bucket stores
files privately first and can be published or republished as a public website.

Use this skill when the user asks to publish, host, deploy, share on the web,
create a public website, upload, save, store, share through a bucket, or make
local output available to other agents through Revdoku. If the user asks to
publish, host, deploy, share on the web, or make a folder available as a public
website, pass `--publish`.

If the user says "publish it all to Revdoku", publish the current project or
current working directory with `--publish`, then return the public URL printed by
the script.

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
  `website`, `draft`, `landing-page`, `ai-agent`, or slash groups such as
  `projects/work`.
- Use `bucket_write_file`, `bucket_upload_file`, `bucket_read_file`,
  and `bucket_delete_file` for website/project file operations. Use
  `index.html` as the default website root unless the user asks for another
  entrypoint.
- Use `bucket_version_list`, `bucket_version_get`, and
  `bucket_version_restore` when the user asks to inspect history or roll back
  a bucket. Restore creates a new latest version from the selected historical
  version; it does not delete newer versions from history.
- In shared buckets, lock existing files before editing: call
  `bucket_lock_files` with `path`, `file_id`, or `mask` plus a clear message
  describing what this agent is doing. Unlock with `bucket_unlock_file` after
  the write. If Revdoku returns `FILE_LOCKED`, do not overwrite; report who owns
  the lock and the lock message, then coordinate or wait.
- Use `bucket_publish` only when the user asks for a public URL. When updating
  an existing public project, republish that same `bucket_id`; Revdoku keeps
  the same public URL and this does not use another live-site slot. If publishing
  a new bucket returns `PUBLICATION_LIMIT_REACHED`, keep the private bucket,
  list current public buckets with `bucket_publication_list`, and ask the
  user whether to republish/update one existing public bucket, unpublish one
  current bucket, or upgrade. Never unpublish without confirmation. If
  publishing returns `PUBLIC_STORAGE_NOT_CONFIGURED`, keep using the private
  bucket and tell the user public publishing is not configured for this
  deployment yet.
- Use `bucket_unpublish` when the user asks to unpublish a public bucket.
  Tell the user that republishing the same bucket restores the same URL.
- Use `bucket_archive` and `bucket_unarchive` for normal bucket
  lifecycle cleanup. Library buckets cannot be archived or unarchived.
  Published buckets must be unpublished before archive; if
  `archive.required_action` is `unpublish_first`, unpublish first only after
  user confirmation.
- Use `bucket_delete_permanently` only when the user explicitly asks to
  delete a normal archived unpublished bucket. Confirm destructive intent by
  bucket title or natural language, then pass the `delete.confirmation` value
  returned by `bucket_list` or `bucket_get`; do not ask users to type the
  `bkt_...` id. If `delete.required_action` is `unpublish_first`, unpublish
  first only after user confirmation. If `delete.required_action` is
  `archive_first`, archive the bucket before permanent delete.
  `bucket_delete` is a legacy alias with the same confirmation requirement.
- Use `bucket_publication_list` when the user asks which buckets are
  public or asks for existing public links. Publication list rows include a
  `hits` value derived from the API's `analytics.hits_all_time`; treat `0` as
  either no recorded hits or analytics hidden for the current plan.
- Use `revdoku_browser_login_link` when the user asks to open the Revdoku
  dashboard, manage agent/API access, manage billing, or use another Revdoku UI
  page the tool cannot show directly. Use `/buckets` for the dashboard,
  `/library` for Library settings, `/account/access` for people/API key/agent
  access, and `/pricing` for plans. Tell the user the link is single-use,
  expires quickly, and can usually be opened from a terminal with Cmd-click on
  macOS or Ctrl-click on Windows/Linux. If Revdoku says browser login links are
  disabled because two-factor authentication is enabled or required, tell the
  user to open Revdoku through the normal browser sign-in flow instead.
- Use `revdoku_store_path` for local path storage. Pass `"publish": true` only
  when the user asks to publish or wants a public URL.

For non-agent service integrations, point users to
`apps/clients/revdoku/api.md`. The HTTP API exposes the same storage
model as MCP: buckets, files, direct uploads, public bucket publications,
and publication listing.

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
read-only by default, and says to publish only when the user asks for a public
link.

## Store

```bash
~/.revdoku/bin/revdoku {file-or-dir}
```

The script stores files privately and prints the bucket id. If no API key is available, run it interactively and it will ask for the user's email, send a Revdoku verification code, ask for the code, save the API key to `~/.revdoku/credentials`, then store the files. New confirmed accounts start on the Free plan with 2 GB storage, ten live public sites, and three total account connections: the owner plus two agent or API connections. This is a one-time setup; future runs reuse the saved key automatically. If Revdoku rejects a disposable or blocked email address, ask the user for a permanent email address and retry. The client is Bash + curl only; do not use Ruby for this workflow.

Under the hood this is a Revdoku private bucket file flow by default:

1. Create a bucket with `POST /api/v1/buckets`, unless `--bucket-id` was provided.
2. For each file, request a direct upload with `POST /api/v1/direct_uploads`.
3. Upload file bytes to the returned URL with the exact returned headers.
4. Attach the uploaded blob to the bucket with `POST /api/v1/buckets/:id/files`.
5. Print the bucket id so future agents can append, replace, inspect, or publish the same bucket.

If direct upload links fail, the default `--upload-mode auto` retries with multipart bucket upload. This still only stores files privately. When storing a directory, the CLI skips common local-only and secret-looking paths such as `.env`, private keys, credential/token files, `.git`, `.revdoku`, `.terraform`, and `node_modules`. If every file is skipped, the CLI stops before creating an empty bucket. If the user asks to store a skipped file intentionally, confirm that they understand it may contain secrets before using the API directly.

To also create a permanent public bucket site URL, pass `--publish`. To update an existing public site, pass `--bucket-id` for that same public bucket so Revdoku republishes the existing URL instead of creating a new live public site. For HTML buckets, publish the directory whose contents should become the site root. If `index.html` exists, it is served at the root URL. If not, Revdoku publishes a generated file listing. Add `--expires-in-days DAYS` only when the user explicitly asks for an expiring link; Revdoku stops serving expired publications and purges their public files with a scheduled cleanup job. If publishing returns `PUBLICATION_LIMIT_REACHED`, keep the stored private bucket, list public buckets with `--list-public-buckets`, and ask whether to republish/update an existing public bucket, unpublish one current bucket, or upgrade. If publishing returns `PUBLIC_STORAGE_NOT_CONFIGURED`, the private bucket was still stored; report that public publishing is not configured yet and do not retry destructively.

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

- `--expires-in-days DAYS`: advanced; make a public publication expire after DAYS instead of permanent.
- `--title TITLE`: bucket/publication title.
- `--description TEXT`: short bucket description.
- `--tag-path PATH`: bucket label such as `website` or `projects/work`; can be repeated.
- `--bucket-id ID`: store into an existing bucket instead of creating a new one.
- `--list-versions`: with `--bucket-id`, print bucket version history as JSON.
- `--restore-version ID`: with `--bucket-id`, restore that bucket version as a new latest version.
- `--restore-comment TEXT`: optional reason appended to the restore version comment.
- `--metadata JSON`: optional bucket metadata for future agent lookup, e.g. `--metadata '{"project":"marketing-site","task":"landing-page"}'`.
- `--publish`: publish the bucket as a permanent public site after storing files.
- `--unpublish`: with `--bucket-id`, unpublish a public bucket site while keeping its reserved URL for later republish.
- `--archive`: with `--bucket-id`, archive a normal unpublished bucket.
- `--unarchive`: with `--bucket-id`, restore an archived bucket to the active bucket list.
- `--delete-bucket`: with `--bucket-id`, permanently delete an archived unpublished bucket. The CLI fetches and passes the server-returned `delete.confirmation` token internally; use only after explicit destructive confirmation.
- `--url URL`: Revdoku app URL, default `https://app.revdoku.com`.
- `--login`: force the email-code login flow and refresh local credentials.
- `--dashboard-link`: create a one-time browser login link for the Revdoku dashboard.
- `--library-link`: create a one-time browser login link for Library settings.
- `--access-link`: create a one-time browser login link for Account > Access.
- `--browser-login PATH`: create a one-time browser login link for an internal
  Revdoku path such as `/buckets`, `/library`, `/account/access`, or
  `/pricing`.
- `--exchange-grant TOKEN`: exchange a one-time grant copied from the Revdoku
  app and save the returned API key.
- `--list-buckets`: print available buckets and metadata as JSON.
- `--list-public-buckets`: print active public bucket publications and URLs as JSON. Each publication includes `hits`, derived from `analytics.hits_all_time` in the HTTP API.
- `--account-status`: print account, plan, and storage status as JSON. If unauthorized, run again with `--login`.
- `--upload-mode MODE`: `auto`, `direct`, or `multipart`; default `auto`.

## What To Tell The User

- By default, share the bucket id printed by the script. It is private storage, not a public URL.
- If `--publish` was used, share the public URL and keep the printed `Bucket: ...` id for future updates.
- If publishing fails with `PUBLIC_STORAGE_NOT_CONFIGURED`, share the bucket
  id as private storage and say public publishing is not configured yet.
- If asked which buckets are public, run `~/.revdoku/bin/revdoku --list-public-buckets` and summarize the bucket ids, URLs, and hit totals when useful.
- If asked to archive, unarchive, or permanently delete a bucket using only the CLI, first run `~/.revdoku/bin/revdoku --list-buckets` and resolve the right bucket by title/status. Use `--unpublish` first only after confirmation when `delete.required_action` or `archive.required_action` says `unpublish_first`; use `--archive` before `--delete-bucket` when `delete.required_action` says `archive_first`.
- If asked to roll back a bucket, list versions first, confirm the target
  version, then run `~/.revdoku/bin/revdoku --bucket-id bkt_... --restore-version bktrv_...`.
  Explain that Revdoku creates a new latest version and keeps newer versions in
  history.
- If asked to open Revdoku, the dashboard, Library, all access, agents, API
  keys, billing, or another UI-only page, create a browser login link with
  `~/.revdoku/bin/revdoku --dashboard-link`, `--library-link`,
  `--access-link`, or `--browser-login /pricing`. Tell the user it is
  single-use and expires quickly. If Revdoku says browser login links are
  disabled because two-factor authentication is enabled or required, tell the
  user to open Revdoku through the normal browser sign-in flow instead.
- If using MCP, summarize `bucket_publication_list` results instead of exposing raw JSON unless the user asks for JSON.
- If the script created credentials, mention that they were saved to `~/.revdoku/credentials`.
- When giving a URL that may be clicked from a terminal, add: "Cmd-click on
  macOS, or Ctrl-click on Windows/Linux, if your terminal supports clickable
  links."
- Do not expose the API key in chat or terminal history.
