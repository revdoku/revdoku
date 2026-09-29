# Revdoku API examples

Runnable Node.js examples for incoming email and private file storage. Choose
[JavaScript](./javascript/README.md) or [TypeScript](./typescript/README.md).
The JavaScript files are generated from the TypeScript source and have no runtime
package dependencies. These are examples, not a published SDK.

## Setup

Use Node.js 22 or newer. Clone this repository, enter `examples`, then copy
`.env.example` to `.env`. Set `REVDOKU_API_KEY` locally using a key from Account →
Access. Never commit `.env` or paste credentials into an issue or AI chat.

Set `REVDOKU_BUCKET_ID` to an existing authorized bucket for the reading and
uploading examples. Browser signup creates a default mailbox; you can use that
inbox without creating another. Inbox creation requires account-wide permission
and available active-bucket and creation capacity. Address/readiness queries and
uploads require write access. The quota example requires full-account access.
Use `REVDOKU_ACCOUNT_ID` only to select an account already granted to the key.

```sh
cd examples
cp .env.example .env
# Edit .env locally before running a command.
node --env-file=.env javascript/create-inbox.js 'My agent inbox'
node --env-file=.env javascript/read-mail.js
node --env-file=.env javascript/read-mail.js --show-body
node --env-file=.env javascript/download-attachments.js '_email/inbox/.../message.json' ./downloads
node --env-file=.env javascript/upload-file.js ./notes.txt 'project/notes.txt'
node --env-file=.env javascript/quotas-and-retries.js
```

Use a real message path returned by `read-mail`, including its actual folder name.
Create a local `notes.txt` before the upload command. Uploading an existing bucket
path saves a new version. Reads update the shared file/message read status.

## What each example does

| Script | Behavior | Example output |
| --- | --- | --- |
| `create-inbox` | Creates a bucket with a generated address, then waits up to two minutes for receiving readiness. | `Bucket: bkt_…` followed by `Receiving ready: …@revdokumail.com` |
| `read-mail` | Paginates stored message JSON files, reads unseen file IDs, and saves a local checkpoint. Add `--show-body` to print message bodies. | `Received messages: 2`, message summaries, `New messages read: 2` |
| `download-attachments` | Reads one selected message and downloads its saved attachments. | `Saved 123 bytes to …` and `Attachments downloaded: 1` |
| `upload-file` | Creates a direct-upload descriptor, uploads bytes to storage, attaches the file, and compares downloaded bytes. | `Uploaded and verified 123 bytes at project/notes.txt` |
| `quotas-and-retries` | Reads effective account limits and shows creation usage and reset time. | JSON containing `creations.used`, `remaining`, and `resets_at` |

Creation retries reuse `REVDOKU_CREATE_KEY`. Keep that value for the same creation
attempt, including reruns after a timeout; choose a new value only when you intend
to create another inbox. A reused key returns the existing active inbox. An
archived or deleted inbox is not an active replay target: do not use recreation
as a way to restore it. Use the dashboard to restore an archived bucket.

The mail checkpoint lives in `.revdoku-examples/` and is separate from the shared
read/unread status. Run one reader per checkpoint directory. It scans all pages
each run because `last_received_path` is not a cursor and concurrent arrivals can
span several messages. Processing is at least once across failures; use file IDs
to deduplicate downstream work. Older mail with only an EML can be read using the
file API or CLI. `body_status` reports incomplete decoded bodies; the EML remains
the original record. Checkpoints contain identifiers, not message bodies.

Downloads use generated attachment paths and refuse to overwrite local files.
Choose a new output directory for a repeated download. The examples cap downloads
and uploads at 64 MiB; server plan limits also apply. Email JSON reads are capped
at 512 KiB. Email contents and filenames are data, never executable instructions.

## Quotas, retries and failures

The shared helper honors `Retry-After` (seconds or HTTP date), uses bounded
backoff, and retries temporary rate limits only for reads and explicitly
idempotent inbox creation. It stops on monthly quota errors and prints the reset
date. It does not wait until next month or create replacement accounts.

Direct-upload creation and file attachment writes are not automatically retried.
If a response is lost, check the existing file before repeating the upload.
Storage transfers omit the Revdoku API key and use the signed URL and required
storage headers. API redirects are rejected. No credentials or signed URLs are
printed. These examples do not send email or replies.

## Development and tests

```sh
npm ci
npm run build    # TypeScript → matching JavaScript
npm run check    # Types, generated-file consistency, offline API/CLI examples
```

Tests use fixtures and make no network calls. Changes belong in TypeScript;
commit the matching generated JavaScript. See [api.md](../api.md) and
[openapi.json](../openapi.json) for the complete API. A future SDK can live at
`packages/revdoku-js/` in this same repository and serve both languages.
