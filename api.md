# Revdoku API

Revdoku provides **email inboxes for people and AI agents**, with private file
storage in each bucket. The REST API creates inboxes, lists and reads messages,
and downloads attachments. Buckets also support uploaded files and version history.

## Find what you need

| Task | Section |
| --- | --- |
| Make your first API request | [Quick start](#email-api-quick-start) |
| Understand JSON and errors | [Response format](#response-format) |
| Select an account | [Accounts](#accounts) |
| Check quotas | [Account limits](#account-limits) |
| Read email and attachments | [Received email operations](#received-email-operations) |
| Choose an email username | [Create a bucket](#create-a-bucket) |
| Create an account through the API | [Direct API signup](#direct-api-signup) |
| Upload a file | [Upload a file](#upload-a-file) |

## Email API quick start

1. [Sign up](https://app.revdoku.com/users/sign_up) or sign in.
2. Create an API key from **Connect via API** or **Account → Access**.
3. Replace `YOUR_API_KEY` below with that key in your private application.

Browser signup already creates one mailbox. Use `GET /v1/buckets` to find it,
or create another with the example below.


| Setting | Value |
| --- | --- |
| Base URL | `https://api.revdoku.com/v1` |
| Authentication | `Authorization: Bearer YOUR_API_KEY` |
| JSON requests | `Content-Type: application/json` |
| Account | Credential default; pass `account_id` to select another granted account. |

### 1. Create an inbox

```http
POST /v1/buckets
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "bucket": {
    "email": {
      "username": "project.alerts"
    }
  }
}
```

201 Created (selected fields)

```json
{
  "success": true,
  "data": {
    "bucket": {
      "id": "bkt_example",
      "title": "project.alerts",
      "email": {
        "username": "project.alerts",
        "address": "project.alerts@revdokumail.com",
        "receiving_enabled": true,
        "sending_enabled": false
      }
    }
  }
}
```

Creation waits for receiving setup. After `201 Created`, use the returned address immediately.
Keep the returned bucket ID for later requests.

### 2. List messages

Send a test email to the returned address from your normal email app.
Replace `bkt_example` with the bucket ID from step 1.
Save the returned cursor even when the list is empty:

```http
GET /v1/buckets/bkt_example/emails?limit=50
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

### 3. Read messages and attachments

| Task | Request |
| --- | --- |
| Read a returned message | `GET /v1/buckets/:bucket_id/emails/:email_id` |
| Get a temporary attachment link | `GET /v1/buckets/:bucket_id/emails/:email_id/attachments/:attachment_id` |

See [received email operations](#received-email-operations),
[OpenAPI](https://revdoku.com/openapi.json), and
[runnable JS/TypeScript examples](https://github.com/revdoku/revdoku/tree/main/examples).

AI-agent users can start with the Revdoku app's copied prompt or the
Revdoku skill. Use the local CLI when the agent has shell and filesystem access,
or hosted MCP otherwise. Use this HTTP API for custom clients, CI jobs, backend workers,
or direct integrations.

Hosted MCP requires OAuth before account tools can run. CLI and hosted MCP users sign up at
<https://app.revdoku.com/users/sign_up>. Direct private clients can use
[API signup](#direct-api-signup) when discovery reports it available.

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
| `data` | Named resources such as `bucket` or `buckets`. | Omitted. |
| `error` | Omitted. | Error code, message and optional details. |

Success — HTTP `201 Created` (selected bucket fields):

```json
{
  "success": true,
  "data": {
    "bucket": {
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
| Successful JSON request | `success: true` and `data`, containing named resources such as `bucket` or `buckets`. |
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

## Account limits

Read quotas when choosing a plan or handling a quota error. They are not included
in ordinary bucket responses.

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
      "max_buckets": 3,
      "max_file_size_bytes": 10485760,
      "max_received_emails_per_month": 300
    }
  }
}
```

| Field in `limits` | What it limits |
| --- | --- |
| `max_buckets` | Buckets retained in the billing group. |
| `max_bucket_creations_per_month` | New buckets per UTC calendar month. Deleting a bucket does not refund a creation. |
| `max_files_per_bucket` | Current files in one bucket. |
| `max_current_files` | Current files across the billing group. |
| `max_storage_bytes` | Total stored bytes. |
| `max_file_size_bytes` | Bytes in one uploaded file. |
| `max_pdf_size_bytes` | Bytes in one uploaded PDF, which may have a different limit. |
| `max_file_versions_per_file` | Retained versions of each file. |
| `max_email_domains` | Custom email domains in this account. |
| `max_received_emails_per_month` | Incoming messages per billing period. |
| `max_received_email_bytes_per_month` | Incoming raw-message bytes per billing period, including MIME encoding. |
| `max_received_email_message_bytes` | Bytes in one incoming message. |
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

| Interface | Read limits |
| --- | --- |
| REST | `GET /v1/account/limits`; optional `account_id` query selects a granted account. |
| MCP | `account_get` with `include_limits: true`. |
| CLI | `revdoku account limits`; optional `--account-id ID`. |

## Storing files inside a bucket

A bucket can also store uploaded files. Received emails and their attachments are
stored as files inside its `_email/` folder.

| Task | Endpoint | Purpose |
| --- | --- | --- |
| Upload a file | [Direct upload workflow](#upload-a-file) | Store documents, data, code or binary files. |
| Read by path | `GET /v1/buckets/:id/files/by_path` | Read a file without looking up its ID first. |
| Append text | `POST /v1/buckets/:id/files/append_text` | Append UTF-8 text to a file. |
| List versions | `GET /v1/buckets/:id/versions` | Inspect retained bucket history. |
| Restore a version | `POST /v1/buckets/:id/versions/restore` | Create a new latest version from a retained snapshot. |

- Files retain their paths and formats. Storage and version limits apply.
- For concurrent edits, supply `expected_bucket_revision_id`; reread and reconcile if the version has changed.
- Text append does not parse or merge CSV/JSON for you.
- Share `dashboard_url` with authorized members. The link itself does not grant access.
- Bucket readers can read both uploaded files and stored emails.

## Received email operations

Listing, reading, status updates and downloads require bucket **read** access and share the same permissions
as stored files. Messages have stable `eml_` IDs; attachments have `df_` IDs.
Renames retain message IDs, while copies receive new IDs. Use the email endpoints below for normal mail workflows. You do not need to parse the underlying files.

| Method | Path | Result |
| --- | --- | --- |
| GET | `/v1/buckets/:bucket_id/emails` | `data.emails` and `data.pagination` |
| GET | `/v1/buckets/:bucket_id/emails/:email_id` | `data.email`, including `body_text`, `body_status`, `attachments` |
| PATCH | `/v1/buckets/:bucket_id/emails/:email_id` | Accepts `{"read":true}` or `{"read":false}`; returns `data.email` |
| DELETE | `/v1/buckets/:bucket_id/emails/:email_id` | Requires bucket **admin** access. Deletes this email and its owned files/attachments; returns 204. |
| GET | `/v1/buckets/:bucket_id/emails/:email_id/raw` | `data.download` for the original EML |
| GET | `/v1/buckets/:bucket_id/emails/:email_id/attachments/:attachment_id` | `data.download` for a saved attachment belonging to this email |

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

High-security/HIPAA accounts support listing and content reads, but sender, subject
and conversation searches return `CONTENT_SEARCH_DISABLED`.

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
| `read` | List and detail | Shared read/unread state. |
| `read_at` | List and detail | Time the message was marked read. |
| `read_by` | List and detail | Person who marked it read, when known. |
| `read_by_api_key` | List and detail | API connection that marked it read, when applicable. |
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
GET /v1/buckets/bkt_example/emails?cursor=OPAQUE_CURSOR&limit=50
Authorization: Bearer YOUR_API_KEY
```

Replace `OPAQUE_CURSOR` with the previous response's `pagination.next_cursor`.
Treat it as an opaque string: URL-encode it; do not construct or decode it.

- Keep the account, bucket, order and filters unchanged when reusing a cursor.
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

- Standard files use S3-compatible signed storage links.
- Protected files use signed API links that check access and decrypt the file. Responses use `Cache-Control: no-store` and are bounded to 41 MiB including encryption overhead.
- Bodies and attachments remain stored files; the original EML is available if decoded text is incomplete.

### Delete a message

| Request | Effect |
| --- | --- |
| `DELETE /v1/buckets/:bucket_id/emails/:email_id` | Deletes the email and its owned message files and attachments together. Requires bucket-admin permission. |
| `DELETE /v1/buckets/:bucket_id/files/:file_id` | Deletes an individual stored file. |

Successful deletion returns `204 No Content`. Repeating it returns `404`.
Separately copied files remain independent.

### Email errors

| HTTP status | Code or condition | Next step |
| --- | --- | --- |
| 401 | Unauthenticated | Supply a valid credential. |
| 403 | Access denied | Check the credential's bucket permissions. |
| 403 | `CONTENT_SEARCH_DISABLED` | Remove content-search filters for this protected account. |
| 404 | Email or attachment absent | Check the bucket and resource IDs. |
| 409 | `EMAIL_CHANGED` | Read the current email state before retrying. |
| 422 | `INVALID_EMAIL_ARGUMENT`, `INVALID_EMAIL_CURSOR` | Correct the arguments or start with a fresh cursor. |
| 429 | Rate limit | Wait as directed by `Retry-After`. |
| 503 | `EMAIL_INDEX_BUILDING` | The initial index is being prepared. Retry after the returned five-second delay. |
| 503 | `EMAIL_READ_STATUS_UNAVAILABLE` | The read-status change was not saved. Retry later. |

## Incoming email into a bucket

The dashboard shows **Mailbox / Raw Files** tabs when email files
are present. These are views of the same authorized files. List / Tiles stays inside
Raw Files; the Mailbox badge counts unread messages, not attachments. Clients use
the email resource below; original files remain accessible through the file API.

Each bucket has its own incoming email address for receiving messages and
attachments alongside uploaded files. Anyone knowing the address can email it;
reading messages requires authorized bucket access. Use only the returned address;
choose a username when creating the bucket, or connect your own custom domain.

| Operation | REST / MCP |
| --- | --- |
| Create an inbox | `POST /v1/buckets` / `bucket_create`; creation automatically returns `bucket.email` with address and receiving state. Template/copy creation assigns a separate address. |
| Get address/state | `GET /v1/buckets/:id/email`, or bucket detail / `bucket_get` with `include_email=true`; requires upload/write access. |
| Check for new mail | `GET /v1/buckets/:id/emails` / `bucket_email_list`; save `pagination.next_cursor`. |
| Read a message | `GET /v1/buckets/:id/emails/:email_id` / `bucket_email_get`. |
| Rotate address | `POST /v1/buckets/:id/email/rotate`; requires write access and explicit confirmation. |

For CLI use, `revdoku inbox --bucket-id ID` retrieves address/state, and
`revdoku emails --bucket-id ID` lists messages; `revdoku email EMAIL_ID --bucket-id ID` reads one. For hosted agents,
see the [MCP mailbox walkthrough](https://github.com/revdoku/revdoku/blob/main/mcp.md).

### Receiving state

`POST /v1/buckets` waits for receiving confirmation before returning success.
Inspect an existing mailbox with `GET /v1/buckets/:id/email`.

| Field | Meaning |
| --- | --- |
| `address` | Full email address; use it exactly as returned. |
| `username` | The part before `@`. |
| `receiving_enabled` | Whether this mailbox can currently receive email. |
| `sending_enabled` | Always `false`; sending is not implemented. |
| `blocked_reason` | Why receiving is unavailable. Omitted when receiving is enabled. |

A mailbox may stop receiving if its quota is exhausted or receiving is paused.
Saved messages remain readable. Limits are available separately at
[`GET /v1/account/limits`](#account-limits).

### Activity fields

These fields are also available on ordinary bucket reads.

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
| `confirm` | Yes; `true` | Confirm retiring the current address. |
| `current_address` | Yes | Address returned by the latest mailbox settings request. |
| `domain` | No | Keep the current domain, select a ready custom domain, or use `platform`. |

- Check `max_email_address_rotations_per_month` in [account limits](#account-limits). Initial inbox creation does not use it.
- After a lost response, reread the address before requesting another change.
- Update third-party account/recovery settings before retiring an address.
- Retired addresses stop receiving. Platform names remain permanently reserved.

| Status | Error code | Meaning |
| --- | --- | --- |
| 409 | `EMAIL_ADDRESS_CHANGED` | The supplied current address is stale. |
| 409 | `EMAIL_ROTATION_UNAVAILABLE` | This mailbox cannot rotate its address. |
| 429 | `EMAIL_ROTATION_LIMIT` | The shared rotation allowance is exhausted or unavailable. |

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

Account owners and administrators with bucket-admin permission can read the policy
through `GET /v1/buckets/:id/email` and replace it with the request below.

```http
PATCH /v1/buckets/bkt_example/email/allowlist
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
- The policy stays encrypted and is omitted from ordinary bucket reads.

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

Connect a domain in **Account Settings → Domains → Email**, or use these endpoints
with an account-administrator credential.

| Method | Path | Purpose |
| --- | --- | --- |
| GET | `/v1/account/email_domains` | List account email domains. |
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

- Use an unused subdomain such as `inbox.example.com` if the parent already handles email.
- DNS ownership instructions are visible only to full-account administrators.
- Unverified claims expire after seven days.
- Conflicting MX/CNAME records must be resolved; replace a null MX instead of combining records.
- Cookie-authenticated writes require CSRF protection.

#### Use a connected domain

Connecting a domain preserves existing addresses. Select it when creating an inbox,
or use the address replacement endpoint for an existing inbox.

| Replacement field | Purpose |
| --- | --- |
| `domain` | Exact ready domain, such as `mail.example.com`; use `platform` for the platform domain. |
| `username` | Optional custom-domain name, such as `my-agent`. Omit for a generated name. |
| `current_address` | Current address being replaced. |
| `confirm` | Must be `true`. |

Custom names require account-administrator access and deployment support.
[Username rules](#username-rules) also apply. Rotations on platform domains generate a name.

| Replacement result | Behavior |
| --- | --- |
| `202`, assignment `pending` | Setup is running. Read the mailbox settings to check progress. The old address remains current. |
| Assignment `active` | The returned address is ready; one rotation is charged. |
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

- Custom-domain names remain reserved to their original account. That account may reuse a released name; archived inboxes retain their addresses.
- Platform addresses cannot be reused, even after deletion.
- A downgrade preserves assigned addresses but can block new domain setup or switching.
- Switch to a platform address before moving a bucket to another account. Copies get fresh platform addresses.
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
| `GET /v1/status` | Current account and connection summary. | Authenticated connection, including bucket-scoped keys. |
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
X-Revdoku-Agent-Project: support-inbox
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
| Read or write text files | `bucket_file_read` and `bucket_file_write`. |
| Upload local files, folders or binary files | CLI, or REST direct uploads. |
| Read files by path | `GET /v1/buckets/:id/files/by_path`. |
| List files | `bucket_file_list`, or `revdoku files`. |

Hosted MCP cannot access your local filesystem. Uploads enforce file-type and
content rules. Bucket responses provide authorized action metadata so tools can
handle resource IDs without asking people to type them.

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
  "bucket_access": "all"
}
```

Store the returned `data.api_key` securely. Follow `data.guidance` when the
server includes it. This fallback belongs in a private interactive client UI,
not an AI chat: never ask the user to paste or repeat the verification code in
chat. Do not print or log the key.

### Direct API signup

Use this flow to create an account from your application. Existing users sign in
through the browser. No API key is required for these three endpoints.

#### 1. Request a code

The human operator must provide their email and authorize the acknowledgments.
The server records the current policy versions; your client does not send a version.

| Field | Required | Purpose |
| --- | --- | --- |
| `human_operator_email` | Yes | The human owner's email, supplied by that person. Do not substitute an agent's mailbox. |
| `accept_terms` | Yes; `true` | Human agrees to the [Terms](https://revdoku.com/terms) and [acceptable use policy](https://revdoku.com/acceptable-use). |
| `acknowledge_privacy_policy` | Yes; `true` | Human acknowledges the [privacy notice](https://revdoku.com/privacy). This is not consent to optional processing. |
| `username` | No | Requested first mailbox username; generated if omitted. |
| `permission_scope` | No | `bucket_read`, `bucket_write`, or `bucket_admin` (default). |
| `label` | No | A name for the API connection. |

```http
POST /v1/agent/signups
Content-Type: application/json

{
  "human_operator_email": "owner@customer.example",
  "accept_terms": true,
  "acknowledge_privacy_policy": true
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

#### 2. Verify the code

Collect the code in your private application interface. Do not put the token or
code in URLs, logs, command-line arguments, or AI chat.

```http
POST /v1/agent/signups/verify
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
    "scope": "bucket_admin",
    "expires_at": "2027-09-30T12:00:00Z",
    "account": {
      "id": "acct_RETURNED_ID"
    },
    "bucket": {
      "id": "bkt_RETURNED_ID",
      "title": "flaky.forest3v8x2p",
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
and a `blocked_reason`. Check that mailbox before sending; do not create another account.

| Result | Next step |
| --- | --- |
| `api_key` returned | Store it privately now; it is returned once. Use it as the bearer token. |
| Username error | Resubmit verification with the same token and a corrected `username`; no new code is needed after successful proof. |
| `SIGN_IN_REQUIRED` | The human already has an account. Use browser sign-in. |
| HTTP `200` with completed IDs but no key | This signup already completed. Sign in and manage API keys under Account → Access. |
| `INVALID_SIGNUP_TOKEN` | The token is invalid or expired. Start again with the human's authorization. |

#### Resend a code

Wait the returned `resend_after` seconds, then:

```http
POST /v1/agent/signups/resend
Content-Type: application/json

{
  "signup_token": "RETURNED_SIGNUP_TOKEN"
}
```

HTTP `200 OK` returns the same signup structure with the remaining timers. The
previous code stops working. Resending does not extend the expiry or reset attempts.

#### Signup limits

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

### Create a Bucket

See the [first inbox example](#1-create-an-inbox). To generate a username,
send `{"bucket": {}}`.

#### Optional creation fields

| Field | Default | Purpose |
| --- | --- | --- |
| `bucket.email.username` | Generated name, such as `flaky.forest3v8x2p` | Choose the name before `@`. Available on all plans. |
| `bucket.email.domain` | Platform domain | Use a ready custom email domain owned by this account. |
| `bucket.title` | Assigned username | Set a display title; it can be changed later. |
| `bucket.description` | Empty | Add a bucket description. |
| `bucket.tag_paths` | None | Apply user-chosen organizational labels. |
| `bucket.metadata` | Empty object | Store your application's project/task metadata. |
| `account_id` | Credential default | Select another granted account. |

#### Username rules

| Rule | Behavior |
| --- | --- |
| Characters | ASCII letters, digits, dots, hyphens and underscores. Uppercase is normalized to lowercase. |
| Omitted username | Generate a name. |
| Empty or `null` username | `422 EMAIL_NAME_INVALID`. |
| Reserved platform name, such as `support`, `abuse`, `sale`, `sales` or `contact` | `422 EMAIL_NAME_RESERVED`. Role names are allowed on your own custom domain. |
| Occupied or retired platform address | `409 EMAIL_ALREADY_EXISTS`. Deletion and rotation do not release platform names. |

#### Creation result

- Success means the receiving address has been confirmed; no readiness polling is required.
- If confirmation cannot finish within 25 seconds, the API returns `503 EMAIL_NOT_READY` with the created `bucket_id` in `error.details`. Check that bucket before creating another.
- The same error reports receiving holds through `error.details.blocked_reason`.
- `dashboard_url` opens the bucket for authorized people; it does not grant access.
- Browser signup already creates one starter mailbox.

### Upload a File

Upload a file in three steps:

1. Ask Revdoku for an upload URL.
2. Send the file bytes to that URL with `PUT`.
3. Tell Revdoku to save the uploaded file in your bucket.

For runnable code that calculates the checksums, see the
[JavaScript](https://github.com/revdoku/revdoku/blob/main/examples/javascript/upload-file.js),
[TypeScript](https://github.com/revdoku/revdoku/blob/main/examples/typescript/upload-file.ts), or
[Python](https://github.com/revdoku/revdoku/blob/main/examples/python/upload-file.py) example.

```http
POST /v1/direct_uploads
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "bucket_id": "bkt_...",
  "path": "index.html",
  "blob": {
    "filename": "index.html",
    "byte_size": 1234,
    "checksum": "BASE64_MD5",
    "content_type": "text/html",
    "sha256": "HEX_SHA256",
    "purpose": "bucket_file"
  }
}
```

| Request field | Purpose |
| --- | --- |
| `bucket_id` | Destination bucket ID. |
| `path` | Destination path inside the bucket. |
| `blob.filename` | Original filename. |
| `blob.byte_size` | Number of bytes in the file. |
| `blob.checksum` | Base64-encoded MD5 checksum required by the storage upload. |
| `blob.content_type` | MIME type, such as `text/plain`. |
| `blob.sha256` | SHA-256 checksum as hexadecimal text, used to verify file integrity. |
| `blob.purpose` | Use `bucket_file`. |

| Upload response field | Purpose |
| --- | --- |
| `data.signed_id` | Blob identifier to attach to the bucket after uploading. |
| `data.direct_upload.url` | Object-storage URL for the `PUT` request. |
| `data.direct_upload.headers` | Exact headers to send with the uploaded bytes. |

Upload the bytes without a Revdoku authorization header, then attach the blob:

```http
POST /v1/buckets/bkt_.../files
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "path": "index.html",
  "signed_blob_id": "<data.signed_id from direct_uploads>"
}
```

Uploading the same `path` creates a new version of that file.

### Upload Multiple Files

Use the CLI for a local folder: `revdoku upload ./folder --bucket-id ID`.
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
POST /v1/buckets/bkt_.../upload_sessions
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "delete_missing": true,
  "expected_file_count": 123
}
```

Then request descriptors for one subbatch:

```http
POST /v1/buckets/bkt_.../upload_sessions/bus_.../uploads
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
POST /v1/buckets/bkt_.../upload_sessions/bus_.../finalize_batch
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
POST /v1/buckets/bkt_.../upload_sessions/bus_.../finalize
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

## API Reference

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
The browser approval screen defaults to `bucket_admin` so agents can manage files and buckets. Users can reduce a connection later in
Account → Access. OAuth approval and API-key creation flows can still
request a narrower scope up front.

#### Permission scopes

| Scope | Meaning |
| --- | --- |
| `bucket_read` | List and read allowed bucket files only. |
| `bucket_write` | Create and update allowed bucket files. |
| `bucket_admin` | Create, update, and manage allowed buckets. |

| Input | Purpose |
| --- | --- |
| `permission_scope` | Choose one of the permissions above; bound to consent. |
| OAuth `scope` | Protocol scope: `revdoku:mcp`, optionally `offline_access`. |
| Email-code `scope` | Legacy alias for `permission_scope` on email-code key creation only. |

Omitted permission defaults to `bucket_admin` for agent connections and named
API-key setup. Invalid values are rejected.

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
  "permission_scope": "bucket_admin",
  "bucket_access": "all"
}
```

For selected-bucket access, use:

```json
{
  "bucket_access": "selected",
  "bucket_ids": [
    "bkt_..."
  ],
  "bucket_permissions": {
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
| `/buckets` | Bucket dashboard. |
| `/account/access` | Members, agents, and API keys. |

### Bucket Endpoints

All files that make up a bucket remain downloadable from
Revdoku at any time.

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/v1/buckets` | List active buckets by default. Use `?archived=true` to list archived buckets. |
| `POST` | `/v1/buckets` | Create a bucket. |
| `GET` | `/v1/buckets/:id` | Read a bucket. |
| `PATCH` | `/v1/buckets/:id` | Update bucket metadata. |
| `POST` | `/v1/buckets/:id/archive` | Archive a bucket. |
| `POST` | `/v1/buckets/:id/unarchive` | Restore an archived normal bucket. |
| `GET` | `/v1/buckets/:id/variables` | Read public variables and secret names (never secret values). |
| `PATCH` | `/v1/buckets/:id/variables` | Replace variables and patch encrypted secrets. |
| `GET` | `/v1/buckets/:id/versions` | List bucket version history. |
| `GET` | `/v1/buckets/:id/versions/:version_id` | Read one historical bucket version. |
| `POST` | `/v1/buckets/:id/versions/restore` | Restore a historical version as a new latest version. |
| `DELETE` | `/v1/buckets/:id` | Permanently delete an archived bucket with confirmation. |
| `GET` | `/v1/tags` | List reusable bucket labels. |

#### GET /v1/buckets

```http
GET /v1/buckets
Authorization: Bearer YOUR_API_KEY
```

By default, this returns active buckets. To list archived buckets, call:

```http
GET /v1/buckets?archived=true
Authorization: Bearer YOUR_API_KEY
```

Bucket list/detail responses include effective lifecycle action metadata:

| Field | Meaning |
| --- | --- |
| `archive.allowed` | Whether the current principal can archive now. |
| `unarchive.allowed` | Whether the current principal can restore an archived bucket now. |
| `delete.allowed` | Whether the current principal can permanently delete now. |
| `delete.confirmation` | Confirmation phrase returned by the API; clients should pass it exactly to DELETE after human confirmation, not ask users to type bucket ids. |

Archived buckets are read-only until unarchived. Metadata edits, label changes,
file changes, uploads and duplication return `BUCKET_ARCHIVED`. Reads, unarchive,
and eligible permanent deletion remain available. Copying files out is allowed
with source read access and write access to an active target.

#### POST /v1/buckets

Bucket tags are user-facing labels, not filesystem breadcrumbs. Use
`tag_paths` only for explicit reusable labels such as `project`; store project,
source, task, or local-folder context in `metadata`.

```json
{
  "bucket": {
    "title": "Project files and inbox",
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

#### PATCH /v1/buckets/:id

```json
{
  "bucket": {
    "description": "Updated purpose",
    "metadata": {
      "run": "revision-2"
    }
  }
}
```

#### Bucket locks

Use a bucket lock for broad folder uploads, folder reorganizations, or coordinated
multi-file edits. Use file locks for narrow edits to specific paths.

```http
POST /v1/buckets/bkt_.../lock
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "message": "Uploading project folder",
  "duration_seconds": 900
}
```

```http
DELETE /v1/buckets/bkt_.../lock
Authorization: Bearer YOUR_API_KEY
```

Active bucket locks block writes, deletes, direct uploads,
and file locks by other API keys. Revdoku checks the bucket lock before checking
specific file locks. Conflicts return HTTP `423` with code `BUCKET_LOCKED`.

To lock selected paths, use `POST /v1/buckets/:id/files/lock`.

| Request field | Purpose |
| --- | --- |
| `paths` | File paths to lock. |
| `message` | Explanation shown to other writers. |
| `duration_seconds` | Optional lock duration. |

Resolve a file's ID to unlock it with `DELETE /v1/buckets/:id/files/:file_id/lock`.

#### File path operations

Move and organize existing files server-side; do not download and re-upload bytes.

| Method | Path | Purpose |
| --- | --- | --- |
| `GET` | `/v1/buckets/:id/files` | List files; supports `limit`, `offset`, `q`, `folder`, for ordinary files. Default/maximum page size is 100. |
| `GET` | `/v1/buckets/:id/files/:file_id` | Read file metadata. |
| `GET` | `/v1/buckets/:id/files/by_path?path=...` | Read/download a file by bucket-relative path. |
| `POST` | `/v1/buckets/:id/files/:file_id/rename` | Rename or move within the same bucket without reuploading. |
| `POST` | `/v1/buckets/:id/files/:file_id/copy` | Copy by blob reference, optionally across buckets. |
| `POST` | `/v1/buckets/:id/files/:file_id/move` | Move by blob reference, optionally across buckets. |
| `POST` | `/v1/buckets/:id/files/reorganize` | Apply multiple rename/copy/move/delete path operations atomically. |
| `POST` | `/v1/buckets/:id/files/append_text` | Append bounded UTF-8 text to an existing text file. |

#### Download a file by path

| Query parameter | Required | Meaning |
| --- | --- | --- |
| `path` | Yes | Bucket-relative file path, such as `reports/summary.txt`. |
| `content_url` | No | Set to `1` to receive JSON with a temporary download URL in `data.url`. Without it, the endpoint returns an HTTP 302 download redirect. |

```http
GET /v1/buckets/bkt_example/files/by_path?path=reports/summary.txt&content_url=1
```

Download from the returned URL without forwarding your Revdoku API key.
Use `GET /v1/buckets/:id/files/:file_id` when you only need file metadata.

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

#### Bucket version history

`GET /v1/buckets/:id/versions` lists immutable bucket versions. Read one
with `GET /v1/buckets/:id/versions/:version_id`. Restoring does not delete
newer history; it creates a new latest version from the selected snapshot:

```json
{
  "version_id": "bktrv_...",
  "reason": "Restore the approved client version"
}
```

Send that body to `POST /v1/buckets/:id/versions/restore`.

#### Archive, unarchive, and permanent delete

Honor `archive` and `delete` eligibility in bucket responses. If an operation
is blocked, direct the user to the bucket dashboard to resolve it. Never delete
files to work around a blocked archive. Permanent deletion requires archiving first.

```http
POST /v1/buckets/bkt_.../archive
Authorization: Bearer YOUR_API_KEY
```

```http
POST /v1/buckets/bkt_.../unarchive
Authorization: Bearer YOUR_API_KEY
```

Permanent delete requires an archived bucket plus the confirmation phrase
returned by `GET /v1/buckets` or `GET /v1/buckets/:id` in
`delete.confirmation`.

```http
DELETE /v1/buckets/bkt_...
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "confirmation": "<delete.confirmation from bucket list/detail>"
}
```

UI and agent clients should ask users to confirm by bucket title or natural
language, then pass `delete.confirmation` internally.

Permanent deletion is **not** a bulk operation. Buckets must be
deleted one at a time via `DELETE /v1/buckets/:id` so each removal is
confirmed individually. The `POST /v1/buckets/bulk` endpoint accepts
only `archive` and `unarchive` operations and rejects `delete`.

Large bucket deletion runs in the background.

| Response field | Meaning |
| --- | --- |
| HTTP `202` | Deletion was accepted. |
| `data.bucket.deletion_started` | Deletion has started. |
| `data.delete_progress` | Current deletion progress. |
| `lock.kind` | `bucket_delete` while deletion holds the bucket lock. |
| `phase` | Current deletion phase. |
| `total_files` | Files involved. |
| `total_versions` | Versions involved. |
| `total_items` | Total items involved. |

Poll bucket detail until it disappears or a notification reports completion.
A failed deletion releases the lock and sends a failure notification.

## Common Errors

When `account.restriction` reports a suspension, relay the returned notice and
support guidance. Stored files remain downloadable. Do not infer reasons or evade
the restriction.

### Rate Limits

Upload-control endpoints such as direct-upload creation and bucket upload
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
| `409` | `DATABASE_BUSY_RETRY` | Related bucket changes are still committing; retry after the advertised delay. |
| `409` | `BUCKET_FILE_PATH_INDEX_BACKFILL_PENDING` | Existing bucket file path lookup keys are being prepared; retry after the advertised delay. |
| `429` | `RATE_LIMIT_EXCEEDED` | General account API rate limit exceeded. |
| `429` | `UPLOAD_RATE_LIMIT_EXCEEDED` | Upload-control API rate limit exceeded. |
| `429` | `BUCKET_CREATION_LIMIT_REACHED` | Monthly creation capacity exhausted; stop and report `error.details.resets_at`. |

Monthly creations have a separate allowance from active buckets and address
rotations. Deleting or archiving a bucket does not refund a creation.

A full-account profile returns `plan_contract.bucket_creation_usage`:

| Field | Meaning |
| --- | --- |
| `used` | Creations used this month. |
| `remaining` | Creations left. |
| `monthly_limit` | Shared billing-group allowance. |
| `resets_at` | UTC calendar-month reset time. |

A quota error is not a short-lived throttle. Do not retry automatically until reset.

### Authentication Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `401` | `UNAUTHORIZED` | Missing, invalid, or expired API key. |
| `403` | `FORBIDDEN` | API key is valid but not allowed for this action. |

### Bucket and File Errors

| HTTP | Code | Meaning |
| --- | --- | --- |
| `404` | `BUCKET_NOT_FOUND` | Bucket does not exist or is not visible to this key. |
| `404` | `FILE_NOT_FOUND` | File does not exist or is not visible to this key. |
| `403` | `BUCKET_DELETE_ADMIN_REQUIRED` | Only an account administrator can permanently delete this bucket, except for empty cleanup buckets created by the same user. |
| `409` | `BUCKET_ALREADY_ARCHIVED` | Bucket is already archived. |
| `409` | `BUCKET_NOT_ARCHIVED` | The operation requires an archived bucket; archive before permanent delete, or only unarchive an archived bucket. |
| `422` | `BUCKET_DELETE_CONFIRMATION_REQUIRED` | Pass the `delete.confirmation` value returned by bucket list/detail with the delete request. |
| `403` | `BUCKET_ARCHIVED` | Bucket is archived and cannot be edited until it is unarchived. |
| `404` | `BUCKET_FILE_NOT_FOUND` | Bucket file path does not exist. |
| `422` | `UNSUPPORTED_TEXT_APPEND_TYPE` | `append_text` was used on a non-text file. |
| `422` | `INVALID_TEXT_ENCODING` | `append_text` content or the existing file is not valid UTF-8 text. |
| `423` | `BUCKET_LOCKED` | Another key owns an active bucket lock. |
| `423` | `FILE_LOCKED` | Another key owns an active file lock. |

## Integration Guidelines

### Surface Account Limits Clearly

When a limit is reached, explain the returned reason and direct the user to
Revdoku to review account capacity. Do not remove existing data without explicit
authorization.

### Do Not Leak Secrets

Never print, paste, commit, or log `revdoku_...` API keys or direct-upload URLs.
