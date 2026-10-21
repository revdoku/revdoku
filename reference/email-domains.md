# Email domains API reference

Custom domains for mailbox addresses.

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for example `https://api.revdoku.com/v1/mailboxes`. Send `Authorization: Bearer $REVDOKU_API_KEY` from your server. Tables use JSON names; where TypeScript differs, a field shows `json_name` / `typescriptName`. Python uses the JSON names.

[All operations](https://revdoku.com/api/reference.md) · [API guide](https://revdoku.com/api.md) · [Errors](https://revdoku.com/api.md#errors) · [OpenAPI](https://revdoku.com/openapi.json)

- [List custom email domains](#list-custom-email-domains): `GET /v1/account/email_domains`
- [Connect a custom email domain](#connect-a-custom-email-domain): `POST /v1/account/email_domains`
- [Check a hostname for conflicting DNS](#check-a-hostname-for-conflicting-dns): `POST /v1/account/email_domains/check`
- [Read a custom email domain](#read-a-custom-email-domain): `GET /v1/account/email_domains/{domain_id}`
- [Remove an unused custom email domain](#remove-an-unused-custom-email-domain): `DELETE /v1/account/email_domains/{domain_id}`
- [Check DNS and provider setup again](#check-dns-and-provider-setup-again): `POST /v1/account/email_domains/{domain_id}/verify`
- [Get a one-click DNS setup link](#get-a-one-click-dns-setup-link): `GET /v1/account/email_domains/{domain_id}/setup_link`

## List custom email domains

`GET /v1/account/email_domains`

Requires a full-account owner or administrator credential.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.listEmailDomains()` |
| Python | `client.api.list_email_domains()` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |
| `limit` | integer | no |  |
| `cursor` | string | no | pagination.next_cursor from the previous page. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.listEmailDomains();
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.list_email_domains()
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/account/email_domains" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `domains` | array of EmailDomain |  |
| `domains[].suggested_subdomain` / `suggestedSubdomain` | string or null |  |
| `domains[].root_guidance` / `rootGuidance` | string or null |  |
| `domains[].pause_reason` / `pauseReason` | string or null |  |
| `domains[].id` | string |  |
| `domains[].hostname` | string |  |
| `domains[].status` | string |  |
| `domains[].guidance` | string |  |
| `domains[].receiving` | boolean |  |
| `domains[].root_domain` / `rootDomain` | boolean |  |
| `domains[].paused_at` / `pausedAt` | string (date-time) or null |  |
| `domains[].last_checked_at` / `lastCheckedAt` | string (date-time) or null |  |
| `domains[].ownership_verified_at` / `ownershipVerifiedAt` | string (date-time) or null |  |
| `domains[].setup_expires_at` / `setupExpiresAt` | string (date-time) or null |  |
| `domains[].ready_at` / `readyAt` | string (date-time) or null |  |
| `domains[].required_dns_records` / `requiredDnsRecords` | array of DnsRecord | Fields: `type`, `name`, `value`, `purpose`, `zone`, `relative_name`. |
| `domains[].setup_provider` / `setupProvider` | string or null | DNS provider of the domain's zone that supports one-click setup, such as Cloudflare. Null otherwise, also while the deployment cannot sign setup links. Get the link with `getEmailDomainSetupLink`; it can still return an error. |
| `domains[].error` | object or null |  |
| `domains[].assigned_mailboxes` / `assignedMailboxes` | array of object | Fields: `id`, `email`. |
| `enabled` | boolean | Whether this account can use custom email domains. |
| `guidance` | string |  |
| `pagination` | Pagination | One page of a list. Request the next page with cursor=next_cursor and the same filters. Cursors are opaque strings: do not build or decode them. |
| `pagination.limit` | integer |  |
| `pagination.has_more` / `hasMore` | boolean | True when another page exists. |
| `pagination.next_cursor` / `nextCursor` | string or null | Cursor for the next page; null on the last page. Email lists always return a cursor so that you can poll for new mail. |

```json
{
  "success": true,
  "data": {
    "domains": [
      {
        "id": "ied_example",
        "hostname": "inbox.example.com",
        "status": "pending_ownership",
        "receiving": false,
        "root_domain": false,
        "suggested_subdomain": null,
        "guidance": "Subdomain recommended. If your domain already handles email elsewhere, use a subdomain such as mailbox.example.com to avoid disrupting it. Otherwise, use a dedicated domain such as mycustomdomain-mail.com.",
        "root_guidance": null,
        "required_dns_records": [
          {
            "type": "TXT",
            "name": "_revdoku-inbound.inbox.example.com",
            "value": "revdoku-inbound=EXAMPLE_TOKEN",
            "purpose": "ownership",
            "zone": "example.com",
            "relative_name": "_revdoku-inbound.inbox"
          },
          {
            "type": "TXT",
            "name": "_amazonses.inbox.example.com",
            "value": "EXAMPLE_SES_TOKEN",
            "purpose": "ses_verification",
            "zone": "example.com",
            "relative_name": "_amazonses.inbox"
          },
          {
            "type": "MX",
            "name": "inbox.example.com",
            "value": "10 inbound-smtp.eu-central-1.amazonaws.com",
            "purpose": "receiving",
            "zone": "example.com",
            "relative_name": "inbox"
          }
        ],
        "setup_provider": null,
        "pause_reason": null,
        "paused_at": null,
        "last_checked_at": null,
        "ownership_verified_at": null,
        "setup_expires_at": "2026-10-18T12:00:00.000Z",
        "ready_at": null,
        "error": null,
        "assigned_mailboxes": []
      }
    ],
    "enabled": true,
    "guidance": "Subdomain recommended. If your domain already handles email elsewhere, use a subdomain such as mailbox.example.com to avoid disrupting it. Otherwise, use a dedicated domain such as mycustomdomain-mail.com.",
    "pagination": {"limit": 50, "has_more": false, "next_cursor": null}
  }
}
```

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Custom email domains](https://revdoku.com/api.md#custom-email-domains)

## Connect a custom email domain

`POST /v1/account/email_domains`

Claims an exact hostname and returns the ownership record. Read the domain again shortly after for all `required_dns_records`. Never change DNS without the domain owner's authorization.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.createEmailDomain({ createEmailDomainRequest })` |
| Python | `client.api.create_email_domain(create_email_domain_request)` |

**Request body**: TypeScript `createEmailDomainRequest: CreateEmailDomainRequest`, Python `create_email_domain_request=CreateEmailDomainRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `hostname` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.createEmailDomain({
  createEmailDomainRequest: { hostname: 'inbox.example.com' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, CreateEmailDomainRequest

client = Revdoku()
response = client.api.create_email_domain(
    CreateEmailDomainRequest(hostname="inbox.example.com"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/account/email_domains" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"hostname": "inbox.example.com"}'
```

**Response** `201`

| Field | Type | Description |
| --- | --- | --- |
| `domain` | EmailDomain | Fields as in [List custom email domains](#list-custom-email-domains). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Custom email domains](https://revdoku.com/api.md#custom-email-domains)

## Check a hostname for conflicting DNS

`POST /v1/account/email_domains/check`

Makes no claim and changes no DNS. If the root domain already receives email, use an unused subdomain such as inbox.example.com.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.checkEmailDomain({ createEmailDomainRequest })` |
| Python | `client.api.check_email_domain(create_email_domain_request)` |

**Request body**: TypeScript `createEmailDomainRequest: CreateEmailDomainRequest`, Python `create_email_domain_request=CreateEmailDomainRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `hostname` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.checkEmailDomain({
  createEmailDomainRequest: { hostname: 'inbox.example.com' },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, CreateEmailDomainRequest

client = Revdoku()
response = client.api.check_email_domain(
    CreateEmailDomainRequest(hostname="inbox.example.com"),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/account/email_domains/check" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"hostname": "inbox.example.com"}'
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `hostname` | string |  |
| `root_domain` / `rootDomain` | boolean |  |
| `suggested_subdomain` / `suggestedSubdomain` | string or null |  |
| `root_guidance` / `rootGuidance` | string |  |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Custom email domains](https://revdoku.com/api.md#custom-email-domains)

## Read a custom email domain

`GET /v1/account/email_domains/{domain_id}`

Requires a full-account owner or administrator credential.

Returns the domain status and the DNS records to publish.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getEmailDomain({ domainId })` |
| Python | `client.api.get_email_domain(domain_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `domain_id` / `domainId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getEmailDomain({ domainId: 'ied_example' });
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_email_domain("ied_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/account/email_domains/ied_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `domain` | EmailDomain | Fields as in [List custom email domains](#list-custom-email-domains). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Custom email domains](https://revdoku.com/api.md#custom-email-domains)

## Remove an unused custom email domain

`DELETE /v1/account/email_domains/{domain_id}`

Send the domain hostname and confirm=true. A domain that mailbox addresses still use returns EMAIL_DOMAIN_IN_USE.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.deleteEmailDomain({ domainId, deleteEmailDomainRequest })` |
| Python | `client.api.delete_email_domain(domain_id, delete_email_domain_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `domain_id` / `domainId` | string | yes |  |

**Request body**: TypeScript `deleteEmailDomainRequest: DeleteEmailDomainRequest`, Python `delete_email_domain_request=DeleteEmailDomainRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `hostname` | string | yes |  |
| `confirm` | boolean `true` | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.deleteEmailDomain({
  domainId: 'ied_example',
  deleteEmailDomainRequest: { hostname: 'inbox.example.com', confirm: true },
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, DeleteEmailDomainRequest

client = Revdoku()
response = client.api.delete_email_domain(
    "ied_example",
    DeleteEmailDomainRequest(hostname="inbox.example.com", confirm=True),
)
print(response.data)
```

**cURL**

```sh
curl -X DELETE "https://api.revdoku.com/v1/account/email_domains/ied_example" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"hostname": "inbox.example.com", "confirm": true}'
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

Error codes named above: `EMAIL_DOMAIN_IN_USE`.

Guide: [Custom email domains](https://revdoku.com/api.md#custom-email-domains)

## Check DNS and provider setup again

`POST /v1/account/email_domains/{domain_id}/verify`

Queues the check and returns the current state. Read the domain again to see the result.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.verifyEmailDomain({ domainId, verifyEmailDomainRequest })` |
| Python | `client.api.verify_email_domain(domain_id, verify_email_domain_request)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `domain_id` / `domainId` | string | yes |  |

**Request body**: TypeScript `verifyEmailDomainRequest: VerifyEmailDomainRequest`, Python `verify_email_domain_request=VerifyEmailDomainRequest(...)`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `account_id` / `accountId` | string | no | Select another granted account for this request. |
| `reason` | string or null | no | Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.verifyEmailDomain({
  domainId: 'ied_example',
  verifyEmailDomainRequest: {},
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku, VerifyEmailDomainRequest

client = Revdoku()
response = client.api.verify_email_domain(
    "ied_example",
    VerifyEmailDomainRequest(),
)
print(response.data)
```

**cURL**

```sh
curl -X POST "https://api.revdoku.com/v1/account/email_domains/ied_example/verify" \
  -H "Authorization: Bearer $REVDOKU_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{}'
```

**Response** `202`

| Field | Type | Description |
| --- | --- | --- |
| `domain` | EmailDomain | Fields as in [List custom email domains](#list-custom-email-domains). |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Guide: [Custom email domains](https://revdoku.com/api.md#custom-email-domains)

## Get a one-click DNS setup link

`GET /v1/account/email_domains/{domain_id}/setup_link`

Signs a Domain Connect link for a domain whose `setup_provider` is set. Give the URL to the domain owner to open in a browser. The DNS provider adds `required_dns_records` after the owner approves them, then returns to Account Settings → Domains. Errors: 422 `EMAIL_DOMAIN_SETUP_UNSUPPORTED` when the provider or the domain state does not allow one-click setup, 422 `EMAIL_DOMAIN_SETUP_UNAVAILABLE` while the deployment cannot sign links, 422 `EMAIL_DNS_CONFLICT` when the hostname has records of another mail provider, 403 `EMAIL_DOMAINS_UPGRADE_REQUIRED` when the plan no longer includes custom email domains, and 503 `EMAIL_DNS_TEMPORARY` when DNS cannot be checked. Add the records manually, or try again later after a 503.

| Language | Call |
| --- | --- |
| TypeScript | `client.api.getEmailDomainSetupLink({ domainId })` |
| Python | `client.api.get_email_domain_setup_link(domain_id)` |

**Parameters**

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `domain_id` / `domainId` | string | yes |  |
| `account_id` / `accountId` | string | no | Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead. |

**Examples**

**TypeScript**

```ts
import { Revdoku } from 'revdoku';

const client = new Revdoku();
const { data } = await client.api.getEmailDomainSetupLink({
  domainId: 'ied_example',
});
console.log(data);
```

**Python**

```python
from revdoku import Revdoku

client = Revdoku()
response = client.api.get_email_domain_setup_link("ied_example")
print(response.data)
```

**cURL**

```sh
curl "https://api.revdoku.com/v1/account/email_domains/ied_example/setup_link" \
  -H "Authorization: Bearer $REVDOKU_API_KEY"
```

**Response** `200`

| Field | Type | Description |
| --- | --- | --- |
| `setup_link` / `setupLink` | object |  |
| `setup_link.provider` | string | DNS provider name, such as Cloudflare. |
| `setup_link.url` | string (uri) | Signed link for the domain owner to open in a browser. |

**Errors**

| Status | Description |
| --- | --- |
| 4xx, 5xx | Request failed: branch on `error.code`. A `429` or `503` with `Retry-After`: wait that many seconds, then try the read again. `429 EMAIL_SEND_RATE_LIMITED` has no `Retry-After`. |

Error codes named above: `EMAIL_DNS_CONFLICT`, `EMAIL_DNS_TEMPORARY`, `EMAIL_DOMAINS_UPGRADE_REQUIRED`, `EMAIL_DOMAIN_SETUP_UNAVAILABLE`, `EMAIL_DOMAIN_SETUP_UNSUPPORTED`.

Guide: [Custom email domains](https://revdoku.com/api.md#custom-email-domains)
