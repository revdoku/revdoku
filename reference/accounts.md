# Accounts API reference

Connection status, granted accounts and limits.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/mailboxes`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [Read the connection and selected account](#read-the-connection-and-selected-account): `GET /v1/status`
- [List accounts granted to this credential](#list-accounts-granted-to-this-credential): `GET /v1/accounts`
- [Create a client account](#create-a-client-account): `POST /v1/accounts`
- [Read one granted account](#read-one-granted-account): `GET /v1/accounts/{account_id}`
- [Read effective account limits](#read-effective-account-limits): `GET /v1/account/limits`

## Read the connection and selected account

`GET /v1/status`

Works with every API key, including mailbox-scoped keys. Read quotas with GET /v1/account/limits.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getStatus()` |
| Python | `client.api.get_status()` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getStatus();
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_status()
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/status" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `connected` | boolean |  |
| `account` | object | Selected account identity and state. |
| `default_account_id` / `defaultAccountId` | string or null |  |
| `accounts` | array of object |  |
| `server_version` / `serverVersion` | string |  |
| `client_version` / `clientVersion` | string | Current CLI and skill release. |
| `features` | object |  |
| `features.email_domains` / `emailDomains` | boolean |  |
| `connection` | Connection |  |
| `connection.api_key_id` / `apiKeyId` | string or null |  |
| `connection.label` | string or null |  |
| `connection.token_type` / `tokenType` | string: `api` or null |  |
| `connection.scope` | string: `mailbox_read`, `mailbox_write`, `mailbox_admin` or null |  |
| `connection.expires_at` / `expiresAt` | string (date-time) or null |  |
| `connection.last_used_at` / `lastUsedAt` | string (date-time) or null |  |
| `connection.mailbox_access` / `mailboxAccess` | string: `all`, `selected` or null |  |
| `connection.mailbox_ids` / `mailboxIds` | array of string |  |
| `connection.denied_mailbox_ids` / `deniedMailboxIds` | array of string |  |
| `connection.mailbox_permissions` / `mailboxPermissions` | object |  |
| `connection.permissions` | object | Fields: `read`, `write`, `admin`. |
| `connection.agent` | object or null |  |
| `connection.transport` | string or null |  |
| `connection.renewal` | object | Fields: `recommended`, `next_action`, `browser_url`. |
| `user` | object | The signed-in person behind this credential. |
| `user.id` | string |  |
| `user.email` | string |  |
| `user.name` | string |  |
| `dashboard_url` / `dashboardUrl` | string (uri) | Dashboard link for the selected account. It grants no access. |

```json
{
  "success": true,
  "data": {
    "connected": true,
    "default_account_id": "acct_example",
    "accounts": [
      {
        "id": "acct_example",
        "name": "Acme",
        "account_kind": "standard",
        "client_name": null,
        "agency_account": null
      }
    ],
    "server_version": "1.0.575",
    "client_version": "1.0.575",
    "features": {"email_domains": true},
    "account": {
      "id": "acct_example",
      "name": "Acme",
      "status": "active",
      "account_kind": "standard",
      "client_name": null,
      "agency_account": null,
      "can_create_client_account": false,
      "can_manage_billing": true,
      "billing_message": null,
      "previous_status": null,
      "status_reason": null,
      "status_updated_at": null
    },
    "user": {
      "id": "user_example",
      "email": "ada@example.com",
      "name": "Ada Lovelace"
    },
    "dashboard_url": "https://app.revdoku.com/mailboxes?account_id=acct_example",
    "connection": {
      "api_key_id": "atok_example",
      "label": "Orders backend",
      "token_type": "api",
      "scope": "mailbox_admin",
      "expires_at": "2027-10-11T12:00:00Z",
      "last_used_at": "2026-10-11T12:20:00Z",
      "mailbox_access": "all",
      "mailbox_ids": [],
      "denied_mailbox_ids": [],
      "mailbox_permissions": {},
      "permissions": {"read": true, "write": true, "admin": true},
      "agent": null,
      "transport": "api_key",
      "renewal": {"recommended": false}
    }
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Accounts](https://revdoku.com/api.md#accounts)

## List accounts granted to this credential

`GET /v1/accounts`

Works with every API key. Lists the account of this credential and the client accounts that an agency owner granted to it. Send an id from this list as account_id to act in that account.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.listAccounts()` |
| Python | `client.api.list_accounts()` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `limit` | integer | no |  |
| `cursor` | string | no | pagination.next_cursor from the previous page. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.listAccounts();
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.list_accounts()
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/accounts" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `accounts` | array of AccountIdentity |  |
| `accounts[].id` | string |  |
| `accounts[].name` | string | Account name, separate from the client person or business. |
| `accounts[].account_kind` / `accountKind` | string: `standard`, `agency`, `client` |  |
| `accounts[].client_name` / `clientName` | string or null | Client person or business name, or null when unset. |
| `accounts[].agency_account` / `agencyAccount` | object or null | Parent agency only when granted to this credential. Null does not make a client independent. Fields: `id`, `name`. |
| `accounts[].region` | string or null |  |
| `accounts[].status` | string: `active`, `read_only` |  |
| `accounts[].permissions` | object | Fields: `scope`, `mailbox_access`, `can_create_mailboxes`. |
| `default_account_id` / `defaultAccountId` | string or null | Account used when a request does not send account_id. |
| `pagination` | Pagination | One page of a list. Request the next page with cursor=next_cursor and the same filters. Cursors are opaque strings: do not build or decode them. |
| `pagination.limit` | integer |  |
| `pagination.has_more` / `hasMore` | boolean | True when another page exists. |
| `pagination.next_cursor` / `nextCursor` | string or null | Cursor for the next page; null on the last page. Email lists always return a cursor so that you can poll for new mail. |

```json
{
  "success": true,
  "data": {
    "default_account_id": "acct_example",
    "accounts": [
      {
        "id": "acct_example",
        "name": "Acme",
        "account_kind": "standard",
        "client_name": null,
        "agency_account": null,
        "region": "eu",
        "status": "active",
        "permissions": {
          "scope": "mailbox_admin",
          "mailbox_access": "all",
          "can_create_mailboxes": true
        }
      }
    ],
    "pagination": {"limit": 50, "has_more": false, "next_cursor": null}
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Accounts](https://revdoku.com/api.md#accounts)

## Create a client account

`POST /v1/accounts`

Requires an agency owner credential with client-account access.

The credential default does not change; send the new account_id on later requests.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.createClientAccount({ createClientAccountRequest })` |
| Python | `client.api.create_client_account(create_client_account_request)` |

**Request body**: TypeScript `createClientAccountRequest: CreateClientAccountRequest`, Python `create_client_account_request=CreateClientAccountRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | string | yes |  |
| `client_name` / `clientName` | string | no | Optional client person or business name. |
| `account_id` / `accountId` | string | no | Granted agency account that owns the new client account. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.createClientAccount({
  createClientAccountRequest: { name: 'Example client' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, CreateClientAccountRequest

client = Revdoku()
response = client.api.create_client_account(
    CreateClientAccountRequest(name="Example client"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/accounts" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"name": "Example client"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `account` | AccountIdentity | Fields as in [List accounts granted to this credential](#list-accounts-granted-to-this-credential). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Client accounts](https://revdoku.com/api.md#client-accounts)

## Read one granted account

`GET /v1/accounts/{account_id}`

Works with every API key. Returns the name, kind, region and status of one account that this credential can use, and the permissions of the credential in it. Other account IDs return 403.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getAccount({ accountId })` |
| Python | `client.api.get_account(account_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | yes | Granted account to read. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getAccount({ accountId: 'acct_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_account("acct_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/accounts/acct_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `account` | AccountIdentity | Fields as in [List accounts granted to this credential](#list-accounts-granted-to-this-credential). |

```json
{
  "success": true,
  "data": {
    "account": {
      "id": "acct_example",
      "name": "Acme",
      "account_kind": "standard",
      "client_name": null,
      "agency_account": null,
      "region": "eu",
      "status": "active",
      "permissions": {
        "scope": "mailbox_admin",
        "mailbox_access": "all",
        "can_create_mailboxes": true
      }
    }
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Accounts](https://revdoku.com/api.md#accounts)

## Read effective account limits

`GET /v1/account/limits`

Values come from the plan and account overrides. Zero means no allowance; null means no cap. Storage, mailbox and email traffic allowances are shared within a billing group.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getAccountLimits()` |
| Python | `client.api.get_account_limits()` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getAccountLimits();
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_account_limits()
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/account/limits" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `account_id` / `accountId` | string |  |
| `limits` | AccountLimits |  |
| `limits.max_mailboxes` / `maxMailboxes` | integer or null |  |
| `limits.max_mailbox_creations_per_month` / `maxMailboxCreationsPerMonth` | integer or null |  |
| `limits.max_files_per_mailbox` / `maxFilesPerMailbox` | integer or null |  |
| `limits.max_current_files` / `maxCurrentFiles` | integer or null |  |
| `limits.max_storage_bytes` / `maxStorageBytes` | integer (int64) or null |  |
| `limits.max_file_size_bytes` / `maxFileSizeBytes` | integer (int64) or null |  |
| `limits.max_pdf_size_bytes` / `maxPdfSizeBytes` | integer (int64) or null |  |
| `limits.max_file_versions_per_file` / `maxFileVersionsPerFile` | integer or null |  |
| `limits.max_email_domains` / `maxEmailDomains` | integer or null |  |
| `limits.max_received_emails_per_month` / `maxReceivedEmailsPerMonth` | integer or null |  |
| `limits.max_received_email_bytes_per_month` / `maxReceivedEmailBytesPerMonth` | integer (int64) or null |  |
| `limits.max_received_email_message_bytes` / `maxReceivedEmailMessageBytes` | integer (int64) or null |  |
| `limits.max_sent_emails_per_month` / `maxSentEmailsPerMonth` | integer or null | Sent-email recipients per billing period, shared by the billing group. Each recipient counts once. |
| `limits.max_email_address_rotations_per_month` / `maxEmailAddressRotationsPerMonth` | integer or null |  |
| `limits.max_account_members` / `maxAccountMembers` | integer or null |  |
| `limits.max_api_keys` / `maxApiKeys` | integer or null |  |
| `limits.max_agent_connections` / `maxAgentConnections` | integer or null |  |
| `limits.api_rate_limit_requests_per_minute` / `apiRateLimitRequestsPerMinute` | integer or null |  |
| `limits.audit_retention_days` / `auditRetentionDays` | integer or null |  |
| `limits.max_email_aliases_per_mailbox` / `maxEmailAliasesPerMailbox` | integer | Active retained email addresses (aliases) per mailbox. Zero means that the plan has no aliases. |
| `usage` | object |  |
| `usage.mailbox_creations` / `mailboxCreations` | object | Fields: `monthly_limit`, `used`, `remaining`, `resets_at`. |

```json
{
  "success": true,
  "data": {
    "account_id": "acct_example",
    "limits": {
      "max_mailboxes": 3,
      "max_mailbox_creations_per_month": 12,
      "max_files_per_mailbox": 25000,
      "max_current_files": 40000,
      "max_storage_bytes": 2147483648,
      "max_file_size_bytes": 52428800,
      "max_pdf_size_bytes": 52428800,
      "max_file_versions_per_file": 15,
      "max_email_aliases_per_mailbox": 4,
      "max_email_domains": 3,
      "max_received_emails_per_month": 1500,
      "max_received_email_bytes_per_month": 268435456,
      "max_received_email_message_bytes": 20971520,
      "max_sent_emails_per_month": 750,
      "max_email_address_rotations_per_month": 6,
      "max_account_members": 3,
      "max_api_keys": 4,
      "max_agent_connections": 7,
      "api_rate_limit_requests_per_minute": 240,
      "audit_retention_days": 45
    },
    "usage": {
      "mailbox_creations": {
        "monthly_limit": 12,
        "used": 2,
        "remaining": 10,
        "resets_at": "2026-11-01T00:00:00Z"
      }
    }
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Limits](https://revdoku.com/api.md#limits)
