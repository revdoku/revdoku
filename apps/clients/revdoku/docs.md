# Revdoku Docs

Revdoku stores generated files in private buckets as saved drafts and can
publish those files live as public or password-protected websites. Use it when an AI agent, local
script, or API workflow needs a durable place to save, update, share, or publish
project output.

## Quick Start

Install the local client:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Sign in through the browser device-code flow, or create a Revdoku account first
if you do not have one yet:

```sh
revdoku login
```

For a browser-first setup page that also covers hosted MCP connectors and
one-time local agent prompts, open `/connect/agent` in the Revdoku app.

Publish the current folder as a public website (the headline command):

```sh
revdoku p
```

Publish a specific folder, or save a private draft instead of going live:

```sh
revdoku p ./dist --title "Project preview"
revdoku p ./dist --draft
```

Publish a password-protected website:

```sh
revdoku p ./dist --title "Investor deck" --protected --generate-password
```

Re-running `revdoku p` updates the same site (the bucket is remembered in a local
`.revdoku` file).

Every command has a full name; the most-used ones also have a short alias (either
form works):

| Short | Full | Does |
|-------|------|------|
| `p`    | `publish` | Publish a folder (default `.`) live; re-run to update the same site |
| `ls`   | `list`    | List your sites and buckets |
| `o`    | `open`    | Open this folder's live site (`--dashboard` for the dashboard) |
| `i`    | `init`    | Scaffold a starter site + agent files (`--template <id>`) |
| `st`   | `status`  | Connection and account status |
| `down` | `unpublish` | Take this folder's site offline (keeps the URL) |
| —      | `login`   | Sign in and save an API key |

Other (full name only): `files`, `read PATH`, `versions`, `restore ID`,
`append PATH`, `archive`, `unarchive`, `delete`, `account`, `sites`, `dashboard`,
`grant TOKEN`. Run `revdoku --help` for the full reference.

## Buckets

A bucket is private storage for files, versions, and website publishing state.
Buckets keep file history so agents and people can update the same project over
time without losing earlier versions.

Use clear bucket titles and short descriptions. Tags are user-facing labels, not
filesystem breadcrumbs. For website uploads, use a simple `website` label only
when it helps organization; store project names, source folders, or task context
in metadata instead.

## Publishing

Revdoku supports three website modes:

- `static`: normal static files where `index.html` is the default entrypoint.
- `spa`: single-page apps where app routes fall back to the entrypoint.
- `app`: data-backed app sites that use bucket app databases and named actions.

If a published bucket does not contain `index.html`, Revdoku creates an
Auto-Index Page that lists and previews files. Custom Auto-Index templates must
include `{{files}}` or `{{ files }}`; supported macros are `{{title}}`,
`{{description}}`, `{{files}}`, and `{{theme_switch}}`, with optional whitespace
inside the braces.

Republishing the same bucket updates the existing website and keeps the same
public URL. Unpublishing removes public access while keeping the bucket and
reserved URL for later republish.

Publish, unpublish, and large delete requests are asynchronous. After starting
one, check the returned publication or bucket status separately before telling a
user that the website is live, public access is removed, or deletion is finished.

Saving files does not publish them. Treat bucket writes as **Save draft** and
publish tools as **Publish** or **Republish**.

To feature a public website on revdoku.com/featured, add `--feature` when you
publish, or — to update the featured flag on an already-published site **without
re-uploading** — run `--feature` with no path (it targets the folder's `.revdoku`
binding, or pass `--bucket-id`). Ask the owner first.

```sh
revdoku p --feature                      # publish (or republish) and feature
revdoku --feature                        # feature this folder's site, no re-upload
revdoku --feature --bucket-id bkt_...    # feature a specific bucket's site
```

## App Sites

App sites use a bucket-owned database and named actions. Public website
actions are visitor endpoints at `/_revdoku/app/<name>`; private agent actions
are owner/agent-only. Agents should inspect the live data model with
`bucket_app_database_get` before changing schema, data, or actions, and keep a
private `.revdoku.app.json` contract file in the bucket for future handoff.
Starter app database templates live in the public client repository at
`https://github.com/revdoku/revdoku/tree/main/templates`; MCP exposes the same
location as `bucket_app_database_get.template_source`. Follow each template's
`recommended_access` and `data_sensitivity` metadata; templates marked
`password` should be published behind a protected website gate unless the owner
explicitly asks otherwise.

## Protected Websites

Protected websites use a separate password gate. When enabled, Revdoku can:

- Generate or keep a website password.
- Ask visitors for an email before access when `password_ask_info` is selected
  on Builder and Pro plans.
- Notify the owner on every successful protected access when access
  notifications are enabled.

Visitor-provided email is shared with the site owner for access tracking. The
gate displays that notice before access.

## Website Analytics And Tracking

Published websites record Revdoku analytics and browser-side client events by
default. Use `--no-tracking` to disable both for a publish or republish. Scripts
that need separate control can use `--no-analytics` for server-side website
analytics and `--no-client-events` for browser-side Revdoku event tracking.

## What Revdoku Is (And Isn't)

Revdoku deliberately offers a small, fixed set of capabilities. The constraints
are the point: they keep it simple to use and predictable to operate.

What it does: host static sites and SPAs from a folder; per-bucket app databases
with named SQL actions at `/_revdoku/app/<name>`; Turnstile-protected public
writes; owner notifications for app submissions; public or password-protected
access; website analytics; and an opt-in revdoku.com/featured gallery.

What it intentionally does not do (and the workaround):

- Custom server backends or arbitrary server code → use app-database named
  actions; persistent state lives in the bucket database.
- Cron jobs / scheduled server tasks → trigger work from a client or an external
  scheduler hitting a public action.
- A client-side AI/LLM proxy for published sites → Revdoku sites are on the
  public internet, so an open AI key would be abused; call your own backend.
- Importing code from another site at runtime / shared cross-account libraries →
  vendor the assets into the bucket you publish.

When something seems missing, first check whether one of the existing primitives
already covers it before adding scope.

## Agents And MCP

Hosted MCP clients can connect to:

```text
https://app.revdoku.com/mcp
```

Local agents can use the installed `revdoku` command. Prefer MCP tools when
available; use the CLI when the agent needs local filesystem access.

For line-oriented text updates, the CLI can append to an existing bucket text
file without rewriting the whole file:

```sh
revdoku append leads.csv --bucket-id bkt_... --content-file new-leads.csv
```

This is only for UTF-8 text files such as `.txt`, `.md`, `.csv`, `.jsonl`, and
code files. The CLI retries short-lived bucket/file locks for append and prints
the lock owner, message, and expiry if the file remains locked.

## API

The public API reference is available at:

```text
https://revdoku.com/api.md
```

Common API flows:

- Create or update buckets.
- Upload files through direct uploads or publish sessions.
- Publish or unpublish bucket websites.
- Manage custom domains.
- Read bucket analytics and protected-access contacts.

## Support

For account, billing, or access issues, email:

```text
support@revdoku.com
```
