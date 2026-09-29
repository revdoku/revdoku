# Revdoku Changelog

## 1.0.513 — 2026-09-29

- Install the CLI independently from versioned GitHub Release downloads with
  SHA-256 checksums. Existing skill and plugin installation paths remain available.
- Run JavaScript or TypeScript examples for inbox creation and readiness, mail
  reading, attachment downloads, file uploads/readback, and quota handling.
- Retry inbox creation with a stable key and inspect monthly creation usage through
  the authenticated account profile. Deletion does not refund creation capacity.

## 1.0.508 — 2026-09-29

- Skill and plugin descriptions disclose file uploads, changes, bucket deletion,
  and agency client creation alongside receiving email.
- Exclude Revdoku credentials, saved selections, update/version stamps, and deletion
  previews from uploads, including when configuration is stored in a project.

## 1.0.507 — 2026-09-28

- Find Revdoku as an email inbox with shared file storage for people and AI agents.
- Start with examples for summarizing mail, collecting invoices and attachments,
  and monitoring submission replies. Email guidance appears before file storage.
- Skill and plugin descriptions make clear that email support is incoming only.

## 1.0.506 — 2026-09-28

- Uploads require an explicit path; use `upload .` for the current folder or
  `upload PATH --dry-run` to inspect the selection without connecting.
- Permanent deletion requires an explicit account/bucket preview followed by
  `--confirm-delete TOKEN`. Confirmations expire after ten minutes and are single-use.
- Public CLI API/auth requests require https://app.revdoku.com. Storage transfers
  use approved HTTPS origins and cannot select local files outside the upload manifest.
- Skill packages contain one readable CLI implementation and a compatibility launcher.
- Preserve normal Rails storage uploads and macOS parent paths while validating
  headers and protecting temporary files. Deletion previews use current revision
  metadata and complete counts; offline upload previews honor the saved destination.

## 1.0.499 — 2026-09-25

- Filter messages by read status or attachments, and sort newest, oldest, or unread first.
- Choose a bucket name before creation and keep it ready when retrying a failed request.
- Review clearer activity totals and relative email arrival times, with exact timestamps on hover.
- Install portable agent skills with bundled resources and updated plugin metadata.

## 1.0.492 — 2026-09-23

- Store, share, and version files in private cloud buckets.
- Use each bucket as a mailbox for messages and attachments.
- Read decoded message bodies and originals through the CLI, API, or hosted MCP.
- Coordinate authorized agents with account selection, locks, and revision checks.

Current setup and usage: [README](./README.md), [mailbox guide](./docs.md),
[API](./api.md), and [MCP](./mcp.md).
