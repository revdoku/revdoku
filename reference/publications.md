# Publications API reference

A bucket's site: publish its files, preview them for 24 hours, or take the site down.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/buckets`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [Get the site](#get-the-site): `GET /v1/buckets/{bucket_id}/publication`
- [Publish the site](#publish-the-site): `POST /v1/buckets/{bucket_id}/publication`
- [Unpublish the site](#unpublish-the-site): `DELETE /v1/buckets/{bucket_id}/publication`
- [Get the preview](#get-the-preview): `GET /v1/buckets/{bucket_id}/publication/preview`
- [Preview the site](#preview-the-site): `POST /v1/buckets/{bucket_id}/publication/preview`

## Get the site

`GET /v1/buckets/{bucket_id}/publication`

Returns the bucket's site and its build state.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getPublication({ bucketId })` |
| Python | `client.api.get_publication(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getPublication({ bucketId: 'bkt_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_publication("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets/bkt_example/publication" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `publication` | Publication | A bucket's published site, or its 24-hour preview. |
| `publication.id` | string | Publication ID. |
| `publication.url` | string or null | The site address. |
| `publication.preview` | boolean | True for a 24-hour preview. |
| `publication.publish_state` / `publishState` | string: `ready`, `queued`, `processing`, `failed`, `unpublishing` | Build state. A publish runs in the background: poll until ready or failed. |
| `publication.live` | boolean | True while the site serves visitors. |
| `publication.access_mode` / `accessMode` | string: `public`, `password`, `require_email` | Who can open the site. |
| `publication.password_configured` / `passwordConfigured` | boolean | True when a password protects the site. |
| `publication.publish_error` / `publishError` | string or null | Why the last build failed. |
| `publication.expires_at` / `expiresAt` | string (date-time) or null | When a preview stops serving. |
| `publication.created_at` / `createdAt` | string (date-time) |  |
| `publication.updated_at` / `updatedAt` | string (date-time) |  |
| `publication.bucket_id` / `bucketId` | string | The bucket whose files the site publishes. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Sites](https://revdoku.com/api.md#sites)

## Publish the site

`POST /v1/buckets/{bucket_id}/publication`

Publishes the bucket's files as its site, or republishes them. The build runs in the background: get the site until publish_state is ready or failed.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.publishBucket({ bucketId })` |
| Python | `client.api.publish_bucket(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Request body** (optional): TypeScript `publishRequest: PublishRequest`, Python `publish_request=PublishRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `access_mode` / `accessMode` | string: `public`, `password`, `require_email` | no | Who can open the site. Omit to keep the current setting. |
| `password` | string | no | Password for access_mode password, 8 to 128 characters. Omit to generate one. |
| `reason` | string | no | Why you publish, for the activity log. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.publishBucket({ bucketId: 'bkt_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.publish_bucket("bkt_example")
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/buckets/bkt_example/publication" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `202`

| Field | Type | Description |
| --- | --- | --- |
| `publication` | Publication | A bucket's published site, or its 24-hour preview. Fields as in [Get the site](#get-the-site). |
| `plan_notice` / `planNotice` | object | Present when site settings of the bucket stay preview-only on the current plan. |
| `plan_notice.message` | string | What stays preview-only and how to apply it. |
| `plan_notice.required_plan` / `requiredPlan` | string | The plan that applies the settings to the live site. |
| `plan_notice.upgrade_plan_name` / `upgradePlanName` | string | The same plan name, for upgrade buttons. |
| `plan_notice.upgrade_url` / `upgradeUrl` | string (uri) | The pricing page. |
| `plan_notice.preview_available` / `previewAvailable` | boolean | True: a preview shows the settings. |
| `plan_notice.requirements` | array of object | The settings that stay preview-only. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Sites](https://revdoku.com/api.md#sites)

## Unpublish the site

`DELETE /v1/buckets/{bucket_id}/publication`

Takes the site down. The bucket's files stay.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.unpublishBucket({ bucketId })` |
| Python | `client.api.unpublish_bucket(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.unpublishBucket({ bucketId: 'bkt_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.unpublish_bucket("bkt_example")
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/buckets/bkt_example/publication" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `202`

| Field | Type | Description |
| --- | --- | --- |
| `publication` | Publication | A bucket's published site, or its 24-hour preview. Fields as in [Get the site](#get-the-site). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Sites](https://revdoku.com/api.md#sites)

## Get the preview

`GET /v1/buckets/{bucket_id}/publication/preview`

Returns the bucket's latest preview and its build state.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getPublicationPreview({ bucketId })` |
| Python | `client.api.get_publication_preview(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getPublicationPreview({
  bucketId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_publication_preview("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets/bkt_example/publication/preview" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `publication` | Publication | A bucket's published site, or its 24-hour preview. Fields as in [Get the site](#get-the-site). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Sites](https://revdoku.com/api.md#sites)

## Preview the site

`POST /v1/buckets/{bucket_id}/publication/preview`

Publishes the bucket's current files at a separate preview address for 24 hours. The site does not change.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.previewBucket({ bucketId })` |
| Python | `client.api.preview_bucket(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Request body** (optional): TypeScript `publishRequest: PublishRequest`, Python `publish_request=PublishRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `access_mode` / `accessMode` | string: `public`, `password`, `require_email` | no | Who can open the site. Omit to keep the current setting. |
| `password` | string | no | Password for access_mode password, 8 to 128 characters. Omit to generate one. |
| `reason` | string | no | Why you publish, for the activity log. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.previewBucket({ bucketId: 'bkt_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.preview_bucket("bkt_example")
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/buckets/bkt_example/publication/preview" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `202`

| Field | Type | Description |
| --- | --- | --- |
| `publication` | Publication | A bucket's published site, or its 24-hour preview. Fields as in [Get the site](#get-the-site). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Sites](https://revdoku.com/api.md#sites)
