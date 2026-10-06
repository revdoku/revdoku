# Revdoku API

Revdoku provides **email mailboxes for humans and AI agents**, with private file
storage in each mailbox. The REST API creates mailboxes, lists and reads messages,
and downloads attachments. Mailboxes also support uploaded files and version history.

## Find what you need

| Task | Section |
| --- | --- |
| Make your first API request | [Quick start](#email-api-quick-start) |
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

The response contains `data.mailboxes`. Keep the chosen `id` for the requests below.
For multiple accounts, first [list granted accounts](#accounts), then pass
`account_id=acct_RETURNED_ID` on every GET and in each write body. Switching accounts
in the dashboard does not change your credential's default.

| Setting | Value |
| --- | --- |
| Base URL | `https://api.revdoku.com/v1` |
| Authentication | `Authorization: Bearer YOUR_API_KEY` |
| JSON requests | `Content-Type: application/json` |
| Account | Credential default; pass `account_id` to select another granted account. |

<a id="2-list-messages"></a>

### List messages

Replace `bkt_example` with the chosen mailbox ID. To send a test message, use the
address saved during provisioning or displayed to an authorized writer in the
dashboard; address discovery requires write access.
Save the returned cursor even when the list is empty:

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

<a id="1-create-an-mailbox"></a>

### Create another mailbox

Use this only when you need another mailbox. Browser and direct signup already
create a first mailbox.

```http
POST /v1/mailboxes
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{ "mailbox": {} }
```

201 Created (selected fields)

```json
{
  "success": true,
  "data": {
    "mailbox": {
      "id": "bkt_example",
      "email": {
        "username": "maple.river7k2xq9",
        "address": "maple.river7k2xq9@revdokumail.com",
        "receiving_enabled": true,
        "sending_enabled": false
      }
    }
  }
}
```

Creation waits for receiving setup. After `201 Created`, use the returned address immediately.
Keep the returned mailbox ID for later requests. Creation consumes a separate UTC
monthly allowance; deleting or archiving the mailbox does not refund it. Read
[creation usage](#account-limits) before a batch. On `EMAIL_NOT_READY`, preserve
the created mailbox ID. After a lost response, reconcile existing mailboxes; do not
automatically repeat the POST. See [creation results](#creation-result).

AI-agent users can start with the Revdoku app's copied prompt or the
Revdoku skill. Use the local CLI when the agent has shell and filesystem access,
or hosted MCP otherwise. Use this HTTP API for custom clients, CI jobs, backend workers,
or direct integrations.

Direct private clients can use [API signup](#direct-api-signup) when discovery
reports it available. CLI and hosted MCP users sign up at
<https://app.revdoku.com/users/sign_up> and connect with browser OAuth.

Hosted MCP and CLI device login use revocable agent connections. Reusable API
keys are for custom clients and automation when that capability is available to
the account.
Only a Revdoku account owner or administrator can authorize an AI connection.
Removing that membership or reducing it to collaborator access invalidates the
connection and its refresh credentials.

## Response format

| Field | Success | Failure |
| --- | --- | --- |
| `success` | `true` | `false` |
| `data` | Named resources such as `mailbox` or `mailboxes`. | Omitted. |
| `error` | Omitted. | Error code, message and optional details. |

Success — HTTP `201 Created` (selected mailbox fields):

```json
{
  "success": true,
  "data": {
    "mailbox": {
      "id": "bkt_example",
      "email": {
        "address": "assigned.address@revdokumail.com",
        "receiving_enabled": true,
        "sending_enabled": false
      }
    }
  }
}
```

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

### HTTP behavior

| Response | Body |
| --- | --- |
| Successful JSON request | `success: true` and `data`, containing named resources such as `mailbox` or `mailboxes`. |
| Failed request | `success: false` and `error`, with the appropriate HTTP error status. |
| `204 No Content` | No body. |
| File download | File bytes. |
| OAuth or MCP request | The response format defined by that protocol. |

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

### MCP and CLI

| Task | MCP | CLI |
| --- | --- | --- |
| List granted accounts | `account_list` | `revdoku accounts` |
| Read an account | `account_get(account_id: ID)` | `revdoku account get ID` |
| Select an account for an operation | `account_id: ID` | `--account-id ID` |

## Read one resource at a time

| Resource | REST request | MCP tool |
| --- | --- | --- |
| Account identity and permissions | `GET /v1/accounts/:id` | `account_get` |
| Effective quotas | `GET /v1/account/limits` | `account_limits` |
| Mailbox details | `GET /v1/mailboxes/:id` | `mailbox_get` |
| Received messages | `GET /v1/mailboxes/:id/emails` | `mailbox_email_list` |
| Stored files | `GET /v1/mailboxes/:id/files` | `mailbox_file_list` |

A mailbox read includes its identity, current revision and summary counts.
Fetch file lists, messages, version history and account limits separately.
Responses keep their named resources under `data`, such as `data.mailbox` or
`data.files`. Related results of a write may share one response.

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
      "max_received_emails_per_month": 300
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

`data.usage.mailbox_creations` is an optional object, separate from `data.limits`.
It is returned to a full-account browser session or an unrestricted account-wide
connection with admin permission (`mailbox_admin` or `full_account_access`).
The human membership must also cover the whole account. Read-only/write-only,
selected-mailbox, denied-mailbox and mailbox-scoped memberships do not receive this
usage object; their existing limits response remains available.

| Field in `usage.mailbox_creations` | Meaning |
| --- | --- |
| `monthly_limit` | Shared billing-group allowance for this UTC calendar month. |
| `used` | Committed creations this month. |
| `remaining` | Creations left; deleting or archiving a mailbox does not refund usage. |
| `resets_at` | ISO 8601 UTC reset time. |

Use this for planning, then handle `MAILBOX_CREATION_LIMIT_REACHED` from the actual
creation request. Concurrent callers can spend capacity after a preflight read.
The dashboard shows creation usage in **Account → Subscription**. This allowance
is separate from active mailbox capacity.

| Interface | Read limits |
| --- | --- |
| REST | `GET /v1/account/limits`; optional `account_id` query selects a granted account. |
| MCP | `account_limits`. |
| CLI | `revdoku account limits`; optional `--account-id ID`. |

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

Hosted applications receive signed HTTP webhooks. Local projects open an outbound
WebSocket through Rails Action Cable; no public domain or tunnel is required.
Both deliver the same event after the complete email and attachments are saved.
Read contents through the existing email API.

| Endpoint | Permission | Result |
| --- | --- | --- |
| GET /v1/mailboxes/:mailbox_id/email/webhook | Mailbox admin | Endpoint, or webhook: null; excludes the signing secret. |
| PUT /v1/mailboxes/:mailbox_id/email/webhook | Mailbox admin | Set one URL; returns the endpoint and signing secret. |
| DELETE /v1/mailboxes/:mailbox_id/email/webhook | Mailbox admin | Disable delivery; 204 No Content. |
| GET /v1/mailboxes/:mailbox_id/email/subscription | Mailbox read | Signed WebSocket ticket valid for 60 seconds. |

Use your normal bearer API key. Select another granted account with account_id in
the query for GET/DELETE, or in the JSON body for PUT. Endpoints must use public
HTTPS, including explicit ports such as 8443, with no URL user/password or fragment. Local/private addresses
and redirects are rejected. Invalid configuration returns INVALID_EMAIL_WEBHOOK (422).

| PUT field | Meaning |
| --- | --- |
| webhook_url | Required public HTTPS receiver URL, up to 2048 bytes. |
| rotate_secret | Optional boolean, default false. Replace the secret even when the URL is unchanged; pending deliveries are canceled. |
| account_id | Optional explicitly granted account; defaults to the credential's account. |

### Hosted application workflow

1. Implement an HTTPS POST receiver.
2. PUT {"webhook_url":"https://example.org/email-events"} to configure it. Securely save
   data.webhook.signing_secret. Repeating PUT with the same URL retains the secret;
   replacing the URL rotates it and cancels pending old-endpoint deliveries.
3. Verify the exact request bytes before parsing JSON.
4. Deduplicate the event ID, durably accept the event, and return any 2xx.
5. Fetch /v1/mailboxes/:mailbox_id/emails/:email_id with your own API key.

~~~json
{
  "id": "email.received:eml_example",
  "type": "email.received",
  "created_at": "2026-10-01T12:00:00.000000Z",
  "data": {
    "account_id": "acct_example",
    "mailbox_id": "bkt_example",
    "email_id": "eml_example",
    "received_at": "2026-10-01T11:59:58.000000Z",
    "attachment_count": 1
  }
}
~~~

| Field | Meaning |
| --- | --- |
| id | Stable event ID for deduplication; unchanged on retries. |
| type | email.received. |
| created_at | UTC time when intake queued the event. |
| data.account_id, data.mailbox_id | Account and mailbox that saved the message. |
| data.email_id | Stable email ID for the existing read endpoint. |
| data.received_at | UTC email receipt time. |
| data.attachment_count | Number of saved attachments. |

Events contain no subjects, senders, bodies, download links or API credentials.
Only new accepted deliveries emit them. Edits, copies, backfills and read changes
do not. Configuring a webhook does not replay history. Copies and account moves
clear the webhook; configure the destination explicitly.

| Header | Meaning |
| --- | --- |
| X-Revdoku-Event-Id | Event id. |
| X-Revdoku-Timestamp | Unix seconds for this delivery attempt. |
| X-Revdoku-Signature | v1= followed by lowercase HMAC-SHA256 hex. |

Sign timestamp + "." + raw_body. Reject timestamps outside a five-minute window
and compare signatures in constant time. A Rails receiver can use:

~~~ruby
timestamp = request.headers["X-Revdoku-Timestamp"].to_s
body = request.raw_post
provided = request.headers["X-Revdoku-Signature"].to_s.delete_prefix("v1=")
fresh = timestamp.match?(/\A\d+\z/) && (Time.current.to_i - timestamp.to_i).abs <= 300
expected = OpenSSL::HMAC.hexdigest("SHA256", ENV.fetch("REVDOKU_WEBHOOK_SECRET"), "#{timestamp}.#{body}")
return head :unauthorized unless fresh && ActiveSupport::SecurityUtils.secure_compare(expected, provided)
event = JSON.parse(body)
# Persist/deduplicate event["id"] and queue application work before returning 2xx.
head :no_content
~~~

Use your application's normal webhook CSRF exemption. Verify signatures before accepting requests.

| Delivery rule | Behavior |
| --- | --- |
| Automatic attempts | Up to 8 total for network failures, HTTP 408, 429 and 5xx |
| Retry delay | Polynomial backoff; valid `Retry-After` on 429/503 is bounded to 1–3,600 seconds |
| Other failures | Other non-2xx responses, redirects, private destinations, or responses over 64 KiB stop delivery |
| Timeout | 15 seconds total per request; acknowledge promptly after durable acceptance |
| Fairness | One delivery at a time per billing account; retries share this limit |
| Disable / replace / rotate | Cancels pending attempts; an in-flight request may finish |
| Manual retry | Dashboard administrators may make up to 3 additional attempts, limited to 10 requests/minute per billing account |
| Retry identity | Same event ID, fresh timestamp and signature; no additional incoming-email charge |

Email storage, delivery history and notification enqueueing commit together.
Worker interruptions are recovered every five minutes within 24 hours of the event.
Delivery can repeat or arrive out of order; deduplicate by event ID.

### Plans and delivery history

| Allowance | Effective value |
| --- | --- |
| Mailboxes with a webhook | Existing active-mailbox capacity; read `limits.max_mailboxes`. |
| Endpoints per mailbox | One. |
| New email events | Follow accepted messages within incoming count, byte and storage limits. |
| Delivery history | Read `limits.audit_retention_days`. |

Webhook capacity follows the account's existing mailbox and incoming-email limits, including overrides and shared billing. There is no separate webhook event allowance.

Account administrators use **Analytics → Webhooks** in the dashboard.

- Filter by mailbox, date and delivery status.
- Inspect HTTP status, attempt times and the next automatic retry.
- Retry failed deliveries while the account is writable and the same webhook is active.
- `Delivered` means the endpoint returned HTTP 2xx.
- History contains operational metadata. Email contents and receiver response bodies are excluded; endpoint paths and queries are redacted.

### Local project workflow

1. GET a subscription ticket with your read-authorized API key.
2. Open the returned `websocket_url`, adding `email_subscription_token=TICKET`
   within 60 seconds, using the `actioncable-v1-json` subprotocol.
3. Subscribe to EmailReceivedChannel with the returned account_id and mailbox_id.
   Wait for confirm_subscription.
4. List messages with your saved ascending arrival cursor and process every page.
   Deduplicate email IDs against live events received during catch-up.
5. Handle each live event's message and fetch its email through REST.
6. On a temporary disconnect, get a fresh ticket, reconnect, and repeat cursor catch-up. Stop if the server rejects the subscription or sends `reconnect: false`.

Runnable [JavaScript/TypeScript and Python examples](https://github.com/revdoku/revdoku/tree/main/examples) cover signed receivers and reconnects. The Node `watch-mail.js` example waits for subscription confirmation, catches up with a saved cursor, detects stale connections, and requests a fresh ticket on reconnect.

| Client guard | Limit |
| --- | --- |
| Duplicate mailbox subscriptions | One per connection |
| Mailbox subscriptions | 32 per connection; tickets authorize one mailbox |
| Connections | 32 per credential per web process |
| Handshakes | 120 per minute per source IP |
| Client commands | 120 per minute per connection; 4 KiB maximum per command |

Keep account, mailbox and filters unchanged when reusing a cursor. Preserve `pagination.next_cursor` even after an empty page. WebSocket events are live hints; REST catch-up supplies messages received while disconnected.

A receiver must remain running. Webhooks and WebSockets do not wake an idle AI chat. The CLI's `email-subscription` and MCP's `mailbox_email_subscription` return connection details for that receiver. Webhook configuration is available through `webhook`, `webhook-set`, `webhook-delete` and the corresponding `mailbox_email_webhook_get`, `mailbox_email_webhook_set`, `mailbox_email_webhook_delete` MCP tools.

Ticket expiry limits connection establishment; an established subscription lasts
until disconnect or access revocation. Credentials and membership are checked before
each transmitted event. Treat the ticket as a temporary credential: it authorizes
only its selected mailbox channel, never account notification streams.

## Incoming email into a mailbox

The dashboard provides **Mailbox / Raw Files** tabs for each mailbox.
These are views of the same authorized files. List / Tiles stays inside
Raw Files; the Mailbox badge counts unread messages, not attachments. Clients use
the email resource below; original files remain accessible through the file API.

Each mailbox has its own incoming email address for receiving messages and
attachments alongside uploaded files. Anyone knowing the address can email it;
reading messages requires authorized mailbox access. Use only the returned address;
choose a username when creating the mailbox, or connect your own custom domain.

| Operation | REST / MCP |
| --- | --- |
| Create an mailbox | `POST /v1/mailboxes` / `mailbox_create`; creation automatically returns `mailbox.email` with address and receiving state. Template/copy creation assigns a separate address. |
| Get address/state | `GET /v1/mailboxes/:id/email`, or mailbox detail / `mailbox_get` with `include_email=true`; requires upload/write access. |
| Check for new mail | `GET /v1/mailboxes/:id/emails` / `mailbox_email_list`; save `pagination.next_cursor`. |
| Read a message | `GET /v1/mailboxes/:id/emails/:email_id` / `mailbox_email_get`. |
| Rotate address | `POST /v1/mailboxes/:id/email/rotate`; requires write access and explicit confirmation. |

For CLI use, `revdoku mailbox --mailbox-id ID` retrieves address/state, and
`revdoku emails --mailbox-id ID` lists messages; `revdoku email EMAIL_ID --mailbox-id ID` reads one. For hosted agents,
see the [MCP mailbox walkthrough](https://github.com/revdoku/revdoku/blob/main/mcp.md).

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

### Admin notification schedules

Manage notification emails in **Account Settings → Notifications**. Preferences
belong to the signed-in person within the selected account.

| Setting | Behavior |
| --- | --- |
| `none` | No activity email; in-app bell notices remain. |
| `immediately` | Send activity email as it occurs, within the monthly allowance. |
| `daily` | Default. Send an activity summary at 08:00 in the person's timezone. |
| `weekly` | Send an activity summary on Monday at 08:00. |

Only accounts with activity send summaries. Security/account alerts are independent.

| Browser endpoint | Purpose |
| --- | --- |
| `GET /v1/account/notification_settings` | Read the current person's preferences. |
| `PATCH /v1/account/notification_settings` | Change the current person's preferences. Requires `expected_account_id` and the page's CSRF token. |

These endpoints require a browser session; API keys and MCP tools do not access them.

| Field | Meaning |
| --- | --- |
| `activity_frequency` | Requested setting; the only editable preference in this endpoint. |
| `activity_delivery_frequency` | Effective delivery schedule. Falls back to `daily` when the immediate-email allowance is exhausted. |
| `activity_frequency_editable` | Whether this person can change the schedule. |
| `account_id` | Account these preferences apply to. |
| `time_zone` | Timezone used to schedule summaries. |

- Immediate activity email has a separate billing-group monthly allowance.
- Each recipient/send attempt counts, including failed attempts.
- Exhaustion leaves the requested preference unchanged and uses daily delivery until reset or a limit increase.
- Activity notifications do not consume the incoming-email allowance.

<a id="custom-receiving-domains"></a>

### Custom email domains

Built-in domains such as `revdokumail.com` work on every plan, including when
explicitly supplied as `mailbox.email.domain`. For custom domains:

| Error code | Action |
| --- | --- |
| `EMAIL_DOMAINS_UPGRADE_REQUIRED` | Upgrade at [Pricing](https://app.revdoku.com/pricing); `error.details.upgrade_url` contains this link. |
| `EMAIL_DOMAIN_NOT_REGISTERED` | Add and verify the domain in [Account Settings → Domains](https://app.revdoku.com/account/domains) first. |
| `EMAIL_DOMAIN_NOT_READY` | Complete verification or resolve receiving restrictions for the registered domain. |

The latter two errors include `error.details.settings_url`. Mailbox creation
does not automatically register a custom domain or fall back to another domain.

Connect a domain in **Account Settings → Domains → Email**, or use these endpoints
with a whole-account `mailbox_admin` credential belonging to an account owner or administrator.
Selected-mailbox, read-only and write-only credentials cannot manage domain ownership.
Existing `full_account_access` credentials continue to work.

| Method | Path | Purpose |
| --- | --- | --- |
| GET | `/v1/account/email_domains` | List account email domains. |
| POST | `/v1/account/email_domains/check` | Check a hostname for DNS conflicts before connecting it. |
| POST | `/v1/account/email_domains` | Start connecting a domain. |
| GET | `/v1/account/email_domains/:id` | Read DNS requirements and receiving state. |
| POST | `/v1/account/email_domains/:id/verify` | Check ownership and provider setup. |
| DELETE | `/v1/account/email_domains/:id` | Remove a domain after its mailbox assignments have been removed. |

| Field or requirement | Purpose |
| --- | --- |
| `customization.allowed` | Whether this caller can customize the mailbox domain. |
| `customization.blocked_reason` | Why customization is unavailable. |
| `hostname` | Exact domain hostname; also required to confirm deletion. |
| `confirm: true` | Explicit confirmation for deletion. |
| `retryable` | Whether a reported setup error can be retried. |

#### Choose a domain

| Your setup | Domain to connect | Example mailbox |
| --- | --- | --- |
| `yourdomain.com` already receives email through another provider | An unused subdomain, such as `mailbox.yourdomain.com` | `support@mailbox.yourdomain.com` |
| A domain dedicated to Revdoku email | The root domain, such as `yourdomain.com` | `support@yourdomain.com` |

Using `mailbox.yourdomain.com` keeps existing mailboxes at `yourdomain.com` with their
current provider. Add DNS records only at the hostname shown in the setup instructions.

| DNS check | Result |
| --- | --- |
| Another provider's MX records at the chosen hostname | HTTP 422, `EMAIL_DNS_CONFLICT`. Keep those records and choose an unused subdomain. |
| Revdoku and another provider's MX records together, or a CNAME | HTTP 422, `EMAIL_DNS_CONFLICT`. MX priority cannot split individual mailboxes between providers. |
| DNS lookup temporarily unavailable | HTTP 503, `EMAIL_DNS_TEMPORARY`; retry the check later. |
| Null MX (the hostname currently accepts no mail) | Setup can start; replace the null MX with the required receiving MX before activation. |

Checks run before connecting and again during verification. Revdoku does not
change your DNS records. A successful check does not activate receiving.

- DNS ownership instructions are visible only to full-account administrators.
- Unverified claims expire after seven days.
- Cookie-authenticated writes require CSRF protection.

#### Use a connected domain

Connecting a domain preserves existing addresses. Select it when creating an mailbox,
or use the address replacement endpoint for an existing mailbox.

| Replacement field | Purpose |
| --- | --- |
| `domain` | Exact ready domain, such as `mail.example.com`; use `platform` for the platform domain. |
| `username` | Optional chosen name, such as `my-agent`. Omit for a generated name. |
| `current_address` | Current address being replaced. |
| `confirm` | Must be `true`. |

Custom names require account-administrator access and deployment support.
[Username rules](#username-rules) also apply. Platform domains also accept chosen
names; their reserved-name rules still apply.

| Replacement result | Behavior |
| --- | --- |
| `202`, assignment `pending` | Setup is running. Read the mailbox settings to check progress. The old address remains current. |
| Assignment `active` | The new primary is assigned and one rotation is charged. Check `receiving_enabled` before using it. |
| Assignment `failed` | The old address and rotation allowance are preserved. |

| Mailbox settings field | Meaning |
| --- | --- |
| `domain` | Domain of the current address. |
| `custom_domain` | Whether the address uses a customer-owned domain. |
| `available_domains` | Domains available for this account. |
| `assignment` | Replacement status and any error. A pending candidate is never a usable address. |
| `customization.allowed` | Whether this caller can customize the domain. |
| `customization.blocked_reason` | Why customization is unavailable. |
| `customization.settings_url` | Dashboard settings link for account administrators. |

- Custom-domain names remain reserved to their original account. That account may reuse a released name once no primary, alias or pending assignment holds it; archived mailboxes retain their addresses.
- Platform addresses cannot be reused, even after deletion.
- A downgrade preserves assigned addresses but can block new domain setup or switching.
- Switch to a platform address and remove custom-domain aliases before moving a mailbox to another account. Copies get fresh platform addresses without aliases.
- Mail sent while receiving is paused is not automatically recovered.

### Email files in `_email/`

Use the email endpoints for ordinary message workflows. The underlying files remain
available through the file API:

```text
_email/inbox/<sender>/<subject-group>/<delivery>/
  message.eml
  message.json
  message.md
  attachments/
```

| Stored file | Contents |
| --- | --- |
| `message.eml` | Original email, including MIME headers and inline parts. Use it when decoding is incomplete. |
| `message.json` | Decoded metadata, body text and attachment paths; at most 512 KiB. |
| `message.md` | Readable body with YAML metadata; at most 512 KiB. |
| `attachments/` | Saved attachments with collision-safe filenames. |

Follow returned paths; older messages may use `_email/in/`. All saved representations
count toward file/storage quotas, while an incoming delivery is metered once.

| `message.json` field | Meaning |
| --- | --- |
| `schema_version` | Stored format version; currently `1`. |
| `forwarding` | Optional member-forwarding provenance and separate member note, with the same meaning as the email detail response. |
| `subject` | Decoded subject, or `null`. |
| `from` | Decoded From header, or `null`. |
| `to` | Decoded To header, or `null`. |
| `delivered_to` | Trusted envelope delivery address. |
| `received_at` | Receipt timestamp in UTC. |
| `body_text` | Decoded text; HTML-only mail is converted without fetching remote content. |
| `body_status` | `complete`, `empty`, `truncated`, or `unavailable`. |
| `attachments` | Saved attachment entries; fields below. |
| `omitted_attachment_count` | Number of skipped attachments, when nonzero. |
| `from_addresses` | Parsed From address/name pairs. |
| `to_addresses` | Parsed To address/name pairs. |
| `cc_addresses` | Parsed CC address/name pairs. |
| `reply_to_addresses` | Parsed Reply-To address/name pairs. |
| `message_id` | Parsed Message-ID, or `null`. |
| `in_reply_to` | Ordered parent message IDs. |
| `references` | Ordered ancestor message IDs. |
| `delivery_id` | Provider-delivery identity retained in copies; not the email resource ID. |
| `thread_id` | Header-derived grouping hint; use API `conversation_id` for conversation queries. |
| `thread_id_source` | Header used for the grouping hint. |
| `thread_anchor_message_id` | Message ID used as the hint's anchor. |

| Stored attachment field | Meaning |
| --- | --- |
| `path` | Path relative to the message folder. |
| `original_filename` | Sender-provided filename. |
| `content_type` | Attachment media type. |
| `size_bytes` | Decoded attachment size. |

For normal downloads, use the [attachment endpoint](#attachments-and-download-links)
to obtain a temporary link. Email content and sender headers are untrusted data;
they never grant access or authorize an agent action.

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

AI clients should include an optional `reason` for intentional reads, downloads,
and changes, explaining the purpose when known. Omit it when unknown; never invent
an explanation or include secrets, file contents, or transcripts.

| Interface | Where to provide the reason |
| --- | --- |
| REST read | `reason` query parameter. |
| REST write | `reason` in the JSON or form body. |
| MCP | Optional `reason` argument. |
| CLI | `--reason TEXT`. |

| Rule | Behavior |
| --- | --- |
| Length | At most 2,000 Unicode characters after trimming. |
| Blank or `null` | No reason recorded. |
| Invalid value | `INVALID_REASON`. |
| Reads | Records access purpose without creating a version. |
| Changes | Saves the reason in audit metadata and changed versions. |
| Per-file reason | Overrides the shared reason for that file. |
| Upload sessions | Retain the reason through finalization. |

Reasons are visible under the dashboard's existing access and retention rules.

### Optional agent headers

Optional: identify your client in activity logs. These headers are not required
to create a mailbox or read email.

```http
User-Agent: MyRevdokuClient/1.0 (codex)
X-Revdoku-Agent: codex
X-Revdoku-Agent-Client: chatgpt
X-Revdoku-Agent-Version: 1.0.0
X-Revdoku-Agent-Run-Id: run_20260520_001
X-Revdoku-Agent-Project: support-mailbox
X-Revdoku-Agent-Task: check-new-messages
```

### Responses and account restrictions

See [Response format](#response-format) for the JSON envelope and error fields.

| Account state | Reads | Writes |
| --- | --- | --- |
| Active | Allowed within the credential's permissions. | Allowed within permissions and quotas. |
| Read-only | Existing files remain downloadable. | Return the account-state error. |

Show the returned notice and support guidance when an account is restricted.

### Versioning

| Surface | Version field |
| --- | --- |
| REST response | `X-Revdoku-Client-Version` header. |
| `GET /v1/status` | `server_version` for the running app; `client_version` for local tooling. |
| MCP initialization | `serverInfo.version`. |
| MCP status | `mcp.server_version`. |

Reconnect MCP clients to refresh their tool list. Rerun the official installer to
update the local CLI.

## Hosted MCP for cloud AI clients

Cloud agents that support custom remote MCP connectors connect to Revdoku through
the production remote MCP endpoint:

```text
https://mcp.revdoku.com
```

Follow <https://revdoku.com/connect/> for the current client-specific setup.
Add the URL as a remote MCP/custom connector when the client and account support
write-capable MCP tools. If write tools are unavailable, use the dashboard or
local CLI. The connector uses Revdoku OAuth
discovery, authorization-code PKCE, `offline_access` refresh support, and Bearer
tokens. Users approve the exact Revdoku account shown on the consent screen and
can revoke the connection later from `/account/access`.

Hosted MCP is stateless Streamable HTTP. Clients discover tools with `tools/list`
when they connect, so reconnect after an update to discover newly added tools.

| Task | Interface |
| --- | --- |
| Read messages and attachments | Hosted MCP email tools. |
| Read or write text files | `mailbox_file_read` and `mailbox_file_write`. |
| Upload local files, folders or binary files | CLI, or REST direct uploads. |
| Read files by path | `GET /v1/mailboxes/:id/files/by_path`. |
| List files | `mailbox_file_list`, or `revdoku files`. |

Hosted MCP cannot access your local filesystem. Uploads enforce file-type and
content rules. Mailbox responses provide authorized action metadata so tools can
handle resource IDs without asking users to type them.

## Common Workflows

### Connect an Agent

For ChatGPT, Claude, or another remote MCP client, connect:

```text
https://mcp.revdoku.com
```

Agents and clients can discover supported auth methods at
`GET /v1/agent_auth/capabilities`. The preferred local flow is OAuth device
authorization. Remote MCP clients use Revdoku OAuth authorization code flow.

Local CLI/device-code flow:

```http
POST /oauth/register
Content-Type: application/json

{
  "client_name": "Codex on laptop",
  "redirect_uris": [],
  "grant_types": [
    "urn:ietf:params:oauth:grant-type:device_code",
    "refresh_token"
  ],
  "response_types": [],
  "token_endpoint_auth_method": "none"
}

POST /oauth/device_authorization
Content-Type: application/json

{
  "client_id": "mcp_client_...",
  "scope": "revdoku:mcp",
  "resource": "https://mcp.revdoku.com"
}
```

1. Open the returned browser link and show the Connection ID to the human.
2. The human checks the same ID in Revdoku and selects **Confirm Connection**.
3. Poll the token endpoint until approval or expiry.
4. Store the returned credential privately. Permissions can be reduced in **Account → Access**.

| Field | Purpose |
| --- | --- |
| `verification_uri_complete` | Browser approval link. |
| `user_code` | Connection ID for visual confirmation; never request it in chat. |
| `device_code` | Private code used while polling the token endpoint. |
| `interval` | Minimum delay between polls. |
| `revdoku_api_key` | Revdoku extension returned after approval for local REST tooling. |

Legacy fallback email-code flow:

```http
POST /v1/agent_auth/request_code
Content-Type: application/json

{
  "email": "person@example.com"
}

POST /v1/agent_auth/verify_code
Content-Type: application/json

{
  "email": "person@example.com",
  "code": "123456",
  "label": "Codex on laptop",
  "mailbox_access": "all"
}
```

Store the returned `data.api_key` securely. Follow `data.guidance` when the
server includes it. This fallback belongs in a private interactive client UI,
not an AI chat: never ask the user to paste or repeat the verification code in
chat. Do not print or log the key.

### Create a Mailbox

See the [mailbox creation example](#create-another-mailbox). To generate a username,
send `{"mailbox": {}}`.

#### Optional creation fields

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
- Browser signup already creates one starter mailbox.

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

### Upload Multiple Files

Use the CLI for a local folder: `revdoku upload ./folder --mailbox-id ID`.
To implement folder uploads yourself:

1. Open an upload session with the expected file count.
2. Request upload URLs for a small batch of files.
3. Upload each file, then finalize that batch.
4. Repeat until all files are uploaded.
5. Complete the session.

| Option or event | Behavior |
| --- | --- |
| `delete_missing: true` | Full-folder sync: remove omitted destination files only when the entire session completes. Omit for ordinary uploads. |
| Connection interrupted | Already finalized files remain saved. |
| Session expires | Unfinished uploads are abandoned and the write lock is released. |
| `complete: false` | Cancel remaining work and release the lock. |

```http
POST /v1/mailboxes/bkt_.../upload_sessions
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "delete_missing": true,
  "expected_file_count": 123
}
```

Then request descriptors for one subbatch:

```http
POST /v1/mailboxes/bkt_.../upload_sessions/bus_.../uploads
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "files": [
    {
      "path": "index.html",
      "name": "index.html",
      "byte_size": 1234,
      "checksum": "BASE64_MD5",
      "content_type": "text/html",
      "sha256": "HEX_SHA256"
    }
  ]
}
```

Use `data.uploads[].upload.url` and `data.uploads[].upload.headers` for the
object-storage `PUT`. Do not send Revdoku authorization headers to object
storage. After each successful descriptor subbatch, commit a bounded batch:

```http
POST /v1/mailboxes/bkt_.../upload_sessions/bus_.../finalize_batch
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "limit": 12
}
```

Repeat descriptor and finalize subbatches until all selected files are uploaded.

Close the session when all uploads are done. Use `complete:false` only when
canceling or interrupting the upload; it closes the session and releases the
lock without committing any unfinalized staged uploads.

```http
POST /v1/mailboxes/bkt_.../upload_sessions/bus_.../finalize
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "complete": true
}
```

For large sessions, finalization can take several requests.

| Finalize result | Meaning |
| --- | --- |
| HTTP `202` | More files remain to be finalized. |
| `data.finalize_pending` | `true` while work remains. |
| `data.remaining_files_count` | Files still waiting for finalization. |
| `Retry-After` header | Delay before calling the same finalize endpoint again. |

Repeat finalization until the pending flag is no longer true.

## Direct API signup

Use this flow to create a new owner's Revdoku account, with that human's
authorization and email verification. To add an mailbox for an application customer,
use the [SaaS mapping](https://github.com/revdoku/revdoku/blob/main/guides/saas-mailboxes.md#map-customers-and-choose-access).
Successful verification creates an account, its first email mailbox with cloud
storage, and an API key. No existing API key is required.

Base URL: `https://api.revdoku.com/v1`.

| Method | Path | Purpose |
| --- | --- | --- |
| POST | `/v1/agent/signups` | Send a verification code to the human owner's email. |
| POST | `/v1/agent/signups/verify` | Verify the code and create the account, first mailbox, and API key. |
| POST | `/v1/agent/signups/resend` | Resend the code after the returned waiting period. |

Check `GET /v1/agent_auth/capabilities`: `data.signup.available` reports whether
API signup is enabled. If unavailable, use [browser signup](https://app.revdoku.com/users/sign_up).
Existing users use [browser sign-in](https://app.revdoku.com/users/sign_in).
MCP offers the same flow through [signup tools](mcp.md#direct-mcp-signup).
Clients must handle owner authorization and verification privately. CLI sign-in
and hosted MCP account access use browser OAuth.

### 1. Request a code

The human operator must provide their email and authorize the acknowledgments.
The server records the current policy versions; your client does not send a version.

Read all three policy documents without website access through
[`GET /v1/agent_auth/policies`](https://api.revdoku.com/v1/agent_auth/policies).
This unauthenticated read returns `data.policies.terms`, `data.policies.acceptable_use`,
and `data.policies.privacy`. It works even when signup is disabled. Discovery exposes
this endpoint as `data.signup.policies_url`.

| Document field | Meaning |
| --- | --- |
| `url` | Canonical public URL. |
| `version` | Packaged policy version. |
| `sha256` | SHA-256 of the UTF-8 Markdown text. |
| `text` | Complete policy text in Markdown. |

Reading is optional and does not record acceptance. The human owner must still
authorize `accept_terms_and_policy: true`. A client that cannot read the documents
must refer acceptance to its human owner. No policy version or hash is required
in the signup request.

| Field | Required | Purpose |
| --- | --- | --- |
| `human_operator_email` | Yes | The human owner's email, supplied by that person. Do not substitute an agent's mailbox. |
| `accept_terms_and_policy` | Yes; `true` | The human agrees to the [Terms](https://revdoku.com/terms) and [acceptable use policy](https://revdoku.com/acceptable-use), and acknowledges the [privacy notice](https://revdoku.com/privacy). This is not consent to optional processing. |
| `username` | No | Prefix for the first Free mailbox, with a 12-character random suffix added; generated if omitted. |
| `permission_scope` | No | `mailbox_read`, `mailbox_write`, or `mailbox_admin` (default). |
| `label` | No | A name for the API connection. |

```http
POST /v1/agent/signups
Host: api.revdoku.com
Content-Type: application/json

{
  "human_operator_email": "owner@customer.example",
  "accept_terms_and_policy": true
}

202 Accepted
{
  "success": true,
  "data": {
    "signup": {
      "signup_token": "RETURNED_SIGNUP_TOKEN",
      "expires_in": 600,
      "resend_after": 60
    }
  }
}
```

No account or mailbox is created until the email code is verified.

| Returned field | Use |
| --- | --- |
| `signup_token` | Save privately; include it when verifying or resending. It identifies and protects this signup attempt. |
| `expires_in` | Seconds left to finish signup. |
| `resend_after` | Seconds to wait before requesting another code. |

### 2. Verify the code

Collect the code in your private application interface. Do not put the token or
code in URLs, logs, command-line arguments, or AI chat.

```http
POST /v1/agent/signups/verify
Host: api.revdoku.com
Content-Type: application/json

{
  "signup_token": "RETURNED_SIGNUP_TOKEN",
  "code": "123456"
}

201 Created
{
  "success": true,
  "data": {
    "signup": {
      "status": "completed"
    },
    "api_key": "RETURNED_ONCE_STORE_PRIVATELY",
    "scope": "mailbox_admin",
    "expires_at": "2027-09-30T12:00:00Z",
    "account": {
      "id": "acct_RETURNED_ID"
    },
    "mailbox": {
      "id": "bkt_RETURNED_ID",
      "email": {
        "address": "flaky.forest3v8x2p@revdokumail.com",
        "receiving_enabled": true,
        "sending_enabled": false
      }
    }
  }
}
```

The example shows selected fields. Signup creates your account, API key and first
mailbox together, then waits for receiving confirmation. If the provider is
unavailable, signup still returns your API key, with `receiving_enabled: false`
and a `blocked_reason`. Check `email.receiving_enabled` before using the address;
reuse the returned mailbox rather than creating another account.

| Result | Next step |
| --- | --- |
| `api_key` returned | Store it privately now; it is returned once. Use it as the bearer token. This signup credential counts as one AI agent connection; no second key is needed. |
| Username error | Resubmit verification with the same token and a corrected `username`; no new code is needed after successful proof. |
| `SIGN_IN_REQUIRED` | The human already has an account. Use browser sign-in. |
| HTTP `200` with completed IDs but no key | This signup already completed. Sign in and manage API keys under Account → Access. |
| `INVALID_SIGNUP_TOKEN` | The token is invalid or expired. Start again with the human's authorization. |

### Resend a code

Wait the returned `resend_after` seconds, then:

```http
POST /v1/agent/signups/resend
Host: api.revdoku.com
Content-Type: application/json

{
  "signup_token": "RETURNED_SIGNUP_TOKEN"
}
```

HTTP `200 OK` returns the same signup structure with the remaining timers. The
previous code stops working. Resending does not extend the expiry or reset attempts.

### Signup limits

| Limit | Allowance |
| --- | --- |
| Start/resend per IP | 5 per 15 minutes, shared with browser signup and legacy code requests. |
| Verification per IP | 10 per 15 minutes. |
| Attempts per challenge | 5. |
| Verification per canonical human email | 10 per 15 minutes. |
| API email sends | 60-second cooldown; 3 per 30 minutes. |
| Shared browser/API/sign-in email sends | 3 per canonical email per 5 minutes. |
| Global signup requests | 300 per minute. |
| Global signup emails | 100 per hour. |
| Request body | At most 8 KiB of uncompressed JSON. |

- Invalid challenges and fake credentials still count toward limits.
- Throttles return HTTP 429 with `Retry-After`.
- Error codes: `RATE_LIMIT_EXCEEDED`, `SIGNUP_RATE_LIMITED`, or `SIGNUP_ATTEMPTS_EXCEEDED`.
- Limits may be tightened to protect availability.

Signup responses use `Cache-Control: no-store`. Availability is reported by
`GET /v1/agent_auth/capabilities` in `data.signup.available`.
CLI and MCP use browser OAuth; they do not collect signup codes in chat.

## API Reference

### Signup endpoints — no API key required

Start with the [signup workflow](#direct-api-signup) for owner authorization,
private email verification, and response fields.

| Method | Path | Purpose |
| --- | --- | --- |
| `POST` | `/v1/agent/signups` | Send the human owner a verification code; return a private signup token. |
| `POST` | `/v1/agent/signups/verify` | Verify the code; create the account, first mailbox, and API key. |
| `POST` | `/v1/agent/signups/resend` | Resend the code using the same signup token after the waiting period. |

### Authentication Endpoints

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/v1/agent_auth/capabilities` | Machine-readable agent auth manifest. |
| `GET` | `/v1/agent_auth/status` | API-key status alias for agents; same connection payload as `/v1/status`. |
| `POST` | `/v1/agent_auth/request_code` | Request an email verification code without revealing whether the email has a Revdoku account. Existing-user sign-in only; use browser signup or the separate API signup flow for a new identity. |
| `POST` | `/v1/agent_auth/verify_code` | Verify the email code and create an API key when the code is valid. |
| `POST` | `/v1/agent_auth/browser_login_link` | Return a stable dashboard URL (legacy endpoint name; normal sign-in is required). |
| `POST` | `/oauth/device_authorization` | Start OAuth device authorization for local CLI/agent clients. |
| `GET` / `POST` | `/oauth/device` | Browser page where the user enters/approves a device code. |
| `POST` | `/oauth/token` | Exchange OAuth authorization codes, device codes, or refresh tokens. |

#### OAuth Device Authorization

Local agents should prefer OAuth device authorization over email-code login. The
client registers with grant type
`urn:ietf:params:oauth:grant-type:device_code`, calls
`POST /oauth/device_authorization`, shows the returned `verification_uri_complete`
and presents `user_code` as a **Connection ID**, then polls `POST /oauth/token`.
Tell the user `Connection ID is <ID>` and ask only that they make sure the same
ID appears in the top-right of Revdoku before selecting **Confirm Connection**.
Do not ask them to type, paste, or repeat it.

Pending poll responses use standard device-flow errors:

| Error | Meaning |
| --- | --- |
| `authorization_pending` | User has not approved yet; wait `interval` seconds and poll again. |
| `slow_down` | Increase the polling interval. |
| `access_denied` | User denied the browser prompt. |
| `expired_token` | Device code expired; start again. |

Successful device-code token responses include normal OAuth fields plus
`revdoku_api_key`, a durable `revdoku_...` key for local REST API clients.
The browser approval screen defaults to selected mailboxes and `mailbox_read` when
the client does not request a scope. Choose the mailboxes and permission on that
screen. Selecting all existing mailboxes keeps a fixed selection; **All current and
future mailboxes** is a separate choice. Read access supports message/file reads;
provisioning new mailboxes requires account-wide `mailbox_admin`.

#### Permission scopes

| Scope | Meaning |
| --- | --- |
| `mailbox_read` | List and read allowed mailbox files only. |
| `mailbox_write` | Create and update allowed mailbox files. |
| `mailbox_admin` | Create, update, and manage allowed mailboxes. |

| Input | Purpose |
| --- | --- |
| `permission_scope` | Choose one of the permissions above; bound to consent. |
| OAuth `scope` | Protocol scope: `revdoku:mcp`, optionally `offline_access`. |
| Email-code `scope` | Legacy alias for `permission_scope` on email-code key creation only. |

OAuth/device requests and dashboard one-time connection prompts default to
`mailbox_read` when permission is omitted. Legacy email-code login, direct signup,
and raw API-key creation retain their `mailbox_admin` default; request an explicit
permission for those flows. Invalid values are rejected. Account → Access defaults
new keys to selected mailboxes and read permission.

#### POST /v1/agent_auth/request_code

The request returns the same success shape for every syntactically valid email.
It does not reveal whether an account exists, is locked, or has two-factor authentication.

| Response field | Purpose |
| --- | --- |
| `fallback_url` | Browser sign-in link if no code arrives or email-code verification fails. |
| `hint` | Explanation of the fallback. |

Use browser sign-in when required. Never ask for passwords, TOTP codes or backup
codes through an AI chat.

```json
{
  "email": "person@example.com"
}
```

#### POST /v1/agent_auth/verify_code

Verify a privately entered email code for an eligible account.

| Result | Behavior |
| --- | --- |
| Success | Returns a Revdoku API key. Store it privately. |
| `INVALID_CODE` | Verification failed; also covers locked accounts or accounts requiring two-factor authentication. |
| `error.details.fallback_url` | Browser sign-in link. |
| `error.details.hint` | Recovery explanation. |

Use browser device sign-in after verification fails; do not repeatedly submit codes.

```json
{
  "email": "person@example.com",
  "code": "123456",
  "label": "Codex on laptop",
  "permission_scope": "mailbox_admin",
  "mailbox_access": "all"
}
```

For selected-mailbox access, use:

```json
{
  "mailbox_access": "selected",
  "mailbox_ids": [
    "bkt_..."
  ],
  "mailbox_permissions": {
    "bkt_...": "write"
  }
}
```

#### POST /v1/agent_auth/browser_login_link

Requires `Authorization`. This compatibility endpoint returns a stable internal
dashboard URL and never exchanges an API key for a browser session. The user
signs in normally if the browser has no active Revdoku session.

```json
{
  "redirect_path": "/account/access"
}
```

Common `redirect_path` values:

| Path | Destination |
| --- | --- |
| `/mailboxes` | Mailbox dashboard. |
| `/account/access` | Members, agents, and API keys. |

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

#### POST /v1/mailboxes

Mailbox tags are user-facing labels, not filesystem breadcrumbs. Use
`tag_paths` only for explicit reusable labels such as `project`; store project,
source, task, or local-folder context in `metadata`.

```json
{
  "mailbox": {
    "description": "Shared project files and incoming documents",
    "tag_paths": [
      "project"
    ],
    "metadata": {
      "project": "client-documents"
    }
  }
}
```

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

When `account.restriction` reports a suspension, relay the returned notice and
support guidance. Stored files remain downloadable. Do not infer reasons or evade
the restriction.

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

## Integration Guidelines

### Surface Account Limits Clearly

When a limit is reached, explain the returned reason and direct the user to
Revdoku to review account capacity. Do not remove existing data without explicit
authorization.

### Do Not Leak Secrets

Never print, paste, commit, or log `revdoku_...` API keys or direct-upload URLs.

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
