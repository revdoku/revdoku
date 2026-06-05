# Revdoku Docs

Revdoku stores generated files in private buckets and can publish those files as
public or password-protected static websites. Use it when an AI agent, local
script, or API workflow needs a durable place to save, update, share, or publish
project output.

## Quick Start

Install the local client:

```sh
curl -fsSL https://revdoku.com/install.sh | bash
```

Connect an existing Revdoku account:

```sh
revdoku --login
```

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

Revdoku supports two website modes:

- `static`: normal static files where `index.html` is the default entrypoint.
- `spa`: single-page apps where app routes fall back to the entrypoint.

Republishing the same bucket updates the existing website and keeps the same
public URL. Unpublishing removes public access while keeping the bucket and
reserved URL for later republish.

## Protected Websites

Protected websites use a separate password gate. When enabled, Revdoku can:

- Generate or keep a website password.
- Ask visitors for an email before access when `password_ask_info` is selected.
- Notify the owner on every successful protected access when access
  notifications are enabled.

Visitor-provided email is shared with the site owner for access tracking. The
gate displays that notice before access.

## Agents And MCP

Hosted MCP clients can connect to:

```text
https://app.revdoku.com/mcp
```

Local agents can use the installed `revdoku` command. Prefer MCP tools when
available; use the CLI when the agent needs local filesystem access.

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
