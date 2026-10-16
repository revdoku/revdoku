# Mailboxes API reference

Create, read, archive and delete mailboxes.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/mailboxes`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [List mailboxes](#list-mailboxes): `GET /v1/mailboxes`
- [Create a mailbox](#create-a-mailbox): `POST /v1/mailboxes`
- [Read a mailbox](#read-a-mailbox): `GET /v1/mailboxes/{mailbox_id}`
- [Update a mailbox title, description or metadata](#update-a-mailbox-title-description-or-metadata): `PATCH /v1/mailboxes/{mailbox_id}`
- [Permanently delete an archived mailbox](#permanently-delete-an-archived-mailbox): `DELETE /v1/mailboxes/{mailbox_id}`
- [Archive a mailbox](#archive-a-mailbox): `POST /v1/mailboxes/{mailbox_id}/archive`
- [Unarchive a mailbox](#unarchive-a-mailbox): `POST /v1/mailboxes/{mailbox_id}/unarchive`

## List mailboxes

`GET /v1/mailboxes`

Lists active mailboxes by default, newest first. Counts and pages cover only mailboxes this credential can access. Reads no email content.

| Language | Call |
| --- | --- |
| TypeScript | `client.listMailboxes()` |
| Python | `client.list_mailboxes()` |
| TypeScript, full API | `client.api.listMailboxes()` |
| Python, full API | `client.api.list_mailboxes()` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |
| `status` | string: `active`, `archived`, `all` | no |  |
| `q` | string | no | Case-insensitive text in the mailbox ID, or in the title or address when the key can see the address. |
| `limit` | integer | no |  |
| `cursor` | string | no | pagination.next_cursor from the previous page. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.listMailboxes();
for (const mailbox of data.mailboxes) {
  console.log(mailbox.id, mailbox.title, mailbox.email?.address);
}
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.list_mailboxes()
for mailbox in response.data.mailboxes:
    print(mailbox.id, mailbox.title, mailbox.email.address if mailbox.email else None)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `mailboxes` | array of Mailbox |  |
| `mailboxes[].id` | string |  |
| `mailboxes[].account_id` / `accountId` | string |  |
| `mailboxes[].title` | string or null | Mailbox title chosen by people. Defaults to the email username given at creation. Null when unset or when the caller cannot see email.address. |
| `mailboxes[].description` | string or null |  |
| `mailboxes[].metadata` | object | Your application data. PATCH replaces the whole object. |
| `mailboxes[].metadata_version` / `metadataVersion` | string | Send as expected_metadata_version on PATCH. Changes only when description or metadata changes. |
| `mailboxes[].email` | MailboxEmail | Receiving and sending state of a mailbox. Counts read the email index without reading content. Fields: `address`, `message_count`, `unread_count`, `last_received_at`, `receiving_enabled`, `blocked_reason`, `sending_enabled`, `sending_blocked_reason`. |
| `mailboxes[].archived` | boolean |  |
| `mailboxes[].archived_at` / `archivedAt` | string (date-time) or null |  |
| `mailboxes[].lock` | MailboxLock | Fields: `locked`, `locked_until`, `kind`, `message`, `progress`, `locked_by`, `locked_by_api_key`. |
| `mailboxes[].storage_bytes` / `storageBytes` | integer (int64) |  |
| `mailboxes[].files_count` / `filesCount` | integer (int64) | Current files, including stored emails and attachments. |
| `mailboxes[].version_id` / `versionId` | string or null | Current mailbox file-tree version. Send as expected_mailbox_version on file writes to detect concurrent changes. |
| `mailboxes[].version_number` / `versionNumber` | integer |  |
| `mailboxes[].created_at` / `createdAt` | string (date-time) or null |  |
| `mailboxes[].updated_at` / `updatedAt` | string (date-time) or null |  |
| `mailboxes[].dashboard_url` / `dashboardUrl` | string (uri) | Opens the mailbox for signed-in members. It does not grant access. |
| `mailboxes[].archive` | MailboxAction | Fields: `allowed`, `blocked_reason`, `required_action`, `confirmation`. |
| `mailboxes[].unarchive` | MailboxAction | Fields: `allowed`, `blocked_reason`, `required_action`, `confirmation`. |
| `mailboxes[].delete` / `_delete` | MailboxAction | Fields: `allowed`, `blocked_reason`, `required_action`, `confirmation`. |
| `counts` | MailboxCounts | Exact authorized mailbox totals after query filtering, before status filtering and pagination. |
| `counts.active` | integer (int64) |  |
| `counts.archived` | integer (int64) |  |
| `counts.total` | integer (int64) |  |
| `pagination` | Pagination | One page of a list. Request the next page with cursor=next_cursor and the same filters. Cursors are opaque strings: do not build or decode them. |
| `pagination.limit` | integer |  |
| `pagination.has_more` / `hasMore` | boolean | True when another page exists. |
| `pagination.next_cursor` / `nextCursor` | string or null | Cursor for the next page; null on the last page. Email lists always return a cursor so that you can poll for new mail. |

```json
{
  "success": true,
  "data": {
    "mailboxes": [
      {
        "id": "bkt_example",
        "account_id": "acct_example",
        "title": "acme-orders",
        "description": null,
        "metadata": {},
        "metadata_version": "44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a",
        "email": {
          "address": "acme.orders.k7m2@revdokumail.com",
          "message_count": 1,
          "unread_count": 1,
          "last_received_at": "2026-10-11T12:05:00.000000Z",
          "receiving_enabled": true,
          "sending_enabled": true
        },
        "archived": false,
        "archived_at": null,
        "lock": {"locked": false},
        "storage_bytes": 51840,
        "files_count": 3,
        "version_id": "bktrv_example",
        "version_number": 0,
        "created_at": "2026-10-11T12:00:00.000000Z",
        "updated_at": "2026-10-11T12:05:00.000000Z",
        "dashboard_url": "https://app.revdoku.com/mailboxes/view?account_id=acct_example&id=bkt_example",
        "archive": {"allowed": true},
        "unarchive": {"allowed": false, "blocked_reason": "not_archived"},
        "delete": {
          "allowed": false,
          "blocked_reason": "not_archived",
          "required_action": "archive_first",
          "confirmation": "delete bkt_example"
        }
      }
    ],
    "counts": {"active": 1, "archived": 0, "total": 1},
    "pagination": {"limit": 50, "has_more": false, "next_cursor": null}
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Mailboxes](https://revdoku.com/api.md#mailboxes)

## Create a mailbox

`POST /v1/mailboxes`

Waits until the address can receive email. On revdokumail.com, email.username is a prefix with a permanent 4-character random suffix on every plan; a custom domain takes the exact name. If confirmation does not finish, EMAIL_NOT_READY returns the created mailbox_id in error.details: read that mailbox instead of creating another. The title defaults to email.username; a title that another active mailbox uses returns 409 MAILBOX_TITLE_TAKEN. Never retry a creation automatically.

| Language | Call |
| --- | --- |
| TypeScript | `client.createMailbox({ username, domain, title })` |
| Python | `client.create_mailbox(username=..., domain=..., title=...)` |
| TypeScript, full API | `client.api.createMailbox({ createMailboxRequest })` |
| Python, full API | `client.api.create_mailbox(create_mailbox_request)` |

**Request body**: TypeScript `createMailboxRequest: CreateMailboxRequest`, Python `create_mailbox_request=CreateMailboxRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox` | MailboxCreate | no |  |
| `mailbox.title` | string | no | Optional title. Defaults to email.username as given, or to the generated name without its random suffix. A title that another active mailbox uses returns 409 MAILBOX_TITLE_TAKEN. |
| `mailbox.description` | string | no |  |
| `mailbox.metadata` | object | no |  |
| `mailbox.email` | MailboxEmailOptions | no | Fields: `username`, `domain`. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
// Never retry automatically after an uncertain result. List mailboxes first.
const { data } = await client.createMailbox({ username: 'support', title: 'Support' });
console.log(data.mailbox.id, data.mailbox.email?.address);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
# Never retry automatically after an uncertain result. List mailboxes first.
response = client.create_mailbox(username="support", title="Support")
mailbox = response.data.mailbox
print(mailbox.id, mailbox.email.address if mailbox.email else None)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "mailbox": {"title": "Support", "email": {"username": "support"}}
}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox` | Mailbox | A mailbox: one receiving address with private file storage. Label it as title (email.address), or by email.address alone when title is null. Use id in API calls. Fields as in [List mailboxes](#list-mailboxes). |

```json
{
  "success": true,
  "data": {
    "mailbox": {
      "id": "bkt_example",
      "account_id": "acct_example",
      "title": "acme-orders",
      "description": null,
      "metadata": {},
      "metadata_version": "44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a",
      "email": {
        "address": "acme.orders.k7m2@revdokumail.com",
        "message_count": 0,
        "unread_count": 0,
        "last_received_at": null,
        "receiving_enabled": true,
        "sending_enabled": true
      },
      "archived": false,
      "archived_at": null,
      "lock": {"locked": false},
      "storage_bytes": 0,
      "files_count": 0,
      "version_id": "bktrv_example",
      "version_number": 0,
      "created_at": "2026-10-11T12:00:00.000000Z",
      "updated_at": "2026-10-11T12:00:00.000000Z",
      "dashboard_url": "https://app.revdoku.com/mailboxes/view?account_id=acct_example&id=bkt_example",
      "archive": {"allowed": true},
      "unarchive": {"allowed": false, "blocked_reason": "not_archived"},
      "delete": {
        "allowed": false,
        "blocked_reason": "not_archived",
        "required_action": "archive_first",
        "confirmation": "delete bkt_example"
      }
    }
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| `401` | Missing or invalid API key |
| Other 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `EMAIL_NOT_READY`, `MAILBOX_TITLE_TAKEN`.

Guide: [Create a mailbox](https://revdoku.com/api.md#create-a-mailbox)

## Read a mailbox

`GET /v1/mailboxes/{mailbox_id}`

Reading never changes the mailbox. Read address settings, emails and files through their own endpoints.

| Language | Call |
| --- | --- |
| TypeScript | `client.getMailbox({ mailboxId })` |
| Python | `client.get_mailbox(mailbox_id)` |
| TypeScript, full API | `client.api.getMailbox({ mailboxId })` |
| Python, full API | `client.api.get_mailbox(mailbox_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.getMailbox({ mailboxId: 'bkt_example' });
console.log(data.mailbox.title, data.mailbox.email?.address);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.get_mailbox("bkt_example")
mailbox = response.data.mailbox
print(mailbox.title, mailbox.email.address if mailbox.email else None)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes/bkt_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox` | Mailbox | A mailbox: one receiving address with private file storage. Label it as title (email.address), or by email.address alone when title is null. Use id in API calls. Fields as in [List mailboxes](#list-mailboxes). |

```json
{
  "success": true,
  "data": {
    "mailbox": {
      "id": "bkt_example",
      "account_id": "acct_example",
      "title": "acme-orders",
      "description": null,
      "metadata": {},
      "metadata_version": "44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a",
      "email": {
        "address": "acme.orders.k7m2@revdokumail.com",
        "message_count": 1,
        "unread_count": 1,
        "last_received_at": "2026-10-11T12:05:00.000000Z",
        "receiving_enabled": true,
        "sending_enabled": true
      },
      "archived": false,
      "archived_at": null,
      "lock": {"locked": false},
      "storage_bytes": 51840,
      "files_count": 3,
      "version_id": "bktrv_example",
      "version_number": 0,
      "created_at": "2026-10-11T12:00:00.000000Z",
      "updated_at": "2026-10-11T12:05:00.000000Z",
      "dashboard_url": "https://app.revdoku.com/mailboxes/view?account_id=acct_example&id=bkt_example",
      "archive": {"allowed": true},
      "unarchive": {"allowed": false, "blocked_reason": "not_archived"},
      "delete": {
        "allowed": false,
        "blocked_reason": "not_archived",
        "required_action": "archive_first",
        "confirmation": "delete bkt_example"
      }
    }
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Mailboxes](https://revdoku.com/api.md#mailboxes)

## Update a mailbox title, description or metadata

`PATCH /v1/mailboxes/{mailbox_id}`

metadata must be a JSON object. It replaces the stored object; {} clears it. Send expected_metadata_version from your last read; a stale value changes nothing and returns MAILBOX_METADATA_CONFLICT. Titles are unique among active mailboxes; a used title returns 409 MAILBOX_TITLE_TAKEN.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.updateMailbox({ mailboxId, updateMailboxRequest })` |
| Python | `client.api.update_mailbox(mailbox_id, update_mailbox_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `updateMailboxRequest: UpdateMailboxRequest`, Python `update_mailbox_request=UpdateMailboxRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox` | MailboxUpdate | yes |  |
| `mailbox.title` | string or null | no | New title. An empty string or null clears it. A title that another active mailbox uses returns 409 MAILBOX_TITLE_TAKEN. |
| `mailbox.description` | string | no |  |
| `mailbox.metadata` | object | no |  |
| `expected_metadata_version` / `expectedMetadataVersion` | string | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.updateMailbox({
  mailboxId: 'bkt_example',
  updateMailboxRequest: { mailbox: { title: 'Support' } },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, MailboxUpdate, UpdateMailboxRequest

client = Revdoku()
response = client.api.update_mailbox(
    "bkt_example",
    UpdateMailboxRequest(mailbox=MailboxUpdate(title="Support")),
)
print(response.data)
```

**cURL**

```sh
curl -X PATCH "https://api.revdoku.com/v1/mailboxes/bkt_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"mailbox": {"title": "Support"}}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox` | Mailbox | A mailbox: one receiving address with private file storage. Label it as title (email.address), or by email.address alone when title is null. Use id in API calls. Fields as in [List mailboxes](#list-mailboxes). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `MAILBOX_METADATA_CONFLICT`, `MAILBOX_TITLE_TAKEN`.

Guide: [Update a mailbox](https://revdoku.com/api.md#update-a-mailbox)

## Permanently delete an archived mailbox

`DELETE /v1/mailboxes/{mailbox_id}`

Archive the mailbox first. Send delete.confirmation from the mailbox read after the user confirms. Large mailboxes finish deleting in the background.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.deleteMailbox({ mailboxId, deleteMailboxRequest })` |
| Python | `client.api.delete_mailbox(mailbox_id, delete_mailbox_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `deleteMailboxRequest: DeleteMailboxRequest`, Python `delete_mailbox_request=DeleteMailboxRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `confirmation` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.deleteMailbox({
  mailboxId: 'bkt_example',
  deleteMailboxRequest: { confirmation: 'CONFIRMATION_FROM_MAILBOX_READ' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, DeleteMailboxRequest

client = Revdoku()
response = client.api.delete_mailbox(
    "bkt_example",
    DeleteMailboxRequest(confirmation="CONFIRMATION_FROM_MAILBOX_READ"),
)
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/mailboxes/bkt_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"confirmation": "CONFIRMATION_FROM_MAILBOX_READ"}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `deleted` | boolean `true` |  |
| `id` | string | ID of the deleted resource. A webhook delete returns the mailbox ID. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Delete a mailbox](https://revdoku.com/api.md#delete-a-mailbox)

## Archive a mailbox

`POST /v1/mailboxes/{mailbox_id}/archive`

Archived mailboxes keep their files and emails and become read-only.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.archiveMailbox({ mailboxId, actionRequest })` |
| Python | `client.api.archive_mailbox(mailbox_id, action_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `actionRequest: ActionRequest`, Python `action_request=ActionRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.archiveMailbox({
  mailboxId: 'bkt_example',
  actionRequest: {},
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, ActionRequest

client = Revdoku()
response = client.api.archive_mailbox("bkt_example", ActionRequest())
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/archive" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox` | Mailbox | A mailbox: one receiving address with private file storage. Label it as title (email.address), or by email.address alone when title is null. Use id in API calls. Fields as in [List mailboxes](#list-mailboxes). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Mailboxes](https://revdoku.com/api.md#mailboxes)

## Unarchive a mailbox

`POST /v1/mailboxes/{mailbox_id}/unarchive`

Requires mailbox-admin permission.

The mailbox becomes writable again. If another active mailbox has the same title, the title gets a number suffix. A mailbox that is not archived returns MAILBOX_NOT_ARCHIVED.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.unarchiveMailbox({ mailboxId, actionRequest })` |
| Python | `client.api.unarchive_mailbox(mailbox_id, action_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `actionRequest: ActionRequest`, Python `action_request=ActionRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.unarchiveMailbox({
  mailboxId: 'bkt_example',
  actionRequest: {},
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, ActionRequest

client = Revdoku()
response = client.api.unarchive_mailbox("bkt_example", ActionRequest())
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/unarchive" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `mailbox` | Mailbox | A mailbox: one receiving address with private file storage. Label it as title (email.address), or by email.address alone when title is null. Use id in API calls. Fields as in [List mailboxes](#list-mailboxes). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `MAILBOX_NOT_ARCHIVED`.

Guide: [Mailboxes](https://revdoku.com/api.md#mailboxes)
