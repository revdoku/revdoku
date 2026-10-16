# Email settings API reference

Addresses, aliases, allowed senders, webhooks and live subscriptions.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/mailboxes`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [Read address settings](#read-address-settings): `GET /v1/mailboxes/{mailbox_id}/email`
- [Change the primary address](#change-the-primary-address): `POST /v1/mailboxes/{mailbox_id}/email/rotate`
- [Add an alias address](#add-an-alias-address): `POST /v1/mailboxes/{mailbox_id}/email/aliases`
- [Remove an alias address](#remove-an-alias-address): `DELETE /v1/mailboxes/{mailbox_id}/email/aliases/{alias_id}`
- [Replace the allowed senders](#replace-the-allowed-senders): `PATCH /v1/mailboxes/{mailbox_id}/email/allowlist`
- [Read the email webhook](#read-the-email-webhook): `GET /v1/mailboxes/{mailbox_id}/email/webhook`
- [Set the email webhook](#set-the-email-webhook): `PUT /v1/mailboxes/{mailbox_id}/email/webhook`
- [Remove the email webhook](#remove-the-email-webhook): `DELETE /v1/mailboxes/{mailbox_id}/email/webhook`
- [Get a live email subscription ticket](#get-a-live-email-subscription-ticket): `GET /v1/mailboxes/{mailbox_id}/email/subscription`

## Read address settings

`GET /v1/mailboxes/{mailbox_id}/email`

Requires mailbox write permission.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getMailboxEmailSettings({ mailboxId })` |
| Python | `client.api.get_mailbox_email_settings(mailbox_id)` |

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
const { data } = await client.api.getMailboxEmailSettings({
  mailboxId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_mailbox_email_settings("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes/bkt_example/email" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `address` | string | Primary address. Present when the credential has write access to the mailbox. Show it after the title. |
| `message_count` / `messageCount` | integer (int64) or null | Emails currently stored. Null while the email index is being prepared. |
| `unread_count` / `unreadCount` | integer (int64) or null | Stored emails with shared unread status. Null while the email index is being prepared. |
| `last_received_at` / `lastReceivedAt` | string (date-time) or null | Receipt time of the latest saved email; null before the first email. |
| `receiving_enabled` / `receivingEnabled` | boolean | Whether the mailbox can receive email now. |
| `blocked_reason` / `blockedReason` | string | Why receiving is unavailable. Omitted when receiving_enabled is true. |
| `sending_enabled` / `sendingEnabled` | boolean | Whether the mailbox can send replies now. |
| `sending_blocked_reason` / `sendingBlockedReason` | string | Why sending is unavailable. Omitted when sending_enabled is true. |
| `username` | string or null | The part of address before @. |
| `aliases` | array of EmailAlias |  |
| `aliases[].id` | string |  |
| `aliases[].address` | string |  |
| `aliases[].active` | boolean | Within the current alias allowance. Mailbox receiving holds still apply. |
| `available_domains` / `availableDomains` | array of object |  |
| `available_domains[].hostname` | string |  |
| `available_domains[].kind` | string: `platform`, `custom` |  |
| `assignment` | object | No candidate address is disclosed. Keep using address until status is active; on pending poll the email endpoint. |
| `assignment.id` | string |  |
| `assignment.status` | string: `pending`, `active`, `failed` |  |
| `assignment.hostname` | string |  |
| `assignment.error` | object | Fields: `code`, `message`, `retryable`. |
| `customization` | object | Caller-specific customization capability on the dedicated email GET/rotate endpoints. |
| `customization.allowed` | boolean |  |
| `customization.blocked_reason` / `blockedReason` | string or null |  |
| `customization.settings_url` / `settingsUrl` | string or null | Account-domain settings link for administrators; null otherwise. |
| `sender_allowlist` / `senderAllowlist` | EmailSenderAllowlist | Returned to account administrators with mailbox-admin permission. |
| `sender_allowlist.enabled` | boolean |  |
| `sender_allowlist.entries` | array of string |  |
| `sender_allowlist.version` | string |  |
| `sender_allowlist.max_entries` / `maxEntries` | integer |  |
| `sender_allowlist.editable` | boolean |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Email settings](https://revdoku.com/api.md#email-settings)

## Change the primary address

`POST /v1/mailboxes/{mailbox_id}/email/rotate`

Requires a paid plan and mailbox admin permission.

Send the current address as expected_address. Omit username for a generated name. A custom-domain change returns 202; read the settings until assignment.status is active or failed. For account owners and administrators the old address becomes an alias unless keep_old_as_alias is false. Without a free alias slot the request returns EMAIL_ALIAS_LIMIT; send false to retire the old address.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.changeMailboxAddress({ mailboxId, changeMailboxAddressRequest })` |
| Python | `client.api.change_mailbox_address(mailbox_id, change_mailbox_address_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `changeMailboxAddressRequest: ChangeMailboxAddressRequest`, Python `change_mailbox_address_request=ChangeMailboxAddressRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `confirm` | boolean `true` | yes |  |
| `expected_address` / `expectedAddress` | string | yes | Current address from your last settings read. A different current address returns EMAIL_ADDRESS_CHANGED. |
| `username` | string | no | New name before @. On revdokumail.com, a prefix with a new 4-character random suffix; on a custom domain, the exact name. |
| `domain` | string | no | Available platform domain, a ready domain of this account, or platform. |
| `keep_old_as_alias` / `keepOldAsAlias` | boolean | no | Keep the old address as an alias. Defaults to true for account owners and administrators while the old domain still receives email, otherwise false. Keeping it needs a free alias slot and an account owner or administrator. |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.changeMailboxAddress({
  mailboxId: 'bkt_example',
  changeMailboxAddressRequest: { confirm: true, expectedAddress: 'support.k7x2@revdokumail.com' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, ChangeMailboxAddressRequest

client = Revdoku()
response = client.api.change_mailbox_address(
    "bkt_example",
    ChangeMailboxAddressRequest(
        confirm=True,
        expected_address="support.k7x2@revdokumail.com",
    ),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/email/rotate" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "confirm": true,
  "expected_address": "support.k7x2@revdokumail.com"
}'
```

**Response** `200`, `202`

| Field | Type | Description |
| --- | --- | --- |
| `address` | string | Primary address. Present when the credential has write access to the mailbox. Show it after the title. |
| `message_count` / `messageCount` | integer (int64) or null | Emails currently stored. Null while the email index is being prepared. |
| `unread_count` / `unreadCount` | integer (int64) or null | Stored emails with shared unread status. Null while the email index is being prepared. |
| `last_received_at` / `lastReceivedAt` | string (date-time) or null | Receipt time of the latest saved email; null before the first email. |
| `receiving_enabled` / `receivingEnabled` | boolean | Whether the mailbox can receive email now. |
| `blocked_reason` / `blockedReason` | string | Why receiving is unavailable. Omitted when receiving_enabled is true. |
| `sending_enabled` / `sendingEnabled` | boolean | Whether the mailbox can send replies now. |
| `sending_blocked_reason` / `sendingBlockedReason` | string | Why sending is unavailable. Omitted when sending_enabled is true. |
| `username` | string or null | The part of address before @. |
| `aliases` | array of EmailAlias | Fields as in [Read address settings](#read-address-settings). |
| `available_domains` / `availableDomains` | array of object |  |
| `available_domains[].hostname` | string |  |
| `available_domains[].kind` | string: `platform`, `custom` |  |
| `assignment` | object | No candidate address is disclosed. Keep using address until status is active; on pending poll the email endpoint. |
| `assignment.id` | string |  |
| `assignment.status` | string: `pending`, `active`, `failed` |  |
| `assignment.hostname` | string |  |
| `assignment.error` | object | Fields: `code`, `message`, `retryable`. |
| `customization` | object | Caller-specific customization capability on the dedicated email GET/rotate endpoints. |
| `customization.allowed` | boolean |  |
| `customization.blocked_reason` / `blockedReason` | string or null |  |
| `customization.settings_url` / `settingsUrl` | string or null | Account-domain settings link for administrators; null otherwise. |
| `sender_allowlist` / `senderAllowlist` | EmailSenderAllowlist | Returned to account administrators with mailbox-admin permission. Fields as in [Read address settings](#read-address-settings). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `EMAIL_ALIAS_LIMIT`.

Guide: [Change the address](https://revdoku.com/api.md#change-the-address)

## Add an alias address

`POST /v1/mailboxes/{mailbox_id}/email/aliases`

Requires a paid plan and a full-account owner or administrator with mailbox-admin permission.

The primary address stays unchanged.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.createEmailAlias({ mailboxId, createEmailAliasRequest })` |
| Python | `client.api.create_email_alias(mailbox_id, create_email_alias_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `createEmailAliasRequest: CreateEmailAliasRequest`, Python `create_email_alias_request=CreateEmailAliasRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `username` | string | yes | Alias name before @. On revdokumail.com, a prefix with a 4-character random suffix; on a custom domain, the exact name. |
| `domain` | string | no |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.createEmailAlias({
  mailboxId: 'bkt_example',
  createEmailAliasRequest: { username: 'support' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, CreateEmailAliasRequest

client = Revdoku()
response = client.api.create_email_alias(
    "bkt_example",
    CreateEmailAliasRequest(username="support"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/mailboxes/bkt_example/email/aliases" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"username": "support"}'
```

**Response** `202`

| Field | Type | Description |
| --- | --- | --- |
| `address` | string | Primary address. Present when the credential has write access to the mailbox. Show it after the title. |
| `message_count` / `messageCount` | integer (int64) or null | Emails currently stored. Null while the email index is being prepared. |
| `unread_count` / `unreadCount` | integer (int64) or null | Stored emails with shared unread status. Null while the email index is being prepared. |
| `last_received_at` / `lastReceivedAt` | string (date-time) or null | Receipt time of the latest saved email; null before the first email. |
| `receiving_enabled` / `receivingEnabled` | boolean | Whether the mailbox can receive email now. |
| `blocked_reason` / `blockedReason` | string | Why receiving is unavailable. Omitted when receiving_enabled is true. |
| `sending_enabled` / `sendingEnabled` | boolean | Whether the mailbox can send replies now. |
| `sending_blocked_reason` / `sendingBlockedReason` | string | Why sending is unavailable. Omitted when sending_enabled is true. |
| `username` | string or null | The part of address before @. |
| `aliases` | array of EmailAlias | Fields as in [Read address settings](#read-address-settings). |
| `available_domains` / `availableDomains` | array of object |  |
| `available_domains[].hostname` | string |  |
| `available_domains[].kind` | string: `platform`, `custom` |  |
| `assignment` | object | No candidate address is disclosed. Keep using address until status is active; on pending poll the email endpoint. |
| `assignment.id` | string |  |
| `assignment.status` | string: `pending`, `active`, `failed` |  |
| `assignment.hostname` | string |  |
| `assignment.error` | object | Fields: `code`, `message`, `retryable`. |
| `customization` | object | Caller-specific customization capability on the dedicated email GET/rotate endpoints. |
| `customization.allowed` | boolean |  |
| `customization.blocked_reason` / `blockedReason` | string or null |  |
| `customization.settings_url` / `settingsUrl` | string or null | Account-domain settings link for administrators; null otherwise. |
| `sender_allowlist` / `senderAllowlist` | EmailSenderAllowlist | Returned to account administrators with mailbox-admin permission. Fields as in [Read address settings](#read-address-settings). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Aliases](https://revdoku.com/api.md#aliases)

## Remove an alias address

`DELETE /v1/mailboxes/{mailbox_id}/email/aliases/{alias_id}`

Stops new and queued deliveries to the alias. Saved emails stay.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.deleteEmailAlias({ mailboxId, aliasId })` |
| Python | `client.api.delete_email_alias(mailbox_id, alias_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `alias_id` / `aliasId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.deleteEmailAlias({
  mailboxId: 'bkt_example',
  aliasId: 'ema_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.delete_email_alias("bkt_example", "ema_example")
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/mailboxes/bkt_example/email/aliases/ema_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
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

Guide: [Aliases](https://revdoku.com/api.md#aliases)

## Replace the allowed senders

`PATCH /v1/mailboxes/{mailbox_id}/email/allowlist`

Requires an account owner or administrator with mailbox-admin permission.

Send sender_allowlist.version from the settings read as expected_version.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.updateEmailAllowlist({ mailboxId, updateEmailAllowlistRequest })` |
| Python | `client.api.update_email_allowlist(mailbox_id, update_email_allowlist_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `updateEmailAllowlistRequest: UpdateEmailAllowlistRequest`, Python `update_email_allowlist_request=UpdateEmailAllowlistRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `sender_allowlist` / `senderAllowlist` | object | yes |  |
| `sender_allowlist.enabled` | boolean | yes |  |
| `sender_allowlist.entries` | array of string | yes |  |
| `expected_version` / `expectedVersion` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.updateEmailAllowlist({
  mailboxId: 'bkt_example',
  updateEmailAllowlistRequest: {
    senderAllowlist: { enabled: true, entries: ['example.com'] },
    expectedVersion: 'VERSION_FROM_SETTINGS_READ',
  },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, UpdateEmailAllowlistRequest, UpdateEmailAllowlistRequestSenderAllowlist

client = Revdoku()
response = client.api.update_email_allowlist(
    "bkt_example",
    UpdateEmailAllowlistRequest(
        sender_allowlist=UpdateEmailAllowlistRequestSenderAllowlist(
            enabled=True,
            entries=["example.com"],
        ),
        expected_version="VERSION_FROM_SETTINGS_READ",
    ),
)
print(response.data)
```

**cURL**

```sh
curl -X PATCH "https://api.revdoku.com/v1/mailboxes/bkt_example/email/allowlist" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "sender_allowlist": {"enabled": true, "entries": ["example.com"]},
  "expected_version": "VERSION_FROM_SETTINGS_READ"
}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `sender_allowlist` / `senderAllowlist` | EmailSenderAllowlist | Fields as in [Read address settings](#read-address-settings). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Allowed senders](https://revdoku.com/api.md#allowed-senders)

## Read the email webhook

`GET /v1/mailboxes/{mailbox_id}/email/webhook`

Requires mailbox-admin permission.

webhook is null when no webhook is set. The signing secret is never returned here.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getEmailWebhook({ mailboxId })` |
| Python | `client.api.get_email_webhook(mailbox_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getEmailWebhook({ mailboxId: 'bkt_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_email_webhook("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes/bkt_example/email/webhook" \
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

## Set the email webhook

`PUT /v1/mailboxes/{mailbox_id}/email/webhook`

Requires mailbox-admin permission and a public HTTPS URL.

A new URL or rotate_secret=true creates a new signing secret, returns it once and cancels pending deliveries. The same URL without rotate_secret returns the webhook without a secret.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.setEmailWebhook({ mailboxId, setEmailWebhookRequest })` |
| Python | `client.api.set_email_webhook(mailbox_id, set_email_webhook_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |

**Request body**: TypeScript `setEmailWebhookRequest: SetEmailWebhookRequest`, Python `set_email_webhook_request=SetEmailWebhookRequest(...)`.

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
const { data } = await client.api.setEmailWebhook({
  mailboxId: 'bkt_example',
  setEmailWebhookRequest: { webhookUrl: 'https://example.com/revdoku/webhook' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, SetEmailWebhookRequest

client = Revdoku()
response = client.api.set_email_webhook(
    "bkt_example",
    SetEmailWebhookRequest(
        webhook_url="https://example.com/revdoku/webhook",
    ),
)
print(response.data)
```

**cURL**

```sh
curl -X PUT "https://api.revdoku.com/v1/mailboxes/bkt_example/email/webhook" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"webhook_url": "https://example.com/revdoku/webhook"}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `webhook` | WebhookWithSecret |  |
| `webhook.url` | string (uri) |  |
| `webhook.event` | string `"email.received"` |  |
| `webhook.signing_secret` / `signingSecret` | string | Returned once, when this request issues a secret: a new URL or rotate_secret=true. Store it to verify signatures. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Webhooks and live subscriptions](https://revdoku.com/api.md#webhooks-and-live-subscriptions)

## Remove the email webhook

`DELETE /v1/mailboxes/{mailbox_id}/email/webhook`

Cancels queued deliveries. A delivery already in progress can finish. Returns the mailbox ID, also when no webhook is set.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.deleteEmailWebhook({ mailboxId })` |
| Python | `client.api.delete_email_webhook(mailbox_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.deleteEmailWebhook({
  mailboxId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.delete_email_webhook("bkt_example")
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/mailboxes/bkt_example/email/webhook" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
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

Guide: [Webhooks and live subscriptions](https://revdoku.com/api.md#webhooks-and-live-subscriptions)

## Get a live email subscription ticket

`GET /v1/mailboxes/{mailbox_id}/email/subscription`

Requires mailbox read permission.

Connect to websocket_url with email_subscription_token=TOKEN within 60 seconds, then subscribe to EmailReceivedChannel. Catch up with the email list cursor after every connect.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getEmailSubscription({ mailboxId })` |
| Python | `client.api.get_email_subscription(mailbox_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `mailbox_id` / `mailboxId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getEmailSubscription({
  mailboxId: 'bkt_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_email_subscription("bkt_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/mailboxes/bkt_example/email/subscription" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `subscription` | EmailSubscription |  |
| `subscription.token` | string |  |
| `subscription.expires_in` / `expiresIn` | integer `60` |  |
| `subscription.channel` | string `"EmailReceivedChannel"` |  |
| `subscription.account_id` / `accountId` | string |  |
| `subscription.mailbox_id` / `mailboxId` | string |  |
| `subscription.websocket_url` / `websocketUrl` | string (uri) | Base WebSocket endpoint. Append email_subscription_token as a query parameter. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Webhooks and live subscriptions](https://revdoku.com/api.md#webhooks-and-live-subscriptions)
