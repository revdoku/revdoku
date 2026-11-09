# Buckets API reference

Create, read, archive and delete buckets.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/buckets`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [List buckets](#list-buckets): `GET /v1/buckets`
- [Create a bucket](#create-a-bucket): `POST /v1/buckets`
- [Read a bucket](#read-a-bucket): `GET /v1/buckets/{bucket_id}`
- [Update a bucket title, description or metadata](#update-a-bucket-title-description-or-metadata): `PATCH /v1/buckets/{bucket_id}`
- [Permanently delete an archived bucket](#permanently-delete-an-archived-bucket): `DELETE /v1/buckets/{bucket_id}`
- [Archive a bucket](#archive-a-bucket): `POST /v1/buckets/{bucket_id}/archive`
- [Unarchive a bucket](#unarchive-a-bucket): `POST /v1/buckets/{bucket_id}/unarchive`

## List buckets

`GET /v1/buckets`

Lists active buckets by default, newest first. Counts and pages cover only buckets this credential can access. Reads no email content.

| Language | Call |
| --- | --- |
| TypeScript | `client.listBuckets()` |
| Python | `client.list_buckets()` |
| TypeScript, full API | `client.api.listBuckets()` |
| Python, full API | `client.api.list_buckets()` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |
| `status` | string: `active`, `archived`, `all` | no |  |
| `q` | string | no | Case-insensitive text in the bucket ID, or in the title or address when the key can see the address. |
| `limit` | integer | no |  |
| `cursor` | string | no | pagination.next_cursor from the previous page. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.listBuckets();
for (const bucket of data.buckets) {
  console.log(bucket.id, bucket.title, bucket.mailbox?.address);
}
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.list_buckets()
for bucket in response.data.buckets:
    print(bucket.id, bucket.title, bucket.mailbox.address if bucket.mailbox else None)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `buckets` | array of Bucket |  |
| `buckets[].id` | string |  |
| `buckets[].account_id` / `accountId` | string |  |
| `buckets[].title` | string or null | Bucket title chosen by people. Defaults to the email username given at creation. Null when unset or when the caller cannot see mailbox.address. |
| `buckets[].description` | string or null |  |
| `buckets[].metadata` | object | Your application data. PATCH replaces the whole object. |
| `buckets[].metadata_version` / `metadataVersion` | string | Send as expected_metadata_version on PATCH. Changes only when description or metadata changes. |
| `buckets[].mailbox` | Mailbox | Receiving and sending state of a bucket's mailbox. Counts read the email index without reading content. Fields: `address`, `message_count`, `unread_count`, `last_received_at`, `receiving_enabled`, `blocked_reason`, `sending_enabled`, `sending_blocked_reason`. |
| `buckets[].archived` | boolean |  |
| `buckets[].archived_at` / `archivedAt` | string (date-time) or null |  |
| `buckets[].lock` | BucketLock | Fields: `locked`, `locked_until`, `kind`, `message`, `progress`, `locked_by`, `locked_by_api_key`. |
| `buckets[].storage_bytes` / `storageBytes` | integer (int64) |  |
| `buckets[].files_count` / `filesCount` | integer (int64) | Current files, including stored emails and attachments. |
| `buckets[].version_id` / `versionId` | string or null | Current bucket file-tree version. Send as expected_bucket_version on file writes to detect concurrent changes. |
| `buckets[].version_number` / `versionNumber` | integer |  |
| `buckets[].created_at` / `createdAt` | string (date-time) or null |  |
| `buckets[].updated_at` / `updatedAt` | string (date-time) or null |  |
| `buckets[].dashboard_url` / `dashboardUrl` | string (uri) | Opens the bucket for signed-in members. It does not grant access. |
| `buckets[].archive` | BucketAction | Fields: `allowed`, `blocked_reason`, `required_action`, `confirmation`. |
| `buckets[].unarchive` | BucketAction | Fields: `allowed`, `blocked_reason`, `required_action`, `confirmation`. |
| `buckets[].delete` / `_delete` | BucketAction | Fields: `allowed`, `blocked_reason`, `required_action`, `confirmation`. |
| `counts` | BucketCounts | Exact authorized bucket totals after query filtering, before status filtering and pagination. |
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
    "buckets": [
      {
        "id": "bkt_example",
        "account_id": "acct_example",
        "title": "acme-orders",
        "description": null,
        "metadata": {},
        "metadata_version": "44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a",
        "mailbox": {
          "address": "acme-orders@revdokumail.com",
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
        "dashboard_url": "https://app.revdoku.com/buckets/view?account_id=acct_example&id=bkt_example",
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

Guide: [Buckets](https://revdoku.com/api.md#buckets)

## Create a bucket

`POST /v1/buckets`

Waits until the address can receive email. On revdokumail.com, mailbox.username is the bucket's name, with no suffix: lowercase letters, digits and single hyphens, 3 to 63 characters, also the name of its site. A name that another bucket uses as an address or a site address, or that another account used, returns EMAIL_ALREADY_EXISTS; your account can use its own earlier names again. Without mailbox.username the address takes the title's name when it is free, else two readable words. A custom domain takes the exact name. If confirmation does not finish, EMAIL_NOT_READY returns the created bucket_id in error.details: read that bucket instead of creating another. The title defaults to mailbox.username; a title that another active bucket uses returns 409 BUCKET_TITLE_TAKEN. Never retry a creation automatically.

| Language | Call |
| --- | --- |
| TypeScript | `client.createBucket({ username, domain, title })` |
| Python | `client.create_bucket(username=..., domain=..., title=...)` |
| TypeScript, full API | `client.api.createBucket({ createBucketRequest })` |
| Python, full API | `client.api.create_bucket(create_bucket_request)` |

**Request body**: TypeScript `createBucketRequest: CreateBucketRequest`, Python `create_bucket_request=CreateBucketRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket` | BucketCreate | no |  |
| `bucket.title` | string | no | Optional title. Defaults to mailbox.username as given, or to the generated name. A title that another active bucket uses returns 409 BUCKET_TITLE_TAKEN. |
| `bucket.description` | string | no |  |
| `bucket.metadata` | object | no |  |
| `bucket.mailbox` | MailboxOptions | no | Fields: `username`, `domain`. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
// Never retry automatically after an uncertain result. List buckets first.
const { data } = await client.createBucket({ username: 'support', title: 'Support' });
console.log(data.bucket.id, data.bucket.mailbox?.address);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
# Never retry automatically after an uncertain result. List buckets first.
response = client.create_bucket(username="support", title="Support")
bucket = response.data.bucket
print(bucket.id, bucket.mailbox.address if bucket.mailbox else None)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/buckets" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "bucket": {"title": "Acme docs", "mailbox": {"username": "acme-docs"}}
}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `bucket` | Bucket | A bucket: private files, a mailbox with its own address, and a site. Label it as title (mailbox.address), or by mailbox.address alone when title is null. Use id in API calls. Fields as in [List buckets](#list-buckets). |

```json
{
  "success": true,
  "data": {
    "bucket": {
      "id": "bkt_example",
      "account_id": "acct_example",
      "title": "acme-orders",
      "description": null,
      "metadata": {},
      "metadata_version": "44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a",
      "mailbox": {
        "address": "acme-orders@revdokumail.com",
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
      "dashboard_url": "https://app.revdoku.com/buckets/view?account_id=acct_example&id=bkt_example",
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

Error codes named above: `BUCKET_TITLE_TAKEN`, `EMAIL_ALREADY_EXISTS`, `EMAIL_NOT_READY`.

Guide: [Create a bucket](https://revdoku.com/api.md#create-a-bucket)

## Read a bucket

`GET /v1/buckets/{bucket_id}`

Reading never changes the bucket. Read address settings, emails and files through their own endpoints.

| Language | Call |
| --- | --- |
| TypeScript | `client.getBucket({ bucketId })` |
| Python | `client.get_bucket(bucket_id)` |
| TypeScript, full API | `client.api.getBucket({ bucketId })` |
| Python, full API | `client.api.get_bucket(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.getBucket({ bucketId: 'bkt_example' });
console.log(data.bucket.title, data.bucket.mailbox?.address);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.get_bucket("bkt_example")
bucket = response.data.bucket
print(bucket.title, bucket.mailbox.address if bucket.mailbox else None)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets/bkt_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `bucket` | Bucket | A bucket: private files, a mailbox with its own address, and a site. Label it as title (mailbox.address), or by mailbox.address alone when title is null. Use id in API calls. Fields as in [List buckets](#list-buckets). |

```json
{
  "success": true,
  "data": {
    "bucket": {
      "id": "bkt_example",
      "account_id": "acct_example",
      "title": "acme-orders",
      "description": null,
      "metadata": {},
      "metadata_version": "44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a",
      "mailbox": {
        "address": "acme-orders@revdokumail.com",
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
      "dashboard_url": "https://app.revdoku.com/buckets/view?account_id=acct_example&id=bkt_example",
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

Guide: [Buckets](https://revdoku.com/api.md#buckets)

## Update a bucket title, description or metadata

`PATCH /v1/buckets/{bucket_id}`

metadata must be a JSON object. It replaces the stored object; {} clears it. Send expected_metadata_version from your last read; a stale value changes nothing and returns BUCKET_METADATA_CONFLICT. Titles are unique among active buckets; a used title returns 409 BUCKET_TITLE_TAKEN.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.updateBucket({ bucketId, updateBucketRequest })` |
| Python | `client.api.update_bucket(bucket_id, update_bucket_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Request body**: TypeScript `updateBucketRequest: UpdateBucketRequest`, Python `update_bucket_request=UpdateBucketRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket` | BucketUpdate | yes |  |
| `bucket.title` | string or null | no | New title. An empty string or null clears it. A title that another active bucket uses returns 409 BUCKET_TITLE_TAKEN. |
| `bucket.description` | string | no |  |
| `bucket.metadata` | object | no |  |
| `expected_metadata_version` / `expectedMetadataVersion` | string | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.updateBucket({
  bucketId: 'bkt_example',
  updateBucketRequest: { bucket: { title: 'Support' } },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, BucketUpdate, UpdateBucketRequest

client = Revdoku()
response = client.api.update_bucket(
    "bkt_example",
    UpdateBucketRequest(bucket=BucketUpdate(title="Support")),
)
print(response.data)
```

**cURL**

```sh
curl -X PATCH "https://api.revdoku.com/v1/buckets/bkt_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"bucket": {"title": "Support"}}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `bucket` | Bucket | A bucket: private files, a mailbox with its own address, and a site. Label it as title (mailbox.address), or by mailbox.address alone when title is null. Use id in API calls. Fields as in [List buckets](#list-buckets). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `BUCKET_METADATA_CONFLICT`, `BUCKET_TITLE_TAKEN`.

Guide: [Update a bucket](https://revdoku.com/api.md#update-a-bucket)

## Permanently delete an archived bucket

`DELETE /v1/buckets/{bucket_id}`

Archive the bucket first. Send delete.confirmation from the bucket read after the user confirms. Large buckets finish deleting in the background.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.deleteBucket({ bucketId, deleteBucketRequest })` |
| Python | `client.api.delete_bucket(bucket_id, delete_bucket_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Request body**: TypeScript `deleteBucketRequest: DeleteBucketRequest`, Python `delete_bucket_request=DeleteBucketRequest(...)`.

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
const { data } = await client.api.deleteBucket({
  bucketId: 'bkt_example',
  deleteBucketRequest: { confirmation: 'CONFIRMATION_FROM_BUCKET_READ' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, DeleteBucketRequest

client = Revdoku()
response = client.api.delete_bucket(
    "bkt_example",
    DeleteBucketRequest(confirmation="CONFIRMATION_FROM_BUCKET_READ"),
)
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/buckets/bkt_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"confirmation": "CONFIRMATION_FROM_BUCKET_READ"}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `deleted` | boolean `true` |  |
| `id` | string | ID of the deleted resource. A webhook delete returns the bucket ID. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Delete a bucket](https://revdoku.com/api.md#delete-a-bucket)

## Archive a bucket

`POST /v1/buckets/{bucket_id}/archive`

Archived buckets keep their files and emails and become read-only.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.archiveBucket({ bucketId, actionRequest })` |
| Python | `client.api.archive_bucket(bucket_id, action_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

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
const { data } = await client.api.archiveBucket({
  bucketId: 'bkt_example',
  actionRequest: {},
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, ActionRequest

client = Revdoku()
response = client.api.archive_bucket("bkt_example", ActionRequest())
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/buckets/bkt_example/archive" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `bucket` | Bucket | A bucket: private files, a mailbox with its own address, and a site. Label it as title (mailbox.address), or by mailbox.address alone when title is null. Use id in API calls. Fields as in [List buckets](#list-buckets). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Buckets](https://revdoku.com/api.md#buckets)

## Unarchive a bucket

`POST /v1/buckets/{bucket_id}/unarchive`

Requires bucket-admin permission.

The bucket becomes writable again. If another active bucket has the same title, the title gets a number suffix. A bucket that is not archived returns BUCKET_NOT_ARCHIVED.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.unarchiveBucket({ bucketId, actionRequest })` |
| Python | `client.api.unarchive_bucket(bucket_id, action_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

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
const { data } = await client.api.unarchiveBucket({
  bucketId: 'bkt_example',
  actionRequest: {},
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, ActionRequest

client = Revdoku()
response = client.api.unarchive_bucket("bkt_example", ActionRequest())
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/buckets/bkt_example/unarchive" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `bucket` | Bucket | A bucket: private files, a mailbox with its own address, and a site. Label it as title (mailbox.address), or by mailbox.address alone when title is null. Use id in API calls. Fields as in [List buckets](#list-buckets). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `BUCKET_NOT_ARCHIVED`.

Guide: [Buckets](https://revdoku.com/api.md#buckets)
