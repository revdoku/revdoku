# Revdoku packages and integrations

Choose the TypeScript or Python SDK for backend code, n8n or Zapier for automation, the CLI for terminal work, or hosted MCP for an AI connection. All use the same Revdoku accounts and mailboxes. Each mailbox has a receiving address and private file storage.

## Install a package

| Language or platform | Package | Install | Guide |
| --- | --- | --- | --- |
| TypeScript and JavaScript (Node.js 22 or later) | `revdoku` on npm | `npm install revdoku` | [TypeScript SDK](https://revdoku.com/docs/sdks/typescript.md) · [source](https://github.com/revdoku/revdoku-typescript) |
| Python 3.10 or later | `revdoku` on PyPI | `pip install revdoku` | [Python SDK](https://revdoku.com/docs/sdks/python.md) · [source](https://github.com/revdoku/revdoku-python) |
| n8n | `n8n-nodes-revdoku` | [Build and install on self-hosted n8n](https://github.com/revdoku/revdoku-n8n/blob/main/USAGE.md#install-from-source) | [n8n usage](https://github.com/revdoku/revdoku-n8n/blob/main/USAGE.md) |
| Zapier | Revdoku | [Request Zapier access](mailto:support@revdoku.com?subject=Revdoku%20Zapier%20access) | [Zapier tutorial](https://github.com/revdoku/revdoku-zapier/blob/main/TUTORIAL.md) |

The `revdoku` packages are API libraries. For the `revdoku` command-line tool, see https://revdoku.com/cli/.

n8n is available for self-hosted n8n, not n8n Cloud. For Zapier, request access from support before you start.

To make your first request, follow the [quickstart](https://revdoku.com/docs/quickstart.md). For direct HTTP calls without an SDK, use the [JavaScript, TypeScript and Python examples](https://github.com/revdoku/revdoku/tree/main/examples). For AI agents, use the [skill or plugin](https://github.com/revdoku/revdoku#local-ai-apps) or [hosted MCP](https://revdoku.com/mcp.md).

## What each package covers

The TypeScript and Python SDKs are generated from [OpenAPI](https://revdoku.com/openapi.json), which lists every public REST operation. The [API reference](https://revdoku.com/api/reference.md) shows each operation with SDK and cURL examples.

| Capability | SDKs | n8n | Zapier |
| --- | --- | --- | --- |
| List and create mailboxes | Yes | Yes | Find Mailbox / Create Mailbox |
| List/read email and set read status | Yes | Yes | Yes |
| Delete one email | Yes | Yes | Yes |
| Reply to a sender | Yes | Use direct HTTP | Use direct HTTP |
| Download original email or attachment | `downloadAttachment` / `download_attachment` return bytes; the other download operations return a temporary link | Returns binary data | Returns a file reference |
| List stored files | Yes | Yes | Find Mailbox File search |
| Upload files | `uploadFile` / `upload_file` | Yes | Yes |
| Read file metadata | Yes | Yes | Find Mailbox File |
| Download/delete other stored files | Yes; downloads return a temporary link | Yes | Delete Mailbox File; use direct HTTP for other operations |
| Mailbox aliases, sender restrictions and custom domains | Yes | Use direct HTTP | Use direct HTTP |
| Configure email webhooks and get live-subscription tickets | Yes; the receiver/WebSocket loop is application code | New Email uses polling | New Email uses polling |
| File version history and restore | Yes | Use direct HTTP | Use direct HTTP |

`uploadFile` (TypeScript) and `upload_file` (Python) compute the checksums, upload the bytes to storage without your API key, and save the file. See the [upload workflow](https://revdoku.com/api.md#upload-a-file).

`account_id` selects a granted account. Omitting it uses the key's default; a mailbox ID or a dashboard account switch does not select another account for that key. Discover accounts through `GET /v1/accounts`, `client.api.listAccounts` / `client.api.list_accounts`, CLI `revdoku accounts`, or MCP `account_list`.

| ID | Use |
| --- | --- |
| `acct_...` | Account containing the mailbox |
| `bkt_...` | Mailbox ID |
| `eml_...` | Revdoku email ID for read/download/update operations |
| Attachment `df_...` | One entry's `id` from the email's `attachments` array |
| `message_id` | Sender's Message-ID header; it is not the Revdoku email ID |

## URLs and response fields

| Caller | API configuration | Email text |
| --- | --- | --- |
| Raw HTTP | Requests go to `https://api.revdoku.com`; every path starts with `/v1`, for example `https://api.revdoku.com/v1/mailboxes` | `response.data.email.body_text` |
| TypeScript SDK | Default origin `https://api.revdoku.com`, without `/v1` | `(await client.getEmail({ mailboxId, emailId })).data.email.bodyText` |
| Python SDK | Same default origin | `client.get_email(mailbox_id, email_id).data.email.body_text` |
| n8n Get Email | Configured by the node | `$json.email.body_text` |
| Zapier Get Email | Configured by the integration | Map `body_text` from that action |

JSON and Python use snake_case names; TypeScript uses camelCase. Success responses keep `data` with a named resource. Email list results contain summaries; call `getEmail` / `get_email` to fetch `body_text`, `body_status` and attachment metadata.

## New email processing

| Approach | First run | Later runs and recovery |
| --- | --- | --- |
| Application with a saved arrival cursor (SDK or HTTP) | Starts where the application chooses | Persist `next_cursor` after processing, including empty pages; keep account/mailbox/order/filters fixed and deduplicate effects by email ID |
| n8n New Email | Skips existing mail by default; Include Existing Emails opts into backlog processing | Saves an arrival cursor, at most 1,000 messages per poll; large initial mailboxes need warmup. A manual test samples the newest email and does not advance the active cursor |
| Zapier New Email | Samples recent arrivals during setup | Reads the latest 1,000 arrivals; Zapier deduplicates IDs. More than 1,000 arrivals between successful polls can be missed |
| CLI `emails` / MCP `mailbox_email_list` | Lists according to the supplied filters | The caller must save and reuse `next_cursor` for continued polling |

Reading or downloading does not mark email read. Read status is shared with dashboard users and other integrations, so it cannot identify what one consumer has processed. Marking a message read is a separate operation. See the [API polling workflow](https://revdoku.com/api.md#poll-for-new-email) and the [webhook and live-event examples](https://github.com/revdoku/revdoku/blob/main/examples/README.md#new-email-notifications).

## Downloads

| Surface | Result | Next step |
| --- | --- | --- |
| SDK `downloadAttachment` / `download_attachment` | Attachment bytes, up to a size limit you can change | Save or process the bytes |
| SDK download-link operations | `data.download` with a URL, expiry and metadata | Fetch that URL with an ordinary HTTP client without the API key |
| n8n Download Attachment | Binary field `data` by default | Select that binary field on the next upload/storage node |
| Zapier Download Email File | `file`, a Zapier file reference | Map it into the next action's file input; the integration obtains a fresh URL when needed |
| CLI `email-download ... --output PATH` | Saved local file | Open or process that path |
| MCP `mailbox_email_download` | Temporary download descriptor | Use the returned link; hosted agents need an available download tool to retrieve bytes |

Temporary URLs expire after 15 minutes. Request another link when needed; do not store it as a permanent attachment URL. Body text can be null or truncated, so inspect `body_status`. Attachments remain separate files, and the original EML is available for the full original message.

## Errors and creation recovery

An API error has an HTTP status and `error.code`, `error.message`, and optional `error.details`. API error responses raise `RevdokuError`. Network, timeout and TLS failures raise the runtime's own errors (Node: `FetchError` from the SDK with the original error as `cause`; Python: urllib3 exceptions such as `urllib3.exceptions.SSLError`). Do not expect `data` on a failed call.

For `EMAIL_NOT_READY`, inspect `error.details.mailbox_id` and read that retained mailbox's receiving state. For a timeout with no response, reconcile the mailbox list before another creation attempt. Repeating creation can create a second mailbox and consume more capacity. Any `429` or `503` response with `Retry-After` (for example `503 EMAIL_LABELING_PENDING` or `503 EMAIL_INDEX_BUILDING`): wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. Never retry `EMAIL_LOOP_DETECTED`, and never retry creating a mailbox or sending an email automatically after an uncertain result. A monthly creation-capacity error requires waiting for its reset or changing capacity. [Full error reference](https://revdoku.com/api.md#errors).
