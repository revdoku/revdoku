# Revdoku API packages and integrations

Choose a language SDK for backend code, n8n or Zapier for automation, the CLI for terminal work, or hosted MCP for an AI connection. All use the same Revdoku accounts and mailboxes. Each mailbox has a receiving address and private file storage.

## Install a package

The twelve repositories below are public. GitHub source availability and package-registry availability are separate. The SDK setup guides work from source, including installation into your own application.

| Language or platform | Package | Working setup |
| --- | --- | --- |
| TypeScript and JavaScript | `@revdoku/api` | [Build from source and install a local npm tarball](https://github.com/revdoku/revdoku-typescript/blob/main/examples/README.md) |
| Python | `revdoku-api` / import `revdoku_api` | [Install the source directory with pip](https://github.com/revdoku/revdoku-python/blob/main/examples/README.md) |
| .NET and C# | `Revdoku.Api` | [Reference the source project](https://github.com/revdoku/revdoku-dotnet/blob/main/examples/README.md) |
| Java | `com.revdoku:revdoku-api` | [Install into your local Maven repository](https://github.com/revdoku/revdoku-java/blob/main/examples/README.md) |
| Go | `github.com/revdoku/revdoku-go` | [Install a versioned Git module](https://github.com/revdoku/revdoku-go/blob/main/examples/README.md) |
| Rust | `revdoku-api` / import `revdoku_api` | [Use a Cargo path dependency](https://github.com/revdoku/revdoku-rust/blob/main/examples/README.md) |
| PHP | `revdoku/api` | [Use a Composer path repository](https://github.com/revdoku/revdoku-php/blob/main/examples/README.md) |
| Ruby | `revdoku_api` | [Install a local gem or Gemfile path dependency](https://github.com/revdoku/revdoku-ruby/blob/main/examples/README.md) |
| Swift | `RevdokuAPI` | [Use Swift Package Manager with a Git tag](https://github.com/revdoku/revdoku-swift/blob/main/examples/README.md) |
| Dart | `revdoku_api` | [Use a pubspec path dependency](https://github.com/revdoku/revdoku-dart/blob/main/example/README.md) |
| n8n | `n8n-nodes-revdoku` | [Build and install on self-hosted n8n](https://github.com/revdoku/revdoku-n8n/blob/main/USAGE.md#install-from-source) |
| Zapier | Revdoku | [Request Zapier access](mailto:support@revdoku.com?subject=Revdoku%20Zapier%20access), then follow the [tutorial](https://github.com/revdoku/revdoku-zapier/blob/main/TUTORIAL.md) |

As checked on 2026-10-03, the eight SDK packages for npm, PyPI, NuGet, Maven Central, crates.io, Packagist, RubyGems and pub.dev were not available in those registries. Go and Swift have public Git tags. n8n has source installation; it is not available on n8n Cloud. For Zapier, request availability and access from support before starting. Use the source instructions above rather than assuming a registry command is available.

For direct HTTP calls without an SDK, use the [JavaScript, TypeScript and Python examples](../examples/README.md). For terminal use, install the [standalone CLI](../cli/README.md). For AI agents, use the [skill or plugin](../README.md#local-ai-apps) or [hosted MCP](../mcp.md).

## What each package covers

The language SDKs are generated from [OpenAPI](https://revdoku.com/openapi.json), which covers selected endpoints. The [complete REST reference](https://revdoku.com/api.md) also documents operations outside that schema.

| Capability | Language SDKs | n8n | Zapier |
| --- | --- | --- | --- |
| List and create mailboxes | Yes | Yes | Find Mailbox / Create Mailbox |
| List/read email and set read status | Yes | Yes | Yes |
| Delete one email | Yes | Yes | Yes |
| Download original email or attachment | Returns a temporary link | Returns binary data | Returns a file reference |
| List stored files | Yes | Yes | Find Mailbox File search |
| Upload files | Prepare and save through the SDK; npm also has `uploadFile` | Yes | Yes |
| Read file metadata | Yes | Yes | Find Mailbox File |
| Download/delete other stored files | Use direct HTTP | Yes | Delete Mailbox File; use direct HTTP for other operations |
| Mailbox aliases, sender restrictions and custom domains | Yes, where covered by OpenAPI | Use direct HTTP | Use direct HTTP |
| Configure email webhooks and get live-subscription tickets | Yes; the receiver/WebSocket loop is application code | New Email uses polling | New Email uses polling |
| Mailbox history | Use direct HTTP | Use direct HTTP | List Mailbox Versions / Get Mailbox Version |

For Node.js, use `Revdoku.uploadFile` to calculate checksums and upload bytes. Other SDKs expose `prepareFileUpload` and `saveUploadedFile`; send the bytes to the returned storage URL between these calls. Use only its returned headers, without the API key. See the [upload workflow](https://revdoku.com/api.md#upload-a-file).

## Make a first working integration

1. Sign up or sign in, then create a key under [Account → Access](https://app.revdoku.com/account/access). Signup creates a starter mailbox.
2. Give the key access to the intended account and mailbox. Read permission is sufficient to list/read email and download attachments. Creating another mailbox requires account-wide admin permission. A key restricted to selected mailboxes cannot create mailboxes.
3. Follow your package's setup guide above. Run its read-only **List mailboxes** example and keep the returned `bkt_...` ID.
4. Send a small message with an attachment from your normal email app to the mailbox's exact receiving address. The dashboard shows the address to an authorized writer; a read-only consumer can use the address supplied during provisioning.
5. Run **Read emails**, copy the returned email and attachment IDs, then run **Download attachment**. Each language guide shows the commands and expected output.

`account_id` selects a granted account. Omitting it uses the key's default; a mailbox ID or a dashboard account switch does not select another account for that key. Discover accounts through `GET /v1/accounts`, the SDK's `listAccounts` equivalent, CLI `revdoku accounts`, or MCP `account_list`.

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
| Raw HTTP | REST base `https://api.revdoku.com/v1` | `response.data.email.body_text` |
| TypeScript SDK | Default origin `https://api.revdoku.com`; generated paths include `/v1` | `result.data.email.bodyText` |
| Python SDK | Same default origin | `result.data.email.body_text` |
| C# SDK | Same default origin | `result.Data.Email.BodyText` |
| n8n Get Email | Configured by the node | `$json.email.body_text` |
| Zapier Get Email | Configured by the integration | Map `body_text` from that action |

Other language guides list their SDK members. Use the generated member names when writing code; the REST reference describes JSON field names. Success responses retain `data` with a named resource. List-email results contain summaries; call Get Email to fetch `body_text`, `body_status` and attachment metadata.

## New email processing

| Approach | First run | Later runs and recovery |
| --- | --- | --- |
| SDK Read emails example | Reads unread mail in arrival order | Starts again each run; prints messages that remain unread |
| Application with a saved arrival cursor | Starts where the application chooses | Persist `next_cursor` after processing, including empty pages; keep account/mailbox/order/filters fixed and deduplicate effects by email ID |
| n8n New Email | Skips existing mail by default; Include Existing Emails opts into backlog processing | Saves an arrival cursor, at most 1,000 messages per poll; large initial mailboxes need warmup. A manual test samples the newest email and does not advance the active cursor |
| Zapier New Email | Samples recent arrivals during setup | Reads the latest 1,000 arrivals; Zapier deduplicates IDs. More than 1,000 arrivals between successful polls can be missed |
| CLI `emails` / MCP `mailbox_email_list` | Lists according to the supplied filters | The caller must save and reuse `next_cursor` for continued polling |

Reading or downloading does not mark email read. Read status is shared with dashboard users and other integrations, so it cannot identify what one consumer has processed. Marking a message read is a separate operation. See the [API polling workflow](https://revdoku.com/api.md#poll-for-new-messages) and the [HTTP webhook and live-event examples](../examples/README.md#new-email-notifications).

## Downloads

| Surface | Result | Next step |
| --- | --- | --- |
| Generated SDK download-URL method | `data.download` with a URL, expiry and metadata | Fetch that URL with an ordinary HTTP client without the API token; the shipped attachment example does both steps |
| n8n Download Attachment | Binary field `data` by default | Select that binary field on the next upload/storage node |
| Zapier Download Email File | `file`, a Zapier file reference | Map it into the next action's file input; the integration obtains a fresh URL when needed |
| CLI `email-download ... --output PATH` | Saved local file | Open or process that path |
| MCP `mailbox_email_download` | Temporary download descriptor | Use the returned link; hosted agents need an available download tool to retrieve bytes |

Temporary URLs expire after 15 minutes. Request another link when needed; do not store it as a permanent attachment URL. Body text can be null or truncated, so inspect `body_status`. Attachments remain separate files, and the original EML is available for the full original message.

## Errors and creation recovery

An API error has an HTTP status and `error.code`, `error.message`, and optional `error.details`. The SDK guides show how to extract them from each language's native exception. Do not expect `result.data` on a failed call.

For `EMAIL_NOT_READY`, inspect `error.details.mailbox_id` and read that retained mailbox's receiving state. For a timeout with no response, reconcile the mailbox list before another creation attempt. Repeating creation can create a second mailbox and consume more capacity. A 429 rate limit permits a bounded read retry after `Retry-After`; a monthly creation-capacity error requires waiting for its reset or changing capacity. [Full error reference](https://revdoku.com/api.md#common-errors).
