# Events API reference

Ticket events of every channel: one signed webhook per bucket and live WebSocket subscriptions.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/buckets`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [Read the webhook](#read-the-webhook): `GET /v1/buckets/{bucket_id}/webhook`
- [Set the webhook](#set-the-webhook): `PUT /v1/buckets/{bucket_id}/webhook`
- [Remove the webhook](#remove-the-webhook): `DELETE /v1/buckets/{bucket_id}/webhook`
- [Get a live event subscription ticket](#get-a-live-event-subscription-ticket): `GET /v1/buckets/{bucket_id}/events/subscription`

## Read the webhook

`GET /v1/buckets/{bucket_id}/webhook`

Requires bucket-admin permission.

webhook is null when no webhook is set. The signing secret is never returned here.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getWebhook({ bucketId })` |
| Python | `client.api.get_webhook(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getWebhook({ bucketId: 'bkt_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_webhook("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets/bkt_example/webhook" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `webhook` | Webhook or null |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Webhooks and live subscriptions](https://revdoku.com/api.md#webhooks-and-live-subscriptions)

## Set the webhook

`PUT /v1/buckets/{bucket_id}/webhook`

Requires bucket-admin permission and a public HTTPS URL.

The webhook receives the bucket's ticket events (TicketEvent): ticket.created and ticket.message_received, for every channel. A new URL or rotate_secret=true creates a new signing secret, returns it once and cancels pending deliveries. The same URL without rotate_secret returns the webhook without a secret.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.setWebhook({ bucketId, setWebhookRequest })` |
| Python | `client.api.set_webhook(bucket_id, set_webhook_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |

**Request body**: TypeScript `setWebhookRequest: SetWebhookRequest`, Python `set_webhook_request=SetWebhookRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `webhook_url` / `webhookUrl` | string (uri) | yes |  |
| `rotate_secret` / `rotateSecret` | boolean | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.setWebhook({
  bucketId: 'bkt_example',
  setWebhookRequest: { webhookUrl: 'https://example.com/revdoku/webhook' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, SetWebhookRequest

client = Revdoku()
response = client.api.set_webhook(
    "bkt_example",
    SetWebhookRequest(webhook_url="https://example.com/revdoku/webhook"),
)
print(response.data)
```

**cURL**

```sh
curl -X PUT "https://api.revdoku.com/v1/buckets/bkt_example/webhook" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"webhook_url": "https://example.com/revdoku/webhook"}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `webhook` | WebhookWithSecret |  |
| `webhook.url` | string (uri) |  |
| `webhook.events` | array of string: `ticket.created`, `ticket.message_received` | The event types that the webhook receives. |
| `webhook.signing_secret` / `signingSecret` | string | Returned once, when this request issues a secret: a new URL or rotate_secret=true. Store it to verify signatures. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Webhooks and live subscriptions](https://revdoku.com/api.md#webhooks-and-live-subscriptions)

## Remove the webhook

`DELETE /v1/buckets/{bucket_id}/webhook`

Cancels queued deliveries. A delivery already in progress can finish. Returns the bucket ID, also when no webhook is set.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.deleteWebhook({ bucketId })` |
| Python | `client.api.delete_webhook(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.deleteWebhook({ bucketId: 'bkt_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.delete_webhook("bkt_example")
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/buckets/bkt_example/webhook" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
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

Guide: [Webhooks and live subscriptions](https://revdoku.com/api.md#webhooks-and-live-subscriptions)

## Get a live event subscription ticket

`GET /v1/buckets/{bucket_id}/events/subscription`

Requires bucket read permission.

Connect to websocket_url with subscription_token=TOKEN within 60 seconds, then subscribe to BucketEventsChannel with account_id and bucket_id. Each event is a TicketEvent. Catch up with GET /v1/buckets/{bucket_id}/tickets and updated_after after every connect.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getEventSubscription({ bucketId })` |
| Python | `client.api.get_event_subscription(bucket_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_id` / `bucketId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getEventSubscription({
  bucketId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_event_subscription("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/buckets/bkt_example/events/subscription" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `subscription` | EventSubscription |  |
| `subscription.token` | string |  |
| `subscription.expires_in` / `expiresIn` | integer `60` |  |
| `subscription.channel` | string `"BucketEventsChannel"` |  |
| `subscription.account_id` / `accountId` | string |  |
| `subscription.bucket_id` / `bucketId` | string |  |
| `subscription.websocket_url` / `websocketUrl` | string (uri) | Base WebSocket endpoint. Append subscription_token as a query parameter. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Webhooks and live subscriptions](https://revdoku.com/api.md#webhooks-and-live-subscriptions)
