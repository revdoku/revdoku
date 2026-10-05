# Revdoku Changelog

## 1.0.519 — 2026-09-30

### Improved

- Create mailboxes with a confirmed receiving address in one request. Creation no
  longer requires a retry key or client-side readiness polling.
- Complete API signup with one private signup token. Human-authorized terms and
  privacy acknowledgments replace client-supplied policy versions.
- Read effective mailbox and storage quotas from a dedicated limits endpoint,
  the CLI, or MCP. Public mailbox responses use one receiving-state flag.
- Follow reorganized API and developer guides with request/response examples,
  field tables, and direct HTTP examples for JavaScript, TypeScript and Python.

### Fixed

- Hide disabled GitHub Sync controls and remove its public routes and documentation.
- Keep mailbox creation errors, website examples, CLI commands and MCP schemas
  aligned with actual API responses.

## 1.0.518 — 2026-09-30

### Added

- Choose a mailbox username through the API, MCP, CLI, and signup. Omit it for
  a generated address. Retired platform addresses remain reserved.
- Discover authorized accounts and delete individual emails with their attachments
  through the API and agent tools.

### Improved

- Keep email responses focused on message content, with storage details available
  on request. Reading email no longer changes its shared read status.
- Use direct HTTP examples for JavaScript, TypeScript, and Python, without a
  Revdoku SDK or client wrapper.
- Protect direct API signup with human-operator email verification, shared abuse
  limits, and bounded requests. Deployments enable this flow through configuration.

### Fixed

- Download protected email attachments through expiring authorized links that
  return usable bytes without exposing an API key to storage.

## 1.0.516 — 2026-09-30

- Read emails, conversations, originals and attachments through the email API,
  MCP and CLI. Email settings use `email` across clients and examples.
- Use consistent success and error responses, arrival cursors and retry guidance
  in the API and runnable JavaScript/TypeScript examples.
- Navigate with Mailboxes and Analytics in the header and switch accounts from
  the sidebar. API connections come first in the Connect menu.
- Keep sensitive file and email metadata protected with account keys on HIPAA
  and high-security accounts; ordinary accounts retain queryable metadata.
- Account settings have a separate Subscription tab for billing and usage.

## 1.0.513 — 2026-09-29

- Install the CLI independently from versioned GitHub Release downloads with
  SHA-256 checksums. Existing skill and plugin installation paths remain available.
- Run JavaScript or TypeScript examples for mailbox creation and readiness, mail
  reading, attachment downloads, file uploads/readback, and quota handling.
- Retry mailbox creation with a stable key and inspect monthly creation usage through
  the authenticated account profile. Deletion does not refund creation capacity.

## 1.0.508 — 2026-09-29

- Skill and plugin descriptions disclose file uploads, changes, mailbox deletion,
  and agency client creation alongside receiving email.
- Exclude Revdoku credentials, saved selections, update/version stamps, and deletion
  previews from uploads, including when configuration is stored in a project.

## 1.0.507 — 2026-09-28

- Find Revdoku as an email mailbox with shared file storage for people and AI agents.
- Start with examples for summarizing mail, collecting invoices and attachments,
  and monitoring submission replies. Email guidance appears before file storage.
- Skill and plugin descriptions make clear that email support is incoming only.

## 1.0.506 — 2026-09-28

- Uploads require an explicit path; use `upload .` for the current folder or
  `upload PATH --dry-run` to inspect the selection without connecting.
- Permanent deletion requires an explicit account/mailbox preview followed by
  `--confirm-delete TOKEN`. Confirmations expire after ten minutes and are single-use.
- Public CLI API/auth requests require https://app.revdoku.com. Storage transfers
  use approved HTTPS origins and cannot select local files outside the upload manifest.
- Skill packages contain one readable CLI implementation and a compatibility launcher.
- Preserve normal Rails storage uploads and macOS parent paths while validating
  headers and protecting temporary files. Deletion previews use current revision
  metadata and complete counts; offline upload previews honor the saved destination.

## 1.0.499 — 2026-09-25

- Filter messages by read status or attachments, and sort newest, oldest, or unread first.
- Choose a mailbox name before creation and keep it ready when retrying a failed request.
- Review clearer activity totals and relative email arrival times, with exact timestamps on hover.
- Install portable agent skills with bundled resources and updated plugin metadata.

## 1.0.492 — 2026-09-23

- Store, share, and version files in private cloud mailboxes.
- Use each mailbox as a mailbox for messages and attachments.
- Read decoded message bodies and originals through the CLI, API, or hosted MCP.
- Coordinate authorized agents with account selection, locks, and revision checks.

Current setup and usage: [README](./README.md), [mailbox guide](./docs.md),
[API](./api.md), and [MCP](./mcp.md).
