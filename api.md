# Revdoku API

Revdoku provides **email mailboxes for humans and AI agents**, with private file
storage in each mailbox. The REST API creates mailboxes, lists and reads messages,
and downloads attachments. Mailboxes also support uploaded files and version history.

## Find what you need

| Task | Section |
| --- | --- |
| Make your first API request | [Quick start](#email-api-quick-start) |
| Receive your first useful email | [First email workflow](https://revdoku.com/docs.md#first-email-workflow) |
| Choose an SDK, n8n or Zapier | [Package directory and capability comparison](https://github.com/revdoku/revdoku/blob/main/guides/api-packages.md) |
| Build customer mailboxes in your application | [SaaS mailbox guide](https://github.com/revdoku/revdoku/blob/main/guides/saas-mailboxes.md) |
| Understand JSON and errors | [Response format](#response-format) |
| Select an account | [Accounts](#accounts) |
| Check quotas | [Account limits](#account-limits) |
| Read email and attachments | [Received email operations](#received-email-operations) |
| Webhooks and local live events | [Email events](#email-webhooks-and-live-subscriptions) |
| Choose an email username | [Create a mailbox](#create-a-mailbox) |
| Use extra addresses or your own domain | [Aliases](#mailbox-aliases) · [Custom domains](#custom-email-domains) |
| Upload a file | [Upload a file](#upload-a-file) |
| Create a new owner's account through the API | [Direct API signup](#direct-api-signup) |

## Email API quick start

For Node.js, start with the [npm SDK](https://github.com/revdoku/revdoku-typescript).

1. Sign in to your existing account and create a backend key from **Connect via API**
   or **Account → Access**. If you need an account, [browser signup](https://app.revdoku.com/users/sign_up)
   creates your first mailbox; [direct signup](#direct-api-signup) is also available.
2. Keep the key on your backend. Replace `YOUR_API_KEY` below in your private application.
3. List the existing mailboxes and choose an authorized mailbox. A read-only key can
   complete this read workflow; creating another mailbox requires account-wide admin access.

```http
GET /v1/mailboxes
Authorization: Bearer YOUR_API_KEY
```

The response contains `data.mailboxes`. Keep one mailbox `id` for the requests below.
Requests use the key’s default account. See [Accounts](#accounts) to select another.

| Setting | Value |
| --- | --- |
| Base URL | `https://api.revdoku.com/v1` |
| Authentication | `Authorization: Bearer YOUR_API_KEY` |
| JSON requests | `Content-Type: application/json` |
| Account | Credential default; pass `account_id` to select another granted account. |

### Receive your first message

1. Open the chosen mailbox in the [dashboard](https://app.revdoku.com/mailboxes).
2. When receiving is ready, select its address or **Compose test email** to open a draft in your email app.
3. Send the message to the complete address shown.
4. For future messages, use the address for receipts, newsletters, or app notifications.
   You can also [set up Gmail forwarding](https://revdoku.com/blog/how-to-set-up-auto-forwarding-from-gmail-to-revdoku-s-email/).
5. Retrieve a fresh message with the requests below.

Address discovery through `GET /v1/mailboxes/:mailbox_id/email` requires write access.
Read-only clients can use an address from the dashboard or mailbox owner.
See the [first email workflow](https://revdoku.com/docs.md#first-email-workflow) for example tasks and forwarding verification.

<a id="2-list-messages"></a>

### List messages

Replace `bkt_example` with the chosen mailbox ID:

```http
GET /v1/mailboxes/bkt_example/emails?limit=50
Authorization: Bearer YOUR_API_KEY
```

200 OK

```json
{
  "success": true,
  "data": {
    "emails": [],
    "pagination": {
      "limit": 50,
      "has_more": false,
      "next_cursor": "OPAQUE_CURSOR"
    }
  }
}
```

<a id="3-read-messages-and-attachments"></a>

### Read messages and attachments

| Task | Request |
| --- | --- |
| Read a returned message | `GET /v1/mailboxes/:mailbox_id/emails/:email_id` |
| Get a temporary attachment link | `GET /v1/mailboxes/:mailbox_id/emails/:email_id/attachments/:attachment_id` |

See [received email operations](#received-email-operations),
[OpenAPI](https://revdoku.com/openapi.json),
[runnable JS/TypeScript examples](https://github.com/revdoku/revdoku/tree/main/examples), and the
[SaaS mailbox guide](https://github.com/revdoku/revdoku/blob/main/guides/saas-mailboxes.md).

## Direct API signup

Create an account, its first mailbox, and an API key. No existing API key is required.
The starter mailbox address is generated from your email. To choose a custom
username later, sign in and [create another mailbox](#create-another-mailbox).

By signing up, you agree to the [Terms of Use](https://revdoku.com/terms) and
[Acceptable Use Policy](https://revdoku.com/acceptable-use) and acknowledge the
[Privacy Policy](https://revdoku.com/privacy).

1. Request a verification code:

   ```http
   POST /v1/agent/signups
   Content-Type: application/json

   { "email": "person@example.com", "accept_terms_and_policy": true }
   ```

   | Field | Required | Meaning |
   | --- | --- | --- |
   | `email` | Yes | Your account email address. |
   | `accept_terms_and_policy` | Yes | Must be boolean `true`. |

   The `202 Accepted` response contains `data.signup.signup_token` plus
   `data.signup.expires_in` and `data.signup.resend_after` in seconds. Keep the
   token for the next request.

2. Verify the emailed code:

   ```http
   POST /v1/agent/signups/verify
   Content-Type: application/json

   { "signup_token": "TOKEN_FROM_STEP_1", "code": "123456" }
   ```

   `201 Created` returns:

   | Field | Meaning |
   | --- | --- |
   | `data.api_key` | Your API key; save it securely. Returned only once. |
   | `data.account.id` | New account ID. |
   | `data.mailbox.id` | Starter mailbox ID. |
   | `data.mailbox.email` | Generated address and receiving state. |
   | `data.scope` | `mailbox_admin`, covering this account's mailboxes. |
   | `data.expires_at` | API key expiration time. |

To resend, POST `{ "signup_token": "TOKEN_FROM_STEP_1" }` to
`/v1/agent/signups/resend` after `resend_after` seconds. Resending replaces the
code without extending the signup expiry. On `429`, honor `Retry-After`.

| Result | Action |
| --- | --- |
| `INVALID_CODE` | Check the emailed code. |
| `INVALID_SIGNUP_TOKEN` | Start again; the signup token is invalid or expired. |
| `SIGN_IN_REQUIRED` | The account exists; [sign in](https://app.revdoku.com/users/sign_in). |
| Verification response lost | Sign in and create a key in Account → Access. Repeating verification does not return the key again. |
| Receiving is temporarily unavailable | Keep the returned key and mailbox ID; check the mailbox's receiving state later. |

<a id="1-create-an-mailbox"></a>
<a id="create-a-mailbox"></a>

## Create another mailbox

Use this only when you need another mailbox. Browser and direct signup already
create a first mailbox.

```http
POST /v1/mailboxes
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "mailbox": {
    "email": {
      "username": "acme-orders",
      "domain": "revdokumail.com"
    }
  }
}
```

201 Created (selected fields)

```json
{
  "success": true,
  "data": {
    "mailbox": {
      "id": "bkt_example",
      "email": {
        "username": "acme.orders.k7m2x9q4v8nc",
        "address": "acme.orders.k7m2x9q4v8nc@revdokumail.com",
        "receiving_enabled": true,
        "sending_enabled": false
      }
    }
  }
}
```

Both `username` and `domain` are optional. Omit them to generate an address on the
platform domain. A custom domain must be verified, owned by this account, and
available on its plan. Always use the returned address.

After a lost response, check existing mailboxes before creating another.

#### Creation fields

| Field | Default | Purpose |
| --- | --- | --- |
| `mailbox.email.username` | Generated name, such as `flaky.forest.k7m2x9q4v8nc` | Free: choose a prefix; the server adds a permanent 12-character random suffix. Paid: choose the exact name before `@`. |
| `mailbox.email.domain` | Platform domain | Built-in domain such as `revdokumail.com` (all plans), or a ready custom email domain owned by this account. |
| `mailbox.description` | Empty | Add a mailbox description. |
| `mailbox.tag_paths` | None | Apply user-chosen organizational labels. |
| `mailbox.metadata` | Empty object | Store your application's project/task metadata. |
| `account_id` | Credential default | Select another granted account. |

#### Username rules

| Rule | Behavior |
| --- | --- |
| Characters | ASCII letters, digits, dots, hyphens and underscores. Uppercase is normalized to lowercase. |
| Omitted username | Generate a name. |
| Free username | Convert separators to dots and append 12 random lowercase letters/digits. `acme-orders` becomes `acme.orders.k7m2x9q4v8nc@revdokumail.com`, for example. Long prefixes are shortened to 51 characters. Always use the returned address. |
| Free address changes or aliases | Require an upgrade. Existing addresses remain unchanged when plans change. |
| Empty or `null` username | `422 EMAIL_NAME_INVALID`. |
| Reserved platform name, such as `support`, `acme-support`, `abuse`, `sale`, `sales` or `contact` | `422 EMAIL_NAME_RESERVED`. The message identifies the reserved word and explains how to use your own verified custom domain. Free receives an upgrade link; paid accounts receive domain settings. A paid plan does not bypass shared-domain restrictions. |
| Occupied or retired platform address | `409 EMAIL_ALREADY_EXISTS`. Deletion and rotation do not release platform names. |

#### Creation result

- Success means the receiving address has been confirmed; no readiness polling is required.
- If confirmation cannot finish within 25 seconds, the API returns `503 EMAIL_NOT_READY` with the created `mailbox_id` in `error.details`. Check that mailbox before creating another.
- The same error reports receiving holds through `error.details.blocked_reason`.
- `dashboard_url` opens the mailbox for authorized human users; it does not grant access.

## Response format

| Field | Success | Failure |
| --- | --- | --- |
| `success` | `true` | `false` |
| `data` | Named resources such as `mailbox` or `mailboxes`. | Omitted. |
| `error` | Omitted. | Error code, message and optional details. |

Failure — HTTP `401 Unauthorized` (core error fields):

```json
{
  "success": false,
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Authentication required",
    "request_id": "req_example"
  }
}
```

### Error fields

| Field | Required | Purpose |
| --- | --- | --- |
| `error.code` | Yes | Stable identifier for error handling, such as `UNAUTHORIZED`. |
| `error.message` | Yes | Readable explanation of what went wrong. |
| `error.request_id` | When available | Identifier to include when contacting support. |
| `error.details` | No | Error-specific information, or a list of validation errors with `field` and `message`. |
| `error.docs_url` | No | Documentation relevant to the error. |

File downloads return bytes; `204 No Content` has no body.

## Authentication

Send your API key as `Authorization: Bearer YOUR_API_KEY`. Keep it on your backend.

| Permission | Access |
| --- | --- |
| `mailbox_read` | Read permitted email and files. |
| `mailbox_write` | Read and write permitted files. |
| `mailbox_admin` | Manage permitted mailboxes; account-wide access is required to create one. |

For browser authorization and existing-account sign-in flows, see
[Authentication](https://github.com/revdoku/revdoku/blob/main/guides/authentication.md). For AI connectors, see the [MCP guide](https://revdoku.com/mcp.md).

## Accounts

An API key can access one or more accounts. Each request operates on one selected account.

### Endpoints

| Method | Path | Purpose | Response |
| --- | --- | --- | --- |
| GET | `/v1/accounts` | List accounts granted to this credential. | `data.accounts`, `data.default_account_id`, `data.pagination` |
| GET | `/v1/accounts/:id` | Read one granted account. | `data.account` |

### Account fields

| Field | Meaning |
| --- | --- |
| `id` | Account identifier to use in requests. |
| `name` | Account display name. |
| `account_kind` | `standard`, `agency`, or `client`. |
| `region` | Account data region. |
| `status` | Account state, such as `active` or `read_only`. |
| `permissions` | Operations this credential is allowed to perform. |
| `client_name` | Optional client name for a project/client account. |
| `agency_account` | Parent account identity, when this credential can access it. |

### Selecting an account

| Input | Where to send it | Behavior |
| --- | --- | --- |
| `account_id` | GET query parameter or JSON write body | Selects a granted account for this request. |
| Omitted `account_id` | — | Uses the credential's default account. |
| Conflicting account selectors | — | Returns `ACCOUNT_SELECTOR_CONFLICT`. |

- Repeat the selector on each request. It does not change the default account.
- Knowing an account ID does not grant access.
- See [client accounts](#clientproject-accounts) for DEV PRO account creation and permissions.

### Account list pagination

| Response field | Meaning |
| --- | --- |
| `default_account_id` | Account used when no selector is supplied. |
| `pagination.limit` | Maximum accounts returned per page. |
| `pagination.offset` | Starting position of this page. |
| `pagination.has_more` | Whether another page exists. |
| `pagination.next_offset` | Offset to pass for the next page, or `null`. |

## Account limits

Read quotas when choosing a plan or handling a quota error. They are not included
in ordinary mailbox responses.

```http
GET /v1/account/limits
Authorization: Bearer YOUR_API_KEY
```

200 OK (selected fields)

```json
{
  "success": true,
  "data": {
    "account_id": "acct_example",
    "limits": {
      "max_mailboxes": 3,
      "max_file_size_bytes": 10485760,
      "max_received_emails_per_month": 3000
    }
  }
}
```

| Field in `limits` | What it limits |
| --- | --- |
| `max_mailboxes` | Active mailboxes in the billing group. Archived content still consumes storage. |
| `max_mailbox_creations_per_month` | New mailboxes per UTC calendar month. Deleting a mailbox does not refund a creation. |
| `max_files_per_mailbox` | Current files in one mailbox. |
| `max_current_files` | Current files across the billing group. |
| `max_storage_bytes` | Total stored bytes. |
| `max_file_size_bytes` | Bytes in one uploaded file. |
| `max_pdf_size_bytes` | Bytes in one uploaded PDF, which may have a different limit. |
| `max_file_versions_per_file` | Retained versions of each file. |
| `max_email_domains` | Custom email domains in this account. |
| `max_received_emails_per_month` | Incoming messages per billing period. |
| `max_received_email_bytes_per_month` | Incoming raw-message bytes per billing period, including MIME encoding. |
| `max_received_email_message_bytes` | Bytes in one incoming message. |
| `max_email_aliases_per_mailbox` | Active aliases per mailbox. |
| `max_email_address_rotations_per_month` | Address replacements per UTC calendar month. |
| `max_account_members` | Human members. |
| `max_api_keys` | Normal API keys. |
| `max_agent_connections` | AI agent connections. |
| `api_rate_limit_requests_per_minute` | API requests per minute. |
| `audit_retention_days` | Activity log retention in days. |

Values come from the current plan and account overrides; use the returned values.
Zero means no allowance; `null` means no cap for that field. Storage, mailbox and
incoming-traffic allowances are shared within a billing group. Domain slots are
per account. Received email files also consume storage/file allowances.

### Creation usage

`data.usage.mailbox_creations` is returned to administrators with unrestricted
account-wide access. It is separate from `data.limits`.

| Field in `usage.mailbox_creations` | Meaning |
| --- | --- |
| `monthly_limit` | Shared billing-group allowance for this UTC calendar month. |
| `used` | Committed creations this month. |
| `remaining` | Creations left; deleting or archiving a mailbox does not refund usage. |
| `resets_at` | ISO 8601 UTC reset time. |

This read is optional. Handle `MAILBOX_CREATION_LIMIT_REACHED` on creation because
concurrent requests can spend capacity after a usage check. Deletion does not
refund creations.

## Storing files inside a mailbox

A mailbox can also store uploaded files. Received emails and their attachments are
stored as files inside its `_email/` folder.

| Task | Endpoint | Purpose |
| --- | --- | --- |
| Upload a file | [Direct upload workflow](#upload-a-file) | Store documents, data, code or binary files. |
| Read by path | `GET /v1/mailboxes/:id/files/by_path` | Read a file without looking up its ID first. |
| Append text | `POST /v1/mailboxes/:id/files/append_text` | Append UTF-8 text to a file. |
| List versions | `GET /v1/mailboxes/:id/versions` | Inspect retained mailbox history. |
| Restore a version | `POST /v1/mailboxes/:id/versions/restore` | Create a new latest version from a retained snapshot. |

- Files retain their paths and formats. Storage and version limits apply.
- For concurrent edits, supply `expected_mailbox_revision_id`; reread and reconcile if the version has changed.
- Text append does not parse or merge CSV/JSON for you.
- Share `dashboard_url` with authorized members. The link itself does not grant access.
- Mailbox readers can read both uploaded files and stored emails.

## Received email operations

Listing, reading, status updates and downloads require mailbox **read** access and share the same permissions
as stored files. Messages have stable `eml_` IDs; attachments have `df_` IDs.
Renames retain message IDs, while copies receive new IDs. Use the email endpoints below for normal mail workflows. You do not need to parse the underlying files.

| Method | Path | Result |
| --- | --- | --- |
| GET | `/v1/mailboxes/:mailbox_id/emails` | `data.emails` and `data.pagination` |
| GET | `/v1/mailboxes/:mailbox_id/emails/:email_id` | `data.email`, including `body_text`, `body_status`, `attachments` |
| PATCH | `/v1/mailboxes/:mailbox_id/emails/:email_id` | Accepts `{"read":true}` or `{"read":false}`; returns `data.email` |
| DELETE | `/v1/mailboxes/:mailbox_id/emails/:email_id` | Requires mailbox **admin** access. Deletes this email and its owned files/attachments; returns 204. |
| GET | `/v1/mailboxes/:mailbox_id/emails/:email_id/raw` | `data.download` for the original EML |
| GET | `/v1/mailboxes/:mailbox_id/emails/:email_id/attachments/:attachment_id` | `data.download` for a saved attachment belonging to this email |

### List query parameters

| Parameter | Default | Purpose |
| --- | --- | --- |
| `limit` | `50` | Page size; maximum `100`. |
| `cursor` | Omitted | Continue from a returned `pagination.next_cursor`. |
| `order` | `asc` | Arrival order. Use `asc` for polling or `desc` to browse recent history. |
| `sender` | Omitted | Exact sender address; case insensitive. |
| `subject` | Omitted | Subject substring; case insensitive. |
| `received_after` | Omitted | Exclusive lower bound, as an ISO 8601 timestamp. |
| `received_before` | Omitted | Exclusive upper bound, as an ISO 8601 timestamp. |
| `read` | Omitted | Filter by read/unread status. |
| `has_attachments` | Omitted | Filter messages with or without saved attachments. |
| `conversation_id` | Omitted | An email ID identifying a conversation; replies are linked by email headers. |
| `include_storage` | `false` | Include backing file IDs and storage mappings for file-browser integrations. |

### Email response fields

| Field | Available in | Meaning |
| --- | --- | --- |
| `id` | List and detail | Stable `eml_` message ID. |
| `conversation_id` | List and detail | Identifier used to retrieve related messages. |
| `subject` | List and detail | Decoded subject. |
| `from` | List and detail | Sender address from the message headers. |
| `to` | List and detail | Recipient addresses from the message headers; may differ from the delivery address for forwarded or BCC mail. |
| `received_at` | List and detail | Receipt timestamp. |
| `attachment_count` | List and detail | Number of saved attachments. |
| `omitted_attachment_count` | List and detail, when present | Attachments omitted during decoding/storage. Historical messages may lack this field; absence does not establish that every original attachment was saved. |
| `read` | List and detail | Shared read/unread state. |
| `read_at` | List and detail | Time the message was marked read. |
| `read_by` | List and detail | Person who marked it read, when known. |
| `read_by_api_key` | List and detail | API connection that marked it read, when applicable. |
| `forwarding` | List and detail | Present for recognized forwards from authenticated human members with mailbox access. Records the forwarding member, method and original date; original authorship is member-reported. |
| `forwarding.note_text`, `forwarding.note_status` | Detail | Member’s separate note and its completeness; absent from lists. |
| `attachments[].origin` | Detail | For member forwards: `original`, `forwarder`, `forwarded_message` (source EML), or `unspecified` for inline-forward attachments. |
| `body_text` | Detail | Decoded message text, or `null` if unavailable. |
| `body_status` | Detail | `complete`, `empty`, `truncated`, or `unavailable`. |
| `attachments` | Detail | Saved attachment metadata; see below. |
| `file_id` | With `include_storage=true` | Original message's stored file ID. |
| `version_id` | With `include_storage=true` | Stored file version used for this message. |
| `files` | With `include_storage=true` | Related stored files. |

### Poll for new messages

1. List messages in ascending order.
2. Process each page, then save its `pagination.next_cursor`.
3. Continue immediately while `pagination.has_more` is true.
4. Otherwise, wait before requesting the saved cursor again. Save the cursor even for an empty page.

```http
GET /v1/mailboxes/bkt_example/emails?cursor=OPAQUE_CURSOR&limit=50
Authorization: Bearer YOUR_API_KEY
```

Replace `OPAQUE_CURSOR` with the previous response's `pagination.next_cursor`.
Treat it as an opaque string: URL-encode it; do not construct or decode it.

- Keep the account, mailbox, order and filters unchanged when reusing a cursor.
- Delayed deliveries are returned in committed arrival order, even with an older receipt timestamp.
- Cursors track arrivals. Read-status changes and edits do not replay a message.
- Use the email ID to prevent duplicate downstream processing after retries.

### Read status

| Operation | Effect on shared read status |
| --- | --- |
| List or read a message | No change. |
| Download an original or attachment | No change. |
| PATCH with `{"read": true}` | Mark read. |
| PATCH with `{"read": false}` | Mark unread. |

Authorized readers can change read status on locked/read-only content. The status
and audit entry change together, without creating a content version.

### Attachments and download links

| Attachment field | Meaning |
| --- | --- |
| `id` | Attachment ID for requesting its download link. |
| `filename` | Saved filename. |
| `content_type` | MIME type. |
| `size_bytes` | File size. |

Request the link for the selected attachment or original EML using the endpoints above.

| `data.download` field | Meaning |
| --- | --- |
| `url` | Temporary URL to fetch. |
| `filename` | Suggested download filename. |
| `content_type` | MIME type. |
| `size_bytes` | File size. |
| `authentication` | `none`: do not send the API key to this URL. |
| `expires_in` | `900` seconds (15 minutes). Request a fresh link after expiry. |

- Fetch the returned URL as provided; no API key is needed.
- Bodies and attachments remain stored files; the original EML is available if decoded text is incomplete.
- Store attachment IDs and request links on demand. A previously issued standard
  storage link can remain usable until expiry after the issuing credential is revoked.

### Delete a message

| Request | Effect |
| --- | --- |
| `DELETE /v1/mailboxes/:mailbox_id/emails/:email_id` | Deletes the email and its owned message files and attachments together. Requires mailbox-admin permission. |
| `DELETE /v1/mailboxes/:mailbox_id/files/:file_id` | Deletes an individual stored file. |

Successful deletion returns `204 No Content`. Repeating it returns `404`.
Separately copied files remain independent.

### Email errors

| HTTP status | Code or condition | Next step |
| --- | --- | --- |
| 401 | Unauthenticated | Supply a valid credential. |
| 403 | Access denied | Check the credential's mailbox permissions. |
| 403 | `CONTENT_SEARCH_DISABLED` | Content search is unavailable for this account; remove the search filters. |
| 404 | Email or attachment absent | Check the mailbox and resource IDs. |
| 409 | `EMAIL_CHANGED` | Read the current email state before retrying. |
| 422 | `INVALID_EMAIL_ARGUMENT`, `INVALID_EMAIL_CURSOR` | Correct the arguments or start with a fresh cursor. |
| 429 | Rate limit | Wait as directed by `Retry-After`. |
| 503 | `EMAIL_INDEX_BUILDING` | The initial index is being prepared. Retry after the returned five-second delay. |
| 503 | `EMAIL_READ_STATUS_UNAVAILABLE` | The read-status change was not saved. Retry later. |

## Email webhooks and live subscriptions

Use signed HTTPS webhooks for hosted applications or a WebSocket subscription for
local applications. Both notify you after an email and its attachments are saved.
Fetch the message through the email API.

| Method | Path | Result |
| --- | --- | --- |
| GET / PUT / DELETE | `/v1/mailboxes/:mailbox_id/email/webhook` | Read, configure, or remove one webhook. Requires mailbox admin. |
| GET | `/v1/mailboxes/:mailbox_id/email/subscription` | Get a temporary WebSocket ticket. Requires mailbox read. |

Verify webhook signatures and deduplicate event IDs. Use a saved arrival cursor
to catch up after disconnects. See [Email events](https://github.com/revdoku/revdoku/blob/main/guides/email-events.md)
for setup, payloads, signatures, delivery rules, and runnable examples.

<a id="incoming-email-into-a-mailbox"></a>

## Mailbox receiving settings

Read receiving settings with `GET /v1/mailboxes/:id/email`, or request
`include_email=true` on mailbox detail. Detailed settings require write access.
Use the [email endpoints](#received-email-operations) to list and read messages.

### Receiving state

`POST /v1/mailboxes` waits for receiving confirmation before returning success.
Inspect an existing mailbox with `GET /v1/mailboxes/:id/email`.

| Field | Meaning |
| --- | --- |
| `address` | Full email address; use it exactly as returned. |
| `username` | The part before `@`. |
| `aliases` | Extra receiving addresses: each has `id`, `address` and `active`. Inactive records are preserved after a limit reduction. |
| `receiving_enabled` | Whether this mailbox can currently receive email. |
| `sending_enabled` | Always `false`; sending is not implemented. |
| `blocked_reason` | Why receiving is unavailable. Omitted when receiving is enabled. |

A mailbox may stop receiving if its quota is exhausted or receiving is paused.
Saved messages remain readable. Limits are available separately at
[`GET /v1/account/limits`](#account-limits).

An owner/administrator manages per-mailbox Pause/Resume in the browser, including
cooldown and other holds. Those controls and detailed diagnostic logs are not
API/MCP operations. Follow the [receiving runbook](https://github.com/revdoku/revdoku/blob/main/guides/saas-mailboxes.md#when-receiving-stops)
for an incident handoff. Mail rejected while paused must be resent.

### Activity fields

These fields are also available on ordinary mailbox reads.

| Field | Meaning |
| --- | --- |
| `received_count` | Total saved messages; not an unread count or polling cursor. |
| `last_received_at` | Most recent saved-message receipt timestamp; `null` before the first message. |
| `last_received_path` | Latest message folder, ending in `/`; `null` before the first message. It can become stale if files are moved or deleted. |

Copies start with zero activity. Moves, rotation, deletion and disabling receiving
do not reset the source mailbox's activity.

### Replace an email address

Read the current mailbox settings before requesting a replacement.

| JSON field | Required | Purpose |
| --- | --- | --- |
| `confirm` | Yes; `true` | Confirm changing the current address. |
| `current_address` | Yes | Address returned by the latest mailbox settings request. |
| `domain` | No | Keep the current domain, select an available platform or ready custom domain, or use `platform`. |
| `username` | No | Choose a name on the selected domain; requires a paid plan and full-account administrator access. Omit for a generated name. |
| `keep_old_as_alias` | No; default `false` | Retain the old primary for the same mailbox; requires full-account administrator access and an available alias slot. |

- Check `max_email_address_rotations_per_month` in [account limits](#account-limits). Initial mailbox creation does not use it.
- After a lost response, reread the address before requesting another change.
- Update third-party account/recovery settings before retiring an address.
- Old addresses stop receiving unless retained as aliases. Platform names remain permanently reserved.

| Status | Error code | Meaning |
| --- | --- | --- |
| 403 | `EMAIL_NAMES_UPGRADE_REQUIRED` | Upgrade to change the assigned address or add aliases. `error.details.upgrade_url` links to Pricing. |
| 409 | `EMAIL_ADDRESS_CHANGED` | The supplied current address is stale. |
| 409 | `EMAIL_ROTATION_UNAVAILABLE` | This mailbox cannot rotate its address. |
| 409 | `EMAIL_ALIAS_LIMIT` | No alias slot is available. The existing address remains unchanged. |
| 429 | `EMAIL_ROTATION_LIMIT` | The shared rotation allowance is exhausted or unavailable. |

### Mailbox aliases

Aliases are extra addresses created directly or retained during an address change. They deliver
to the same mailbox and share its sender restrictions, quotas, pause state and message
history. Read the effective `max_email_aliases_per_mailbox` from account limits;
a zero allowance means aliases are unavailable.

1. Read the current mailbox settings and account limits.
2. Submit `POST /v1/mailboxes/:id/email/aliases` with `username` and optionally `domain`.
3. Poll mailbox settings until `receiving_enabled` is true. The new address appears
   in `aliases`; the primary stays unchanged and no rotation allowance is spent.

| Parameter | Required | Meaning |
| --- | --- | --- |
| `username` | Yes | Local part of the new address. Platform reserved names are unavailable. |
| `domain` | No | Available platform domain or ready domain owned by the account; defaults to the platform domain. |

To keep the old primary during a rename, submit the address change with
`keep_old_as_alias: true`. It uses alias capacity and charges a primary-address
rotation when the replacement activates.

| Endpoint | Access | Result |
| --- | --- | --- |
| `GET /v1/mailboxes/:id/email` | Mailbox write | Primary settings and `aliases`. |
| `POST /v1/mailboxes/:id/email/aliases` | Full-account owner/administrator with mailbox-admin access | `202` with updated mailbox settings; receiving registration continues in the background. |
| `DELETE /v1/mailboxes/:id/email/aliases/:alias_id` | Full-account owner/administrator with mailbox-admin access | Updated mailbox settings after removing one alias. |

Removing an alias stops new and queued deliveries to it. Existing messages remain.
A lower plan limit preserves alias records and enables only the oldest permitted
addresses; a zero allowance disables them. Copies have no aliases. Platform aliases
move with their mailbox; remove custom-domain aliases before moving accounts.
One message delivered to the primary and an alias is saved once, while both
provider receipts count toward incoming traffic.

### Account receiving control

Account administrators can use `PATCH /v1/account/profile` with a full-account
credential. Re-enabling receiving preserves addresses and files.

| JSON field | Purpose |
| --- | --- |
| `email_receiving_enabled` | Enable or disable account receiving. |
| `expected_account_id` | Confirm which account is being changed. |
| `confirm_email_receiving_disable` | Must be `true` when disabling. |
| `account_id` | Select another granted account, if needed. |

### Allowed senders

Account owners and administrators with mailbox-admin permission can read the policy
through `GET /v1/mailboxes/:id/email` and replace it with the request below.

```http
PATCH /v1/mailboxes/bkt_example/email/allowlist
Content-Type: application/json

{
  "sender_allowlist": {
    "enabled": true,
    "entries": ["sender@example.com", "vendor.example"]
  },
  "expected_version": "VERSION_FROM_GET"
}
```

| Field in `sender_allowlist` | Meaning |
| --- | --- |
| `enabled` | Whether the restriction is active; defaults to `false`. |
| `entries` | Up to 500 exact sender addresses or domains. No wildcards or implicit subdomains. |
| `version` | Current policy version; send it as `expected_version` when changing the policy. |
| `max_entries` | Maximum permitted entries. |
| `editable` | Whether this caller can change the policy. |

- Successful updates return `data.sender_allowlist`.
- An enabled list needs at least one entry. Disabling preserves the supplied entries.
- Restricted delivery requires authenticated sender evidence.
- The policy stays encrypted and is omitted from ordinary mailbox reads.

| Status | Error code | Meaning |
| --- | --- | --- |
| 409 | `EMAIL_ALLOWLIST_CHANGED` | Missing or stale policy version; read the latest policy. |
| 422 | `EMAIL_ALLOWLIST_INVALID` | Invalid policy entries or settings. |

<a id="custom-receiving-domains"></a>

### Custom email domains

Connect a domain in Account Settings → Domains → Email, or use these endpoints
with an account-wide administrator credential.

| Method | Path | Purpose |
| --- | --- | --- |
| GET / POST | `/v1/account/email_domains` | List domains or connect `hostname`. |
| POST | `/v1/account/email_domains/check` | Check a hostname for DNS conflicts. |
| GET | `/v1/account/email_domains/:id` | Read DNS requirements and receiving state. |
| POST | `/v1/account/email_domains/:id/verify` | Check ownership and provider setup. |
| DELETE | `/v1/account/email_domains/:id` | Remove an unused domain; send `hostname` and `confirm: true`. |

Select the verified domain with `mailbox.email.domain` when creating a mailbox.
See [Custom email domains](https://github.com/revdoku/revdoku/blob/main/guides/custom-email-domains.md)
for DNS setup, permissions, errors, and address migration.

## Account and request options

Use the base URL and headers from the [quick start](#email-api-quick-start).
The following options are only needed for their specific workflows.

### Client/project accounts

Client/project accounts keep each project's mailboxes and files separate. Each
request selects one granted account; see [Accounts](#accounts) for selection and
pagination. Check `GET /v1/me` for permission to create another account.

| Endpoint | Purpose | Access |
| --- | --- | --- |
| `GET /v1/status` | Current account and connection summary. | Authenticated connection, including mailbox-scoped keys. |
| `GET /v1/me` | Membership, owner and client-creation information. | Browser session or full-account API grant. |
| `POST /v1/accounts` | Create a client/project account. | Parent-account owner with client-account creation enabled. |
| `PATCH /v1/account/profile` | Update account display details. | Authorized browser session or full-account credential. |

```http
POST /v1/accounts
Content-Type: application/json

{
  "name": "Project files",
  "client_name": "Acme Studio",
  "account_id": "acct_agency"
}
```

| Creation field | Required | Purpose |
| --- | --- | --- |
| `name` | Yes | Display name of the new account. |
| `client_name` | No | Human-supplied client or business name; at most 100 characters. |
| `account_id` | If parent is not the default | Granted parent account that will own the new client account. |

| Result | Meaning |
| --- | --- |
| `data.account` | Created account identity; see [account fields](#account-fields). |
| `account_kind` | `client`. |
| Credential default | Unchanged. Select the returned account ID on later requests. |

| Profile update field | Purpose |
| --- | --- |
| `account_name` | Change the account display name. |
| `client_name` | Change the separate client name; `null` clears it. |

- Account names and membership alone do not grant a credential access to other accounts.
- Capacity and credits are shared; files and memberships stay separate.
- Browser account switching does not change an API or agent connection's selected account.
- When the parent entitlement expires, existing data remains and the group becomes read-only.

### Action reasons

| Parameter | Where | Meaning |
| --- | --- | --- |
| `reason` | Query parameter for reads; body field for writes | Optional purpose recorded in activity logs. Up to 2,000 characters; omit when unknown and exclude secrets. |

### Responses and account restrictions

See [Response format](#response-format) for the JSON envelope and error fields.

| Account state | Reads | Writes |
| --- | --- | --- |
| Active | Allowed within the credential's permissions. | Allowed within permissions and quotas. |
| Read-only | Existing files remain downloadable. | Return the account-state error. |


### Upload a File

Upload a file in three steps:

1. Ask Revdoku for an upload URL.
2. Send the file bytes to that URL with `PUT`.
3. Tell Revdoku to save the uploaded file in your mailbox.

For runnable code that calculates the checksums, see the
[JavaScript](https://github.com/revdoku/revdoku/blob/main/examples/javascript/upload-file.js),
[TypeScript](https://github.com/revdoku/revdoku/blob/main/examples/typescript/upload-file.ts), or
[Python](https://github.com/revdoku/revdoku/blob/main/examples/python/upload-file.py) example.

```http
POST /v1/direct_uploads
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "mailbox_id": "bkt_...",
  "path": "index.html",
  "blob": {
    "filename": "index.html",
    "byte_size": 1234,
    "checksum": "BASE64_MD5",
    "content_type": "text/html",
    "sha256": "HEX_SHA256",
    "purpose": "mailbox_file"
  }
}
```

| Request field | Purpose |
| --- | --- |
| `mailbox_id` | Destination mailbox ID. |
| `path` | Destination path inside the mailbox. |
| `blob.filename` | Original filename. |
| `blob.byte_size` | Number of bytes in the file. |
| `blob.checksum` | Base64-encoded MD5 checksum required by the storage upload. |
| `blob.content_type` | MIME type, such as `text/plain`. |
| `blob.sha256` | SHA-256 checksum as hexadecimal text, used to verify file integrity. |
| `blob.purpose` | Use `mailbox_file`. |

| Upload response field | Purpose |
| --- | --- |
| `data.signed_id` | Blob identifier to attach to the mailbox after uploading. |
| `data.direct_upload.url` | Object-storage URL for the `PUT` request. |
| `data.direct_upload.headers` | Exact headers to send with the uploaded bytes. |

Upload the bytes without a Revdoku authorization header, then attach the blob:

```http
POST /v1/mailboxes/bkt_.../files
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "path": "index.html",
  "signed_blob_id": "<data.signed_id from direct_uploads>"
}
```

Uploading the same `path` creates a new version of that file.

For folders and upload sessions, see [Bulk file uploads](https://github.com/revdoku/revdoku/blob/main/guides/bulk-uploads.md).

## API Reference

### Mailbox Endpoints

All files that make up a mailbox remain downloadable from
Revdoku at any time.

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/v1/mailboxes` | List active mailboxes by default. Use `?archived=true` to list archived mailboxes. |
| `POST` | `/v1/mailboxes` | Create a mailbox. |
| `GET` | `/v1/mailboxes/:id` | Read a mailbox. |
| `PATCH` | `/v1/mailboxes/:id` | Update mailbox metadata. |
| `POST` | `/v1/mailboxes/:id/archive` | Archive a mailbox. |
| `POST` | `/v1/mailboxes/:id/unarchive` | Restore an archived normal mailbox. |
| `GET` | `/v1/mailboxes/:id/variables` | Read public variables and secret names (never secret values). |
| `PATCH` | `/v1/mailboxes/:id/variables` | Replace variables and patch encrypted secrets. |
| `GET` | `/v1/mailboxes/:id/versions` | List mailbox version history. |
| `GET` | `/v1/mailboxes/:id/versions/:version_id` | Read one historical mailbox version. |
| `POST` | `/v1/mailboxes/:id/versions/restore` | Restore a historical version as a new latest version. |
| `DELETE` | `/v1/mailboxes/:id` | Permanently delete an archived mailbox with confirmation. |
| `GET` | `/v1/tags` | List reusable mailbox labels. |

#### GET /v1/mailboxes

```http
GET /v1/mailboxes
Authorization: Bearer YOUR_API_KEY
```

By default, this returns active mailboxes. To list archived mailboxes, call:

```http
GET /v1/mailboxes?archived=true
Authorization: Bearer YOUR_API_KEY
```

Mailbox list/detail responses include effective lifecycle action metadata:

| Field | Meaning |
| --- | --- |
| `archive.allowed` | Whether the current principal can archive now. |
| `unarchive.allowed` | Whether the current principal can restore an archived mailbox now. |
| `delete.allowed` | Whether the current principal can permanently delete now. |
| `delete.confirmation` | Confirmation phrase returned by the API; clients should pass it exactly to DELETE after human confirmation, not ask users to type mailbox ids. |

Archived mailboxes are read-only until unarchived. Metadata edits, label changes,
file changes, uploads and duplication return `MAILBOX_ARCHIVED`. Reads, unarchive,
and eligible permanent deletion remain available. Copying files out is allowed
with source read access and write access to an active target.

#### PATCH /v1/mailboxes/:id

```json
{
  "mailbox": {
    "description": "Updated purpose",
    "metadata": {
      "run": "revision-2"
    }
  }
}
```

#### Mailbox locks

Use file locks for narrow edits to specific paths. Mailbox-wide locks and mailbox
moves can reject incoming mail, including a queued message whose save rechecks the
lock. For broad uploads or reorganizations while an mailbox must keep receiving,
use a separate working mailbox. If you deliberately lock the mailbox, coordinate
the interruption and have senders resend rejected mail after receiving is ready.

```http
POST /v1/mailboxes/bkt_.../lock
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "message": "Uploading project folder",
  "duration_seconds": 900
}
```

```http
DELETE /v1/mailboxes/bkt_.../lock
Authorization: Bearer YOUR_API_KEY
```

Active mailbox locks block writes, deletes, direct uploads,
and file locks by other API keys. Revdoku checks the mailbox lock before checking
specific file locks. Conflicts return HTTP `423` with code `MAILBOX_LOCKED`.

To lock selected paths, use `POST /v1/mailboxes/:id/files/lock`.

| Request field | Purpose |
| --- | --- |
| `paths` | File paths to lock. |
| `message` | Explanation shown to other writers. |
| `duration_seconds` | Optional lock duration. |

Resolve a file's ID to unlock it with `DELETE /v1/mailboxes/:id/files/:file_id/lock`.

#### File path operations

Move and organize existing files server-side; do not download and re-upload bytes.

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/v1/mailboxes/:id/files` | List files; supports `limit`, `offset`, `q`, `folder`, for ordinary files. Default/maximum page size is 100. |
| `GET` | `/v1/mailboxes/:id/files/:file_id` | Read file metadata. |
| `GET` | `/v1/mailboxes/:id/files/by_path?path=...` | Read/download a file by mailbox-relative path. |
| `POST` | `/v1/mailboxes/:id/files/:file_id/rename` | Rename or move within the same mailbox without reuploading. |
| `POST` | `/v1/mailboxes/:id/files/:file_id/copy` | Copy by blob reference, optionally across mailboxes. |
| `POST` | `/v1/mailboxes/:id/files/:file_id/move` | Move by blob reference, optionally across mailboxes. |
| `POST` | `/v1/mailboxes/:id/files/reorganize` | Apply multiple rename/copy/move/delete path operations atomically. |
| `POST` | `/v1/mailboxes/:id/files/append_text` | Append bounded UTF-8 text to an existing text file. |

#### Download a file by path

| Query parameter | Required | Meaning |
| --- | --- | --- |
| `path` | Yes | Mailbox-relative file path, such as `reports/summary.txt`. |
| `content_url` | No | Set to `1` to receive JSON with a temporary download URL in `data.url`. Without it, the endpoint returns an HTTP 302 download redirect. |

```http
GET /v1/mailboxes/bkt_example/files/by_path?path=reports/summary.txt&content_url=1
```

Download from the returned URL without forwarding your Revdoku API key.
Use `GET /v1/mailboxes/:id/files/:file_id` when you only need file metadata.

#### Read metadata and file logs

File details expose the current version's read receipt. Metadata queries do not
mark a file read; content reads and explicit download requests do.

| Field | Meaning |
| --- | --- |
| `read` | Whether the version has been marked read. |
| `read_at` | First recorded read since the last reset. |
| `read_by` | Person responsible for that read, when available. |
| `read_by_api_key` | Credential responsible for that read, when available. |
| `previously_read` | State before this content read, when tracking succeeded. |
| `version_id` | Served version, included by MCP file reads. |

| Behavior | Details |
| --- | --- |
| Signed download URL | Records that access was granted; not proof that bytes were downloaded. |
| Background preview | Use `purpose=background` to avoid marking content read. |
| New file version | Starts unread. |
| Email body and original | Intentional reads share message status. Attachments have independent receipts. |
| Explicit message read/unread | Use [email status updates](#read-status). |
| Activity logs | Available to humans in the dashboard; not through API or MCP. |

Read receipts do not reserve a file or prove that an OTP was consumed. A later
Mark unread action resets the current message's receipt.

#### Mailbox version history

`GET /v1/mailboxes/:id/versions` lists immutable mailbox versions. Read one
with `GET /v1/mailboxes/:id/versions/:version_id`. Restoring does not delete
newer history; it creates a new latest version from the selected snapshot:

```json
{
  "version_id": "bktrv_...",
  "reason": "Restore the approved client version"
}
```

Send that body to `POST /v1/mailboxes/:id/versions/restore`.

#### Archive, unarchive, and permanent delete

Honor `archive` and `delete` eligibility in mailbox responses. If an operation
is blocked, direct the user to the mailbox dashboard to resolve it. Never delete
files to work around a blocked archive. Permanent deletion requires archiving first.

```http
POST /v1/mailboxes/bkt_.../archive
Authorization: Bearer YOUR_API_KEY
```

```http
POST /v1/mailboxes/bkt_.../unarchive
Authorization: Bearer YOUR_API_KEY
```

Permanent delete requires an archived mailbox plus the confirmation phrase
returned by `GET /v1/mailboxes` or `GET /v1/mailboxes/:id` in
`delete.confirmation`.

```http
DELETE /v1/mailboxes/bkt_...
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "confirmation": "<delete.confirmation from mailbox list/detail>"
}
```

UI and agent clients should ask users to confirm by mailbox email address or natural
language, then pass `delete.confirmation` internally.

Permanent deletion is **not** a bulk operation. Mailboxes must be
deleted one at a time via `DELETE /v1/mailboxes/:id` so each removal is
confirmed individually. The `POST /v1/mailboxes/bulk` endpoint accepts
only `archive` and `unarchive` operations and rejects `delete`.

Large mailbox deletion runs in the background.

| Response field | Meaning |
| --- | --- |
| HTTP `202` | Deletion was accepted. |
| `data.mailbox.deletion_started` | Deletion has started. |
| `data.delete_progress` | Current deletion progress. |
| `lock.kind` | `mailbox_delete` while deletion holds the mailbox lock. |
| `phase` | Current deletion phase. |
| `total_files` | Files involved. |
| `total_versions` | Versions involved. |
| `total_items` | Total items involved. |

Poll mailbox detail until it disappears or a notification reports completion.
A failed deletion releases the lock and sends a failure notification.

## Common Errors

When `account.restriction` reports a restriction, writes return the account-state
error; stored files remain downloadable.

### Rate Limits

Upload-control endpoints such as direct-upload creation and mailbox upload
sessions are account-throttled. On HTTP `429`, honor the `Retry-After` header
or `error.details.retry_after` before retrying. Clients should use bounded
exponential backoff with jitter and should not retry indefinitely.

Concurrent large uploads, finalization, deletes, and storage-counter refreshes
can also return HTTP `409` with `DATABASE_BUSY_RETRY`. Treat this as a
temporary contention signal: honor `Retry-After` or `error.details.retry_after`,
use bounded exponential backoff with jitter, and retry only operations that can safely be repeated, such as reads or the same upload-session step.
Do not automatically repeat mailbox creation after losing its response.

| HTTP | Code | Meaning |
| --- | --- | --- |
| `409` | `DATABASE_BUSY_RETRY` | Related mailbox changes are still committing; retry after the advertised delay. |
| `409` | `MAILBOX_FILE_PATH_INDEX_BACKFILL_PENDING` | Existing mailbox file path lookup keys are being prepared; retry after the advertised delay. |
| `429` | `RATE_LIMIT_EXCEEDED` | General account API rate limit exceeded. |
| `429` | `UPLOAD_RATE_LIMIT_EXCEEDED` | Upload-control API rate limit exceeded. |
| `429` | `MAILBOX_CREATION_LIMIT_REACHED` | Monthly creation capacity exhausted; stop and report `error.details.resets_at`. |

Monthly creations have a separate allowance from active mailboxes and address
rotations. Deleting or archiving a mailbox does not refund a creation.

Authorized callers can read [`data.usage.mailbox_creations`](#creation-usage) from
the dedicated account-limits endpoint. Full-account profiles retain
`plan_contract.mailbox_creation_usage` with the same calculation.

A quota error is not a short-lived throttle. Do not retry automatically until reset.

### Authentication Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `401` | `UNAUTHORIZED` | Missing, invalid, or expired API key. |
| `403` | `FORBIDDEN` | API key is valid but not allowed for this action. |

### Mailbox and File Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `404` | `MAILBOX_NOT_FOUND` | Mailbox does not exist or is not visible to this key. |
| `404` | `FILE_NOT_FOUND` | File does not exist or is not visible to this key. |
| `403` | `MAILBOX_DELETE_ADMIN_REQUIRED` | Only an account administrator can permanently delete this mailbox, except for empty cleanup mailboxes created by the same user. |
| `409` | `MAILBOX_ALREADY_ARCHIVED` | Mailbox is already archived. |
| `409` | `MAILBOX_NOT_ARCHIVED` | The operation requires an archived mailbox; archive before permanent delete, or only unarchive an archived mailbox. |
| `422` | `MAILBOX_DELETE_CONFIRMATION_REQUIRED` | Pass the `delete.confirmation` value returned by mailbox list/detail with the delete request. |
| `403` | `MAILBOX_ARCHIVED` | Mailbox is archived and cannot be edited until it is unarchived. |
| `404` | `MAILBOX_FILE_NOT_FOUND` | Mailbox file path does not exist. |
| `422` | `INVALID_MAILBOX_ARGUMENT` | Mailbox details accept no collection-expansion parameters. Request files or versions through their endpoints. |
| `422` | `UNSUPPORTED_TEXT_APPEND_TYPE` | `append_text` was used on a non-text file. |
| `422` | `INVALID_TEXT_ENCODING` | `append_text` content or the existing file is not valid UTF-8 text. |
| `423` | `MAILBOX_LOCKED` | Another key owns an active mailbox lock. |
| `423` | `FILE_LOCKED` | Another key owns an active file lock. |

## HIPAA and high-security accounts

These account modes have the following differences.

| Area | Behavior |
| --- | --- |
| Account setup | Selected when creating an account; existing accounts cannot be converted. |
| Sensitive data | Files and sensitive metadata use additional per-account encryption. |
| Search | Content indexing is disabled. Email filters `sender`, `subject` and `conversation_id` return `CONTENT_SEARCH_DISABLED`. |
| Reading email | Authorized listing, message reads and attachment downloads remain available. |
| Download links | Standard accounts use signed storage URLs. These modes use signed API URLs that check access and decrypt the file. Fetch either returned URL without an API key. |
| Email download bounds | Decrypted email/attachment downloads use `Cache-Control: no-store` and a 41 MiB bound including encryption overhead. |
