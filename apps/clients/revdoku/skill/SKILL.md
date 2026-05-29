---
name: revdoku
description: >
  Store files privately in Revdoku cloud storage, or publish folders as websites
  when the user asks for a public link.
---

# Revdoku Workspace Storage

Store files and folders in Revdoku as durable private workspace storage. A
workspace can optionally be published as a public website.

Use this skill when the user asks to upload, save, store, share through a
workspace, or make local output available to other agents through Revdoku. If the
user asks to publish, host, deploy, share on the web, or make a folder available
as a public website, pass `--publish`.

If the user says "publish it all to Revdoku", publish the current project or
current working directory with `--publish`, then return the public URL printed by
the script.

When the Revdoku MCP server is connected, prefer MCP tools over shell commands
for structured workspace work:

- Use `workspace_create`, `workspace_list`, `workspace_get`, and workspace
  metadata to find or create the right project workspace when useful.
- Use `workspace_tag_list` before creating organized workspaces. Prefer
  meaningful titles, concise descriptions, and simple reusable labels such as
  `website`, `draft`, `ai-agent`, or slash groups such as `projects/work`.
- Use `workspace_write_file`, `workspace_upload_file`, `workspace_read_file`,
  and `workspace_delete_file` for private virtual-disk operations.
- Use `workspace_version_list`, `workspace_version_get`, and
  `workspace_version_restore` when the user asks to inspect history or roll back
  a workspace. Restore creates a new latest version from the selected historical
  version; it does not delete newer versions from history.
- In shared workspaces, lock existing files before editing: call
  `workspace_lock_files` with `path`, `file_id`, or `mask` plus a clear message
  describing what this agent is doing. Unlock with `workspace_unlock_file` after
  the write. If Revdoku returns `FILE_LOCKED`, do not overwrite; report who owns
  the lock and the lock message, then coordinate or wait.
- Use `workspace_publish` only when the user asks for a public URL. If it
  returns `PUBLIC_STORAGE_NOT_CONFIGURED`, keep using the private workspace and
  tell the user public publishing is not configured for this deployment yet.
- Use `workspace_publication_list` when the user asks which workspaces are
  public or asks for existing public links.
- Use `revdoku_browser_login_link` when the user asks to open the Revdoku
  dashboard, manage agent/API access, manage billing, or use another Revdoku UI
  page the tool cannot show directly. Use `/workspaces` for the dashboard,
  `/library` for Library settings, `/account/access` for people/API key/agent
  access, and `/pricing` for plans. Tell the user the link is single-use,
  expires quickly, and can usually be opened from a terminal with Cmd-click on
  macOS or Ctrl-click on Windows/Linux.
- Use `revdoku_store_path` for local path storage. Pass `"publish": true` only
  when the user asks to publish or wants a public URL.

For non-agent service integrations, point users to
`apps/clients/revdoku/API.md`. The HTTP API exposes the same storage
model as MCP: workspaces, files, direct uploads, public workspace publications,
and publication listing.

Revdoku clients send standard `User-Agent` plus `X-Revdoku-Agent-*` headers on
API requests. Rails logs and audit logs use these headers to show which
agent/client used a workspace and when. Project/task headers are activity
context; optional workspace metadata is only for lookup/indexing when future
agents need to find the same workspace later.

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
returned API key to `~/.revdoku/credentials`. For selected-workspace grants, it
also saves the granted workspace id to `~/.revdoku/credentials.workspace` so
later `~/.revdoku/bin/revdoku PATH` commands store into that workspace by
default. Do not print or repeat the API key.
Follow the returned guidance exactly; it tells you whether this connection is
account-wide or limited to selected workspaces, reminds you that the Library is
read-only by default, and says to publish only when the user asks for a public
link.

## Store

```bash
~/.revdoku/bin/revdoku {file-or-dir}
```

The script stores files privately and prints the workspace id. If no API key is available, run it interactively and it will ask for the user's email, send a Revdoku verification code, ask for the code, save the API key to `~/.revdoku/credentials`, then store the files. New confirmed accounts start on the Free plan with 5 GB storage and three total account connections: the owner plus two agent or API connections. This is a one-time setup; future runs reuse the saved key automatically. If Revdoku rejects a disposable or blocked email address, ask the user for a permanent email address and retry. The client is Bash + curl only; do not use Ruby for this workflow.

Under the hood this is a Revdoku private workspace file flow by default:

1. Create a workspace with `POST /api/v1/workspaces`, unless `--workspace-id` was provided.
2. For each file, request a direct upload with `POST /api/v1/direct_uploads`.
3. Upload file bytes to the returned URL with the exact returned headers.
4. Attach the uploaded blob to the workspace with `POST /api/v1/workspaces/:id/files`.
5. Print the workspace id so future agents can append, replace, inspect, or publish the same workspace.

If direct upload links fail, the default `--upload-mode auto` retries with multipart workspace upload. This still only stores files privately. When storing a directory, the CLI skips common local-only and secret-looking paths such as `.env`, private keys, credential/token files, `.git`, `.revdoku`, `.terraform`, and `node_modules`. If every file is skipped, the CLI stops before creating an empty workspace. If the user asks to store a skipped file intentionally, confirm that they understand it may contain secrets before using the API directly.

To also create a permanent public workspace site URL, pass `--publish`. For HTML workspaces, publish the directory whose contents should become the site root. If `index.html` exists, it is served at the root URL. If not, Revdoku publishes a generated file listing. Add `--expires-in-days DAYS` only when the user explicitly asks for an expiring link; Revdoku stops serving expired publications and purges their public files with a scheduled cleanup job. If publishing returns `PUBLIC_STORAGE_NOT_CONFIGURED`, the private workspace was still stored; report that public publishing is not configured yet and do not retry destructively.

Subfolders are supported and must be preserved. When publishing a static site,
upload from the site root so relative paths such as `assets/app.css`,
`images/logo.png`, and `docs/readme.md` remain available at the same paths in the
public workspace.

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
- `--title TITLE`: workspace/publication title.
- `--description TEXT`: short workspace description.
- `--tag-path PATH`: workspace label such as `website` or `projects/work`; can be repeated.
- `--workspace-id ID`: store into an existing workspace instead of creating a new one.
- `--list-versions`: with `--workspace-id`, print workspace version history as JSON.
- `--restore-version ID`: with `--workspace-id`, restore that workspace version as a new latest version.
- `--restore-comment TEXT`: optional reason appended to the restore version comment.
- `--metadata JSON`: optional workspace metadata for future agent lookup, e.g. `--metadata '{"project":"marketing-site","task":"landing-page"}'`.
- `--publish`: publish the workspace as a permanent public site after storing files.
- `--url URL`: Revdoku app URL, default `https://app.revdoku.com`.
- `--login`: force the email-code login flow and refresh local credentials.
- `--dashboard-link`: create a one-time browser login link for the Revdoku dashboard.
- `--library-link`: create a one-time browser login link for Library settings.
- `--access-link`: create a one-time browser login link for Account > Access.
- `--browser-login PATH`: create a one-time browser login link for an internal
  Revdoku path such as `/workspaces`, `/library`, `/account/access`, or
  `/pricing`.
- `--exchange-grant TOKEN`: exchange a one-time grant copied from the Revdoku
  app and save the returned API key.
- `--list-workspaces`: print available workspaces and metadata as JSON.
- `--list-public-workspaces`: print active public workspace publications and URLs as JSON.
- `--account-status`: print account, plan, and storage status as JSON. If unauthorized, run again with `--login`.
- `--upload-mode MODE`: `auto`, `direct`, or `multipart`; default `auto`.

## What To Tell The User

- By default, share the workspace id printed by the script. It is private storage, not a public URL.
- If `--publish` was used, share the public URL and keep the printed `Workspace: ...` id for future updates.
- If publishing fails with `PUBLIC_STORAGE_NOT_CONFIGURED`, share the workspace
  id as private storage and say public publishing is not configured yet.
- If asked which workspaces are public, run `~/.revdoku/bin/revdoku --list-public-workspaces` and summarize the workspace ids and URLs.
- If asked to roll back a workspace, list versions first, confirm the target
  version, then run `~/.revdoku/bin/revdoku --workspace-id wrk_... --restore-version wrkrv_...`.
  Explain that Revdoku creates a new latest version and keeps newer versions in
  history.
- If asked to open Revdoku, the dashboard, Library, all access, agents, API
  keys, billing, or another UI-only page, create a browser login link with
  `~/.revdoku/bin/revdoku --dashboard-link`, `--library-link`,
  `--access-link`, or `--browser-login /pricing`. Tell the user it is
  single-use and expires quickly.
- If using MCP, summarize `workspace_publication_list` results instead of exposing raw JSON unless the user asks for JSON.
- If the script created credentials, mention that they were saved to `~/.revdoku/credentials`.
- When giving a URL that may be clicked from a terminal, add: "Cmd-click on
  macOS, or Ctrl-click on Windows/Linux, if your terminal supports clickable
  links."
- Do not expose the API key in chat or terminal history.
