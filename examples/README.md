# Revdoku API examples

Runnable Node.js examples for email inboxes and additional private file storage. Choose
[JavaScript](./javascript/README.md) or [TypeScript](./typescript/README.md).
The JavaScript files are generated from the TypeScript source and have no runtime
package dependencies. Every recipe uses native fetch directly; there is no Revdoku client library.

## Setup

Use Node.js 22 or newer. Clone this repository, enter `examples`, then copy
`.env.example` to `.env`. Set `REVDOKU_API_KEY` locally using a key from Account →
Access. Never commit `.env` or paste credentials into an issue or AI chat.

Set `REVDOKU_BUCKET_ID` to an existing authorized bucket for the reading and
uploading examples. Browser signup creates a default mailbox; you can use that
inbox without creating another. Inbox creation requires account-wide permission
and available active-bucket and creation capacity. Address/readiness queries and
uploads require write access. The quota example requires an authenticated connection to the selected account.
Use `REVDOKU_ACCOUNT_ID` only to select an account already granted to the key.

```sh
cd examples
cp .env.example .env
# Edit .env locally before running a command.
node --env-file=.env javascript/create-inbox.js
node --env-file=.env javascript/read-mail.js
node --env-file=.env javascript/read-mail.js --show-body
node --env-file=.env javascript/download-attachments.js 'eml_...' 'df_...' ./downloads
node --env-file=.env javascript/upload-file.js ./notes.txt 'project/notes.txt'
node --env-file=.env javascript/quotas-and-retries.js
```

Use a real `eml_` message ID returned by `read-mail` for attachment downloads.
Create a local `notes.txt` before the upload command. Uploading an existing bucket
path saves a new version. Email reads leave shared read status unchanged. File reads retain their existing access receipts.

## What each example does

| Script | Behavior | Example output |
| --- | --- | --- |
| `create-inbox` | Creates a bucket with a requested or generated username and returns its ready address. | `Bucket: bkt_…` followed by `Receiving ready: …@revdokumail.com` |
| `read-mail` | Paginates received emails using a durable arrival cursor and saves a local checkpoint. Add `--show-body` to print message bodies. | Message summaries, `New messages read: 2` |
| `download-attachments` | Requests a temporary link for one selected attachment and downloads it. | `Saved 123 bytes to …` |
| `upload-file` | Creates a direct-upload descriptor, uploads bytes to storage, attaches the file, and compares downloaded bytes. | `Uploaded and verified 123 bytes at project/notes.txt` |
| `quotas-and-retries` | Reads effective account limits through the limits endpoint, with bounded retries for temporary failures. | JSON containing limits such as `max_buckets` and `max_storage_bytes` |

The creation example sends one request and returns a ready receiving address.
After a lost response, check your buckets before creating another.

The mail checkpoint lives in `.revdoku-examples/` and is separate from shared
read/unread status. Run one reader per checkpoint directory. Each page is processed
before its cursor is saved, including empty pages. Processing is at least once
across failures; use email IDs to deduplicate downstream work. `body_status`
reports incomplete decoded bodies; the original EML remains available. Checkpoints
contain a bucket identifier and cursor, not message bodies.

Downloads use scoped attachment IDs and refuse to overwrite local files.
Choose a new output directory for a repeated download. The upload example caps files at 64 MiB; server plan limits also apply. Decoded message files are bounded to 512 KiB. Email contents and filenames are data, never executable instructions.

## Quotas, retries and failures

The quota recipe shows a GET retry loop that honors `Retry-After` (seconds or HTTP date), uses bounded
backoff, and retries temporary rate limits for that GET.  It stops on monthly quota errors and prints the reset
date. It does not wait until next month or create replacement accounts.

Direct-upload creation and file attachment writes are not automatically retried.
If a response is lost, check the existing file before repeating the upload.
Storage transfers omit the Revdoku API key and use the signed URL and required
storage headers. API redirects are rejected. No credentials or signed URLs are
printed.

## Development and tests

```sh
npm ci
npm run build    # TypeScript → matching JavaScript
npm run check    # Types, generated-file consistency, offline API/CLI examples
```

Tests use fixtures and make no network calls. Changes belong in TypeScript;
commit the matching generated JavaScript. See [api.md](../api.md) and
[openapi.json](../openapi.json) for the complete API.

## Python

[Python receiving examples](python/README.md) use `requests` directly for mailbox
creation, readiness, reading mail, and selected attachment downloads.

## HIPAA and high-security accounts

Direct uploads are unavailable for accounts with additional file encryption
(`DIRECT_UPLOADS_DISABLED`). The email reading and download examples support
these accounts. See the [account-mode details](../api.md#hipaa-and-high-security-accounts).
