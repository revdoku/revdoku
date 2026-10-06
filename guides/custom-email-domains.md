# Custom email domains

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

Connecting a domain preserves existing addresses. Select it when creating a mailbox,
or use the address replacement endpoint for an existing mailbox.

| Replacement field | Purpose |
| --- | --- |
| `domain` | Exact ready domain, such as `mail.example.com`; use `platform` for the platform domain. |
| `username` | Optional chosen name, such as `my-agent`. Omit for a generated name. |
| `current_address` | Current address being replaced. |
| `confirm` | Must be `true`. |

Custom names require account-administrator access and deployment support.
[Username rules](../api.md#username-rules) also apply. Platform domains also accept chosen
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


[API reference](../api.md)
