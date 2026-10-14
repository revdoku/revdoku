# Revdoku API

Revdoku provides **email mailboxes for humans and AI agents**, with private file
storage in each mailbox. The REST API creates mailboxes, lists and reads email,
downloads attachments, replies to senders and stores files.

The [OpenAPI document](https://revdoku.com/openapi.json) lists every operation and
field. This guide explains how to use them.

## Find what you need

| Task | Section |
| --- | --- |
| Make your first request | [Quick start](#quick-start) |
| Understand JSON, errors and pages | [Requests and responses](#requests-and-responses) |
| Select an account or read quotas | [Accounts](#accounts) |
| Create, archive or delete a mailbox | [Mailboxes](#mailboxes) |
| Read email and attachments | [Emails](#emails) |
| Reply to a sender | [Send a reply](#send-a-reply) |
| Get notified about new email | [Webhooks and live subscriptions](#webhooks-and-live-subscriptions) |
| Change addresses, aliases or allowed senders | [Email settings](#email-settings) |
| Upload and organize files | [Files](#files) |
| Upload a folder or many files | [Upload many files](#upload-many-files) |
| Use your own domain | [Custom email domains](#custom-email-domains) |
| Choose an SDK, n8n or Zapier | [Package directory](https://github.com/revdoku/revdoku/blob/main/guides/api-packages.md) |
| Build customer mailboxes in your application | [SaaS mailbox guide](https://github.com/revdoku/revdoku/blob/main/guides/saas-mailboxes.md) |

## Quick start

1. Sign in and create an API key in **Connect via API** or **Account → Access**.
   If you need an account, [browser signup](https://app.revdoku.com/users/sign_up)
   creates your first mailbox.
2. Keep the key on your backend.
3. List your mailboxes and keep one `id`:

```http
GET /v1/mailboxes
Authorization: Bearer YOUR_API_KEY
```

4. Send an email to that mailbox's `email.address`.
5. List its email:

```http
GET /v1/mailboxes/bkt_example/emails
Authorization: Bearer YOUR_API_KEY
```

200 OK

```json
{
  "success": true,
  "data": {
    "emails": [],
    "pagination": { "limit": 50, "has_more": false, "next_cursor": "OPAQUE_CURSOR" }
  }
}
```

| Setting | Value |
| --- | --- |
| Base URL | `https://api.revdoku.com/v1` |
| Authentication | `Authorization: Bearer YOUR_API_KEY` |
| JSON requests | `Content-Type: application/json` |

The TypeScript SDK (`@revdoku/api`) is not published on npm yet. Use the REST
requests in this guide and the runnable [examples](https://github.com/revdoku/revdoku/tree/main/examples),
or [build the SDK from source](https://github.com/revdoku/revdoku/blob/main/guides/api-packages.md).

## Authentication

Send your API key in every request as `Authorization: Bearer YOUR_API_KEY`.
Browser session cookies belong to the Revdoku dashboard. They are not an API
credential, and dashboard routes are not part of this API: an API key receives
`404 NOT_FOUND` for every route that the OpenAPI document does not list.

| Scope | Access |
| --- | --- |
| `mailbox_read` | Read permitted mailboxes, email and files. |
| `mailbox_write` | Also write files, send replies and read address settings. |
| `mailbox_admin` | Also manage permitted mailboxes. Creating a mailbox needs access to all mailboxes. |

A key can be limited to selected mailboxes. `GET /v1/status` shows the scope and
mailbox access of the key.

The CLI and AI agents sign in with the endpoints below. Backend applications use
an API key from the dashboard instead.

| Method | Path | Purpose |
| --- | --- | --- |
| POST | `/v1/agent_auth/request_code` | Email a sign-in code to an existing account. The answer never shows if the account exists. |
| POST | `/v1/agent_auth/verify_code` | Exchange the code for an API key. Send `email`, `code`, and optionally `label`, `permission_scope`, `mailbox_access` and `mailbox_ids`. |
| POST | `/v1/agent_auth/exchange_grant` | Exchange a one-time dashboard connection code (`grant_token`) for an API key. |
| POST | `/v1/agent_auth/browser_login_link` | Get a dashboard link for a `redirect_path`. The user signs in normally; the link grants nothing. |

The [authentication guide](https://github.com/revdoku/revdoku/blob/main/guides/authentication.md)
shows the requests and the selected-mailbox options.

AI connectors can use the hosted MCP server instead. Its tools return the same
resources, field names and error codes as this API. See the [MCP guide](https://revdoku.com/mcp.md).

## Requests and responses

### Response envelope

| Field | Success | Failure |
| --- | --- | --- |
| `success` | `true` | `false` |
| `data` | Named resources, such as `mailbox` or `mailboxes`. | Omitted. |
| `error` | Omitted. | Error details. |

| Error field | Meaning |
| --- | --- |
| `error.code` | Stable identifier, such as `MAILBOX_NOT_FOUND`. The OpenAPI `ErrorCode` schema lists the documented codes. |
| `error.message` | Readable explanation. |
| `error.details` | Optional data, such as `retry_after` or a list of `field` and `message` pairs. |
| `error.request_id` | Identifier to give to support. |

Invalid input always returns HTTP `422` with code `INVALID_ARGUMENT`. This includes
malformed JSON, bad cursors, values out of range and the `offset`, `page` and
`per_page` parameters. The mailbox list and mailbox read also reject unknown query
parameters.

### Lists

Every list uses the same page rules.

| Parameter | Default | Meaning |
| --- | --- | --- |
| `limit` | `50` | Items per page, from 1 to 200. |
| `cursor` | First page | `pagination.next_cursor` from the previous page. |

| Response field | Meaning |
| --- | --- |
| `pagination.limit` | Page size used. |
| `pagination.has_more` | `true` when another page exists. |
| `pagination.next_cursor` | Cursor for the next page, or `null` on the last page. Email lists always return a cursor; see [Poll for new email](#poll-for-new-email). |

1. Request the first page with your filters.
2. While `has_more` is `true`, request `cursor=next_cursor` with the same filters.
3. Treat cursors as opaque strings. A cursor works only for the list and filters that issued it.

A cursor continues after the last item of the previous page, so items added or
deleted between requests do not repeat or skip other items. File lists without
`folder` show the most recently changed files first; a file that changes while you
page moves to the first page.

### Deletes

Every delete returns HTTP `200`:

```json
{ "success": true, "data": { "deleted": true, "id": "df_example" } }
```

Deleting a webhook returns the mailbox ID, also when no webhook is set.

### Account selection

A key can reach one or more accounts. Each request works on one account.

| Input | Where | Behavior |
| --- | --- | --- |
| `account_id` | Query parameter for GET; JSON field for writes | Selects a granted account for this request only. |
| Omitted | — | Uses the key's default account. |
| Conflicting values | — | `422 ACCOUNT_SELECTOR_CONFLICT`. |

### Action reasons

Send an optional `reason` (query parameter for reads, JSON field for writes) to record
why you read or changed something. It appears in the activity log and in file
version history. Maximum 2,000 characters. Do not include secrets or content.

### Concurrent changes

| Parameter | Used by | Compare with |
| --- | --- | --- |
| `expected_metadata_version` | `PATCH /v1/mailboxes/{mailbox_id}` | `mailbox.metadata_version` |
| `expected_mailbox_version` | `POST /v1/mailboxes/{mailbox_id}/files`, `POST .../files/append_text`, `POST .../upload_sessions` | `mailbox.version_id` |
| `expected_address` | `POST /v1/mailboxes/{mailbox_id}/email/rotate` | `address` from the email settings |
| `expected_version` | `PATCH /v1/mailboxes/{mailbox_id}/email/allowlist` | `sender_allowlist.version` |

A stale value changes nothing and returns `409`. Read the resource again, then retry.

## Accounts

| Method | Path | Result |
| --- | --- | --- |
| GET | `/v1/status` | `data.connection` (key scope and mailbox access), `data.account`, `data.user` and `data.dashboard_url`. Works with every key. |
| GET | `/v1/accounts` | `data.accounts`, `data.default_account_id`, `data.pagination`. |
| GET | `/v1/accounts/{account_id}` | `data.account`. |
| POST | `/v1/accounts` | Creates a client account; see below. |
| GET | `/v1/account/limits` | `data.limits` for the selected account. |

| Account field | Meaning |
| --- | --- |
| `id` | Account ID for `account_id`. |
| `name` | Account name. |
| `account_kind` | `standard`, `agency` or `client`. |
| `client_name` | Optional client person or business name. |
| `agency_account` | Parent agency, when this key can access it. |
| `status` | `active` or `read_only`. |
| `permissions` | `scope`, `mailbox_access` and `can_create_mailboxes` for this key. |

### Client accounts

An agency owner key with client-account access can create client accounts. Send
`name`, optionally `client_name` (at most 100 characters), and `account_id` of the
agency when it is not the default. The key's default account does not change.
Clients share the agency's plan and quotas; files and members stay separate.

### Limits

`GET /v1/account/limits` returns the effective values of the plan and account
overrides. Zero means no allowance; `null` means no cap. Storage, mailbox and
email traffic allowances are shared within a billing group.

| Field in `limits` | What it limits |
| --- | --- |
| `max_mailboxes` | Active mailboxes. |
| `max_mailbox_creations_per_month` | New mailboxes per UTC calendar month. Deletion does not refund. |
| `max_files_per_mailbox`, `max_current_files` | Current files per mailbox and in total. |
| `max_storage_bytes` | Stored bytes. |
| `max_file_size_bytes`, `max_pdf_size_bytes` | Bytes in one file or one PDF. |
| `max_file_versions_per_file` | Kept versions of each file. |
| `max_email_domains` | Custom email domains. |
| `max_email_aliases_per_mailbox` | Alias addresses per mailbox. |
| `max_email_address_rotations_per_month` | Address changes per UTC calendar month. |
| `max_received_emails_per_month`, `max_received_email_bytes_per_month` | Incoming email per billing period. |
| `max_received_email_message_bytes` | Bytes in one incoming email. |
| `max_sent_emails_per_month` | Sent-email recipients per billing period. |
| `max_account_members`, `max_api_keys`, `max_agent_connections` | People and connections. |
| `api_rate_limit_requests_per_minute` | API requests per minute. |
| `audit_retention_days` | Activity log retention. |

Keys with access to all mailboxes also get `data.usage.mailbox_creations`
(`monthly_limit`, `used`, `remaining`, `resets_at`).

## Mailboxes

| Method | Path | Result |
| --- | --- | --- |
| GET | `/v1/mailboxes` | `data.mailboxes`, `data.counts`, `data.pagination`. |
| POST | `/v1/mailboxes` | `201` with `data.mailbox`. |
| GET | `/v1/mailboxes/{mailbox_id}` | `data.mailbox`. Reading never changes the mailbox. |
| PATCH | `/v1/mailboxes/{mailbox_id}` | `data.mailbox`. |
| POST | `/v1/mailboxes/{mailbox_id}/archive` | `data.mailbox`. Archived mailboxes are read-only. |
| POST | `/v1/mailboxes/{mailbox_id}/unarchive` | `data.mailbox`. |
| DELETE | `/v1/mailboxes/{mailbox_id}` | Permanently deletes an archived mailbox. |

### List filters

| Parameter | Meaning |
| --- | --- |
| `status` | `active` (default), `archived` or `all`. |
| `q` | Text in the permitted address or mailbox ID. |
| `limit`, `cursor` | See [Lists](#lists). |

`data.counts` has `active`, `archived` and `total` mailboxes that match `q`.

### Create a mailbox

```http
POST /v1/mailboxes
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{ "mailbox": { "email": { "username": "acme-orders" } } }
```

201 Created (selected fields)

```json
{
  "success": true,
  "data": {
    "mailbox": {
      "id": "bkt_example",
      "email": {
        "address": "acme.orders.k7m2x9q4v8nc@revdokumail.com",
        "receiving_enabled": true,
        "sending_enabled": true
      }
    }
  }
}
```

| Field | Default | Purpose |
| --- | --- | --- |
| `mailbox.email.username` | Generated name | Free: a prefix; Revdoku adds a permanent 12-character random suffix. Paid: the exact name before `@`. |
| `mailbox.email.domain` | Platform domain | `revdokumail.com`, or a ready custom domain of this account. |
| `mailbox.description` | Empty | Optional description, at most 2,000 characters. |
| `mailbox.metadata` | `{}` | Your application data. |

| Username rule | Behavior |
| --- | --- |
| Characters | ASCII letters, digits, dots, hyphens and underscores; stored in lowercase. |
| Empty or `null` | `422 EMAIL_NAME_INVALID`. |
| Reserved word, such as `support` or `sales` | `422 EMAIL_NAME_RESERVED`. Use a custom domain for such names. |
| Address in use or retired | `409 EMAIL_ALREADY_EXISTS`. |

- Success means the address can receive email now.
- If confirmation takes longer than 25 seconds, the API returns `503 EMAIL_NOT_READY`
  with the created `mailbox_id` in `error.details`. Read that mailbox; do not create another.
- Never retry a creation automatically. After a lost response, list mailboxes first.

### Mailbox fields

| Field | Meaning |
| --- | --- |
| `id` | Mailbox ID for API calls. |
| `email.address` | Primary address. Shown to keys with write access. Use it as the mailbox label. |
| `email.message_count`, `email.unread_count` | Stored and unread email. `null` while the email index is prepared. |
| `email.last_received_at` | Time of the latest received email. |
| `email.receiving_enabled`, `email.blocked_reason` | Receiving state and, when off, the reason. |
| `email.sending_enabled`, `email.sending_blocked_reason` | Reply sending state and, when off, the reason. |
| `description`, `metadata` | Your data. |
| `metadata_version` | Send as `expected_metadata_version` on PATCH. Changes only when `description` or `metadata` changes. |
| `version_id`, `version_number` | Current file-tree version. Send `version_id` as `expected_mailbox_version` on file writes. |
| `files_count`, `storage_bytes` | Current files (including stored email) and bytes. |
| `archived`, `archived_at` | Archive state. |
| `lock` | Present while a long operation, such as a delete, holds the mailbox. |
| `archive`, `unarchive`, `delete` | Whether the action is allowed now (`allowed`, `blocked_reason`, `required_action`). `delete.confirmation` is the value to send when deleting. |
| `dashboard_url` | Opens the mailbox for signed-in members. It grants no access. |

### Update a mailbox

```json
{
  "expected_metadata_version": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "mailbox": { "description": "Orders", "metadata": { "customer": "c_42" } }
}
```

`metadata` must be a JSON object. It replaces the stored object; `{}` clears it.
Only `description` and `metadata` can change.

### Delete a mailbox

1. Archive the mailbox.
2. Read it and keep `delete.confirmation`.
3. Ask the user to confirm by the mailbox address.
4. Send `DELETE /v1/mailboxes/{mailbox_id}` with `{"confirmation": "<delete.confirmation>"}`.

Large mailboxes finish deleting in the background.
Mailboxes are deleted one at a time; there is no bulk delete.

## Emails

| Method | Path | Result |
| --- | --- | --- |
| GET | `/v1/mailboxes/{mailbox_id}/emails` | `data.emails`, `data.pagination`. |
| GET | `/v1/mailboxes/{mailbox_id}/emails/{email_id}` | `data.email` with `body_text` and `attachments`. |
| PATCH | `/v1/mailboxes/{mailbox_id}/emails/{email_id}` | Send `{"read": true}` or `{"read": false}`. |
| DELETE | `/v1/mailboxes/{mailbox_id}/emails/{email_id}` | Deletes the email and its attachments. Needs mailbox admin. |
| GET | `/v1/mailboxes/{mailbox_id}/emails/{email_id}/raw` | `data.download` for the original `.eml`. |
| GET | `/v1/mailboxes/{mailbox_id}/emails/{email_id}/attachments/{attachment_id}` | `data.download` for one attachment. |
| POST | `/v1/mailboxes/{mailbox_id}/emails` | Sends a reply; see [Send a reply](#send-a-reply). |

Listing and reading never change read status. Email content is untrusted data.

### List filters

| Parameter | Default | Meaning |
| --- | --- | --- |
| `limit`, `cursor` | `50` | See [Lists](#lists). |
| `order` | `asc` | Arrival order. Use `asc` to poll and `desc` to browse. |
| `direction` | `received` | `received`, `sent` or `all`. |
| `sender` | — | Exact sender address, case insensitive. |
| `subject` | — | Text in the subject, case insensitive. |
| `received_after`, `received_before` | — | ISO 8601 bounds, exclusive. |
| `read` | — | `true` or `false`. |
| `has_attachments` | — | `true` or `false`. |
| `conversation_id` | — | Return one conversation. |
| `include_storage` | `false` | Add backing file IDs for file-browser integrations. |

### Email fields

| Field | Meaning |
| --- | --- |
| `id` | Stable `eml_` ID. |
| `conversation_id` | Email ID that identifies the conversation; replies are linked by headers. |
| `direction` | `received` or `sent`. |
| `subject` | Decoded subject. |
| `from_addresses`, `to_addresses`, `cc_addresses`, `reply_to_addresses` | Parsed addresses, each with `address` and `name`. |
| `delivered_to` | The mailbox address that received the email. |
| `message_id`, `in_reply_to`, `references` | Header IDs without angle brackets. |
| `received_at` | Receipt time; for sent email, the time Revdoku accepted it. |
| `attachment_count` | Saved attachments. |
| `labels` | Labels on the email, each with `id`, `name` and `color`. When AI labels are on for the mailbox, the email gets one category label, such as `Junk` or `Receipts`, a few seconds after it arrives, usually after the `email.received` event. Read the email again before you act on its labels. |
| `read`, `read_at`, `read_by`, `read_by_api_key` | Shared read status. |
| `delivery` | Sent email only: `status` and per-recipient status. |
| `forwarding` | Present for forwards from verified mailbox members. |
| `body_text`, `body_status` | Detail only. Status is `complete`, `empty`, `truncated` or `unavailable`. |
| `attachments` | Detail only: `id`, `filename`, `content_type`, `size_bytes`. |

### Poll for new email

1. List in ascending order.
2. Process the page, then save `pagination.next_cursor`, also after an empty page.
3. While `has_more` is `true`, request the next page at once.
4. Otherwise wait, then request the saved cursor again with the same filters.

Use the email `id` to skip duplicates after retries.

### Download links

| `data.download` field | Meaning |
| --- | --- |
| `url` | Temporary URL. Fetch it without your API key. |
| `filename`, `content_type`, `size_bytes` | File facts. |
| `expires_in` | `900` seconds. Request a new link after it expires. |

### Send a reply

A mailbox sends replies from its platform address. Recipients must have emailed the
mailbox before and passed sender authentication. Sending needs mailbox write access.
Send only when the mailbox's `email.sending_enabled` is `true`. Otherwise the
request returns `403 EMAIL_SENDING_UNAVAILABLE`.

1. List received email and keep the `id` of the email to answer.
2. Send the reply:

```http
POST /v1/mailboxes/bkt_example/emails
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{ "in_reply_to": "eml_received", "text": "Thanks, we received your invoice." }
```

3. Read the email later and check `delivery.status`.

| Field | Required | Meaning |
| --- | --- | --- |
| `text` | Yes | Plain-text body, up to 1 MiB. |
| `in_reply_to` | No | Received `eml_` ID. Sets reply headers, recipient and subject. |
| `to`, `cc` | Without `in_reply_to` | Up to 10 addresses together. |
| `subject` | Without `in_reply_to` | Up to 255 characters. |
| `html` | No | HTML body, up to 1 MiB. |
| `attachment_ids` | No | Up to 10 file IDs from this mailbox. |

| `delivery.status` | Meaning |
| --- | --- |
| `queued`, `sending` | Waiting or sending. |
| `sent` | The provider accepted the email. |
| `failed` | Not sent. |
| `uncertain` | Unknown result. Do not send again; check `direction=sent` first. |

After a timeout or unknown result, list `direction=sent` before you send again.
Sent copies are stored under `_email/sent/` and count toward storage.

## Webhooks and live subscriptions

| Method | Path | Result |
| --- | --- | --- |
| GET / PUT / DELETE | `/v1/mailboxes/{mailbox_id}/email/webhook` | Read, set (`webhook_url`, `rotate_secret`) or remove one webhook. Needs mailbox admin. |
| GET | `/v1/mailboxes/{mailbox_id}/email/subscription` | A WebSocket ticket for live events. Needs mailbox read. |

PUT returns `signing_secret` only when it issues one: for a new URL or with
`rotate_secret: true`. Verify signatures, skip duplicate event IDs and
catch up with the email list cursor after every disconnect. See
[Email events](https://github.com/revdoku/revdoku/blob/main/guides/email-events.md).

## Email settings

`GET /v1/mailboxes/{mailbox_id}/email` returns the address settings. It needs
mailbox write access.

| Field | Meaning |
| --- | --- |
| `address`, `username` | Primary address and the part before `@`. |
| `aliases` | Extra addresses: `id`, `address`, `active`. |
| `available_domains` | Domains you can use for addresses. |
| `assignment` | State of a pending address change. |
| `customization` | Whether this key can choose names. |
| `sender_allowlist` | Allowed senders. Shown to account administrators with mailbox admin. |

### Change the address

Requires a paid plan and mailbox admin.

1. Read the email settings.
2. Send `POST /v1/mailboxes/{mailbox_id}/email/rotate`:

| Field | Required | Meaning |
| --- | --- | --- |
| `confirm` | Yes | `true`. |
| `expected_address` | Yes | Current `address` from step 1. |
| `username` | No | New name; omit for a generated name. |
| `domain` | No | Available platform domain, a ready custom domain, or `platform`. |
| `keep_old_as_alias` | No | Keep the old address as an alias. |

3. On `202`, read the settings until `assignment.status` is `active` or `failed`.

The old address stops receiving unless you keep it as an alias. Check
`max_email_address_rotations_per_month` in the limits.

### Aliases

| Method | Path | Meaning |
| --- | --- | --- |
| POST | `/v1/mailboxes/{mailbox_id}/email/aliases` | Add `username` (and optional `domain`). Returns `202`; read the settings until the alias is ready. |
| DELETE | `/v1/mailboxes/{mailbox_id}/email/aliases/{alias_id}` | Remove one alias. Saved email stays. |

Aliases need a paid plan and a full-account owner or administrator with mailbox admin.

### Allowed senders

```http
PATCH /v1/mailboxes/bkt_example/email/allowlist
Content-Type: application/json

{
  "sender_allowlist": { "enabled": true, "entries": ["sender@example.com", "vendor.example"] },
  "expected_version": "VERSION_FROM_SETTINGS"
}
```

Entries are exact addresses or domains, up to 500, with no wildcards. A stale
version returns `409 EMAIL_ALLOWLIST_CHANGED`; invalid entries return
`422 EMAIL_ALLOWLIST_INVALID`.

## Files

| Method | Path | Result |
| --- | --- | --- |
| POST | `/v1/direct_uploads` | Upload step 1: a storage URL. |
| POST | `/v1/mailboxes/{mailbox_id}/files` | Upload step 3: save the file. |
| POST | `/v1/mailboxes/{mailbox_id}/upload_sessions` | Start a batch upload; see [Upload many files](#upload-many-files). |
| GET | `/v1/mailboxes/{mailbox_id}/files` | `data.files`, `data.pagination`. Filters: `q`, `folder`. |
| GET | `/v1/mailboxes/{mailbox_id}/files/by_path?path=...` | `data.file` metadata only for a path. `disposition` and `content_url` return `422 INVALID_ARGUMENT`; download content with `.../files/{file_id}/download`. |
| GET | `/v1/mailboxes/{mailbox_id}/files/{file_id}` | `data.file`. |
| GET | `/v1/mailboxes/{mailbox_id}/files/{file_id}/download` | `data.download` and `data.version`. Optional `version_id`. |
| POST | `/v1/mailboxes/{mailbox_id}/files/append_text` | Appends text to an existing text file. |
| POST | `/v1/mailboxes/{mailbox_id}/files/{file_id}/rename` | New path in the same mailbox (`new_path`). |
| POST | `/v1/mailboxes/{mailbox_id}/files/{file_id}/move` | Move, optionally to `target_mailbox_id`. |
| POST | `/v1/mailboxes/{mailbox_id}/files/{file_id}/copy` | Copy, optionally to `target_mailbox_id`. |
| GET | `/v1/mailboxes/{mailbox_id}/files/{file_id}/versions` | `data.versions`, newest first. |
| POST | `/v1/mailboxes/{mailbox_id}/files/{file_id}/versions/{version_id}/restore` | New current version from an older one. |
| DELETE | `/v1/mailboxes/{mailbox_id}/files/{file_id}` | Deletes the file. Needs mailbox admin. |

Reading metadata never marks a file read. A download link request marks that
version read. Move and copy accept `target_path` for an exact path or
`target_folder` to keep the file name.

Paths keep Unicode letters, digits, punctuation and symbols in NFC form. Control,
bidi and zero-width characters are removed. ASCII characters such as `#`, `%`, `?`
and `*`, and characters that look like `/` or `\`, become `-`. Other space
characters, such as a no-break space, become an ASCII space. Upload responses
return the stored path; match rows by `input_index`, not by path.

Stored email lives under `_email/`. These files are read-only for the file
operations: uploads, appends, renames, moves, copies, restores and deletes that
touch `_email/` return `422 EMAIL_PATH_READ_ONLY`. Use the email operations instead.

### Upload a file

1. Prepare the upload:

```http
POST /v1/direct_uploads
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "mailbox_id": "bkt_example",
  "path": "reports/summary.txt",
  "blob": {
    "filename": "summary.txt",
    "byte_size": 1234,
    "checksum": "BASE64_MD5",
    "content_type": "text/plain",
    "sha256": "HEX_SHA256",
    "purpose": "mailbox_file"
  }
}
```

2. `PUT` the bytes to `data.direct_upload.url` with exactly the headers in
   `data.direct_upload.headers`. Do not send your API key there.
3. Save the file:

```http
POST /v1/mailboxes/bkt_example/files
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{ "path": "reports/summary.txt", "signed_blob_id": "<data.signed_id from step 1>" }
```

| Save field | Meaning |
| --- | --- |
| `path` | Destination path. An existing path gets a new version. |
| `signed_blob_id` | `data.signed_id` from step 1. |
| `existing_file_policy` | `replace` (default) or `skip`. |
| `expected_mailbox_version` | Optional mailbox `version_id` from your last read. |

If step 1 returns `200` with `duplicate: true`, the same content is already
stored at the path; skip steps 2 and 3. The
[examples](https://github.com/revdoku/revdoku/tree/main/examples) compute the
checksums. For a folder, use an upload session: it needs about two requests per
batch instead of two per file.

### Upload many files

An upload session uploads a folder or many files in batches and saves them as one
mailbox version. While the session is open, other writers wait; incoming email
still arrives. Only the API key that created the session can call `uploads`,
`finalize_batch` and `finalize`; other callers get `404 NOT_FOUND`.

| Method | Path | Result |
| --- | --- | --- |
| POST | `/v1/mailboxes/{mailbox_id}/upload_sessions` | `201` with `data.mailbox_upload_session` and `data.uploads` for the first batch. |
| POST | `/v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/uploads` | `data.uploads` for the next batch. |
| POST | `/v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/finalize_batch` | Saves up to `limit` (1 to 40, default 40) uploaded files. |
| POST | `/v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/finalize` | Finishes the session, or cancels it with `complete: false`. |

1. Start the session:

```http
POST /v1/mailboxes/bkt_example/upload_sessions
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "expected_file_count": 2,
  "client_session_key": "backup-2026-10-11",
  "files": [
    {
      "path": "reports/q3.pdf",
      "byte_size": 48213,
      "content_type": "application/pdf",
      "checksum": "BASE64_MD5",
      "sha256": "HEX_SHA256"
    }
  ]
}
```

2. For each item in `data.uploads`, `PUT` the bytes of `path` to `upload.url` with
   exactly the headers in `upload.headers`. Do not send your API key there.
3. Save the batch with `POST .../finalize_batch`.
4. Send the next batch of `files` to `POST .../uploads`, then repeat steps 2 and 3.
5. Finish with `POST .../finalize`. If the answer is `202` with
   `finalize_pending: true`, wait for `Retry-After` and call it again.
6. If an upload fails for good, cancel with `{"complete": false}`. Files that
   `finalize_batch` saved stay; the other files are discarded.

| Session field | Meaning |
| --- | --- |
| `files[]` | `path`, `byte_size`, `content_type`, `checksum` (Base64 MD5) and `sha256` (hex) of each file. |
| `expected_file_count` | Total files in the session, for progress. |
| `client_session_key` | Your key for this batch. Sending it again with the same credential while the session is open returns that session. |
| `existing_file_policy` | `replace` (default) gives existing paths a new version; `skip` keeps them. |
| `expected_mailbox_version` | Optional mailbox `version_id` from your last read. |

| Result field | Meaning |
| --- | --- |
| `mailbox_upload_session` | `id`, `status` (`pending`, `finalized`, `failed` for canceled, `expired`), file counts and `uploads_expire_at`. |
| `uploads` | Storage targets: `path`, `upload.url`, `upload.headers`. |
| `uploaded` | Files saved by this request: `path`, `file`, `version`, `created`. |
| `skipped` | Files not saved, each with a `code`: identical content (`DUPLICATE_FILE_VERSION`), or a path that repeats an earlier path in the session after normalization (`UPLOAD_PATH_REPEATED`). The other files still upload. |
| `finalize_pending`, `remaining_files_count` | Finalize only: more files remain. |

- If `finalize_batch` returns `DIRECT_UPLOAD_NOT_FOUND`, `error.details.path` names a
  file without bytes. Send it to `POST .../uploads` again, upload it, then retry.
- A session expires at `uploads_expire_at`; its unsaved files are discarded.
- Paths under `_email/` return `422 EMAIL_PATH_READ_ONLY`.

### File fields

| Field | Meaning |
| --- | --- |
| `id`, `mailbox_id`, `path`, `basename` | Identity and location. |
| `current_file_version` | Current version: `id`, `version_number`, `mime_type`, `byte_size`, `sha256`, `reason`, `created_at` and actors. |
| `read`, `read_at`, `read_by`, `read_by_api_key` | First read of the current version. |
| `lock` | Lock state of the file. |
| `deleted` | `true` when the current version records a deletion. |

## Custom email domains

Use a domain you own for mailbox addresses. These operations need a full-account
owner or administrator key.

| Method | Path | Purpose |
| --- | --- | --- |
| GET | `/v1/account/email_domains` | `data.domains`, `data.enabled`, `data.pagination`. |
| POST | `/v1/account/email_domains/check` | Check a `hostname` for conflicting DNS. Makes no change. |
| POST | `/v1/account/email_domains` | Connect `hostname`. Returns `data.domain` with DNS records. |
| GET | `/v1/account/email_domains/{domain_id}` | `data.domain`. |
| POST | `/v1/account/email_domains/{domain_id}/verify` | Check DNS again. |
| DELETE | `/v1/account/email_domains/{domain_id}` | Remove an unused domain; send `hostname` and `confirm: true`. |

1. Check the hostname. If the root domain already receives email, use a subdomain such as `inbox.example.com`.
2. Connect it and publish the returned `required_dns_records`.
3. Verify, then read the domain until `receiving` is `true`.
4. Create mailboxes with `mailbox.email.domain`.

See [Custom email domains](https://github.com/revdoku/revdoku/blob/main/guides/custom-email-domains.md).

## Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `401` | `UNAUTHORIZED` | Missing, invalid or expired API key. |
| `403` | `FORBIDDEN`, `MAILBOX_PERMISSION_DENIED`, `MAILBOX_ACCESS_DENIED` | The key cannot do this. |
| `404` | `NOT_FOUND`, `MAILBOX_NOT_FOUND`, `MAILBOX_FILE_NOT_FOUND` | Unknown route or resource, or not visible to this key. |
| `409` | `MAILBOX_METADATA_CONFLICT`, `MAILBOX_VERSION_CONFLICT`, `EMAIL_ADDRESS_CHANGED` | A concurrent change; read again. |
| `403` | `MAILBOX_ARCHIVED` | The mailbox is archived and read-only; unarchive it first. |
| `403` | `EMAIL_SENDING_UNAVAILABLE` | This mailbox cannot send now; see `email.sending_blocked_reason`. |
| `409` | `MAILBOX_ALREADY_ARCHIVED`, `MAILBOX_NOT_ARCHIVED` | Wrong archive state. |
| `409` | `DATABASE_BUSY_RETRY` | Related changes are still saving; retry after `Retry-After`. |
| `422` | `INVALID_ARGUMENT` | Invalid input; see `error.message`. |
| `422` | `EMAIL_PATH_READ_ONLY` | A file operation touched `_email/`. |
| `422` | `MAILBOX_DELETE_CONFIRMATION_REQUIRED` | Send `delete.confirmation`. |
| `423` | `MAILBOX_LOCKED`, `FILE_LOCKED` | Another operation holds a lock. |
| `429` | `RATE_LIMIT_EXCEEDED`, `UPLOAD_RATE_LIMIT_EXCEEDED` | Wait for `Retry-After`. |
| `429` | `MAILBOX_CREATION_LIMIT_REACHED` | Monthly creations used; see `error.details.resets_at`. |
| `503` | `EMAIL_INDEX_BUILDING`, `EMAIL_NOT_READY` | Temporary; follow `Retry-After` or the message. |

Use bounded exponential backoff with jitter for `429`, `503` and
`DATABASE_BUSY_RETRY`. Never retry a mailbox creation or an email send after an
unknown result. A quota error is not a short throttle: do not retry it automatically.

When an account is read-only, reads work and writes return the account-state error.
`GET /v1/status` explains the restriction in `account.restriction`.

## HIPAA and high-security accounts

These account modes differ as follows.

| Area | Behavior |
| --- | --- |
| Account setup | Selected when the account is created. Existing accounts cannot convert. |
| Sensitive data | Files and sensitive metadata use additional per-account encryption. |
| Search | Content indexing is off. Email filters `sender`, `subject` and `conversation_id` return `403 CONTENT_SEARCH_DISABLED`. |
| Sending email | Unavailable. `sending_blocked_reason` is `protected_account`. |
| Download links | Signed API URLs that check access and decrypt the file. Fetch them without an API key. |
| Email download size | Decrypted email downloads are limited to 41 MiB. |
