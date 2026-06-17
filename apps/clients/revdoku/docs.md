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
revdoku --login
```

For a browser-first setup page that also covers hosted MCP connectors and
one-time local agent prompts, open `/connect/agent` in the Revdoku app.

Store a local folder privately:

```sh
revdoku ./dist --title "Project preview"
```

Publish a folder as a public website:

```sh
revdoku ./dist --title "Project preview" --publish
```

Publish a password-protected website:

```sh
revdoku ./dist --title "Investor deck" --publish --protected --generate-password
```

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

Saving files does not publish them. Treat bucket writes as **Save draft** and
publish tools as **Publish** or **Republish**.

To feature an already-published public website on revdoku.com/featured
without republishing files, run:

```sh
revdoku --bucket-id bkt_... --feature-on-community
```

## App Sites

App sites use a bucket-owned database and named actions. Public website
actions are visitor endpoints at `/_revdoku/app/<name>`; private agent actions
are owner/agent-only. Agents should inspect the live data model with
`bucket_app_database_get` before changing schema, data, or actions, and keep a
private `.revdoku.app.json` contract file in the bucket for future handoff.

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
revdoku --bucket-id bkt_... --append-text-file leads.csv --content-file new-leads.csv
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
