# Customer mailboxes for your SaaS

Give each customer a private mailbox. Your backend creates mailboxes, reads messages
and downloads attachments. Customers need no separate Revdoku signup.

## Start with the examples

1. Select your development account. In **Account → Access**, create an API key
   with **All current and future mailboxes** and **Manage mailboxes and files**
   (`mailbox_admin`) for provisioning. Browser signup already creates a mailbox.
2. Clone the [repository](https://github.com/revdoku/revdoku). In `examples`, copy
   `.env.example` to `.env`. With Node.js 22+, set
   `REVDOKU_API_KEY` and `REVDOKU_ACCOUNT_ID` locally. Keep keys off browsers and Git.
3. Run these commands with customer IDs from a trusted application job. They
   consume creation capacity.

```sh
node --env-file=.env javascript/provision-customer-mailbox.js customer-a
node --env-file=.env javascript/provision-customer-mailbox.js customer-b
node --env-file=.env javascript/process-customer-mail.js
```

The examples use native `fetch` and a private persistent journal in
`.revdoku-examples` (`REVDOKU_STATE_DIR` overrides this). Run one process at a time;
verify its process stopped before removing a leftover lock.

Send test mail to a confirmed address. The processor saves summaries and arrival
cursors for mapped mailboxes. Rerun it periodically and after restarts. External
side effects need their own deduplication.

## Map customers and choose access

Store `customer_id`, `account_id`, `mailbox_id`, confirmed address, provisioning
state and cursor. Authenticate every customer request and resolve its mapping
server-side; reject another customer's mailbox ID.

Use a separate Revdoku account when ownership, membership, administration or the
account encryption boundary must differ. Eligible managed accounts share
billing-group capacity while retaining separate files and memberships.
[Direct signup](../api.md#direct-api-signup) creates a new owner account.

| Task | Credential needed |
| --- | --- |
| List/read messages, download attachments | `mailbox_read` with the mapped mailbox selected |
| Discover an address or receiving state | Mailbox write access; store the address during provisioning for readers |
| Create an mailbox | Account-wide `mailbox_admin` access and an eligible account membership |
| Configure a webhook or delete a message | Mailbox admin access |
| Manage aliases/custom domains | Full-account owner/administrator with mailbox-admin access |

Use separate provisioning and reading credentials. Selected-mailbox access does
not permit creating mailboxes. A normal API key consumes `max_api_keys`; an
agent-labelled OAuth/device or direct-signup connection consumes
`max_agent_connections`, even when its bearer token calls REST. Human memberships
have their own allowance.

Check `GET /v1/accounts` and `GET /v1/accounts/:id`. Include the granted `account_id`
on every request. Browser account switching does not change a key's default.
Namespace mappings, cursors and work records by account and mailbox.

## Provision once and recover

The [minimal creation request](../api.md#1-create-an-mailbox) sends `{"mailbox":{}}`.
For a connected custom domain, set `REVDOKU_EMAIL_DOMAIN` before provisioning.

| Outcome | Next action |
| --- | --- |
| `201` | Persist the mailbox ID and confirmed receiving address. |
| `503 EMAIL_NOT_READY` | Persist `error.details.mailbox_id`; inspect that existing mailbox with `GET /v1/mailboxes/:id?include_email=true&account_id=…`. |
| Timeout, broken connection or unreadable response | Retain an unknown outcome; reconcile existing mailboxes. Do not repeat the POST. |
| Capacity/permission error | Resolve the returned condition before an explicitly chosen new attempt. |

The example saves intent and a unique mailbox title before sending. After an
unknown result, rerunning searches that title and requires an exact match; it
never repeats the POST. Titles are reconciliation data, not retry keys. Missing
or multiple matches need human review; an empty list does not prove creation
failed. A known mailbox ID is checked with GET. Structured 4xx rejection permits a
later explicit new attempt. Use only confirmed addresses.

Aliases share an mailbox's messages, restrictions and quotas; they provide no
isolation. Follow the [alias workflow](../api.md#mailbox-aliases),
check `max_email_aliases_per_mailbox`, and wait for routing confirmation. Keeping an
old primary also uses rotation capacity. Removal stops new/queued deliveries;
existing mail remains.

## Estimate capacity

Read `GET /v1/account/limits?account_id=…`; use effective values rather than copied
plan numbers. Full-account admin connections and browser sessions also receive
`data.usage.mailbox_creations`, including remaining creations and the UTC reset.

| Dimension | Scope and timing |
| --- | --- |
| `max_mailboxes` | Active mailboxes across the billing group |
| Creation allowance | Billing group, UTC calendar month; deleting/archiving refunds nothing |
| Incoming count and raw bytes | Billing period; MIME encoding and matched rejected attempts can consume traffic |
| Stored bytes/current files | Retained content, including EML, JSON, Markdown, attachments and versions |
| Per-file/message limits | Each upload or incoming message; PDFs may have a separate cap |
| Domains/aliases | Domain slots per account; aliases per mailbox |
| Request/arrival throttles | API request limits and separate fixed-minute receiving limits |

For illustration, 5 GiB divided by a 0.5 MiB average raw message permits about
10,240 messages, even with a count allowance of 15,000.
Measure MIME and saved artifact sizes; there is no fixed attachment multiplier.
Allow headroom for spikes and versions. The server decides capacity under concurrency.
Stop on `MAILBOX_CREATION_LIMIT_REACHED` and report `resets_at`.

For larger workloads, send [support](mailto:support@revdoku.com) your mailbox count, creation rate,
monthly messages/raw bytes, stored bytes, peak arrivals, domains, webhook load
and support needs. Confirm allowances and [pricing](https://app.revdoku.com/pricing) before promising capacity.

## Process arrivals reliably

| State | Meaning |
| --- | --- |
| Shared read/unread | Presentation state; humans can change it |
| Arrival cursor | Which arrivals your reader has discovered |
| Application work record | Which business work completed |

Do not use unread filters as a job queue. Deduplicate business work by
`account_id/mailbox_id/email_id`, and webhook delivery by event ID. Separate mailbox
deliveries must not collapse solely because they share a sender Message-ID.

For webhooks, verify the signature/timestamp and mapped account/mailbox, durably
accept work, then acknowledge. Workers fetch content afterward. Multiple workers
need unique work keys and claim leases. External side effects need idempotency
keys to survive a crash before completion is recorded.

Catch up with ascending cursors on startup and periodically, even with webhooks.
Save cursors after durably handling each page, including empty pages. Read-state
changes do not replay arrivals. See the
[notification examples](https://github.com/revdoku/revdoku/blob/main/examples/README.md#new-email-notifications) for signed
receivers and local WebSocket reconnects.

## Display messages and attachments

Escape `body_text` as ordinary text and preserve whitespace. HTML-only mail is
converted to text; it is not a faithful HTML renderer. Handle `body_status` values
`complete`, `empty`, `truncated` and `unavailable`, offering the authoritative
original EML when needed. Saved attachment metadata and optional
`omitted_attachment_count` describe availability; older messages may lack the latter.

Authorize the customer mapping, store attachment IDs, and request links on demand.
Standard links last 15 minutes and can survive key revocation until expiry.
Never send the API key to a download URL. Use
[download-attachments](https://github.com/revdoku/revdoku/blob/main/examples/javascript/download-attachments.js) separately;
individual message/file deletion is an explicit action, never processing acknowledgement.

## When receiving stops

A rolling hour reaching 30% of either effective monthly traffic allowance
automatically pauses that mailbox. The owner receives email and an in-app alert.
An owner/administrator must resume in the browser after cooldown and other holds
clear. Pause/Resume and detailed diagnostic logs are dashboard-only. Mail rejected
while paused must be resent; there is no replay queue.

Mailbox-wide locks and moves can also stop intake, including queued saves. Prefer
file locks for narrow edits or a separate working mailbox for broad reorganizations.

Check: granted account → receiving state → limits → saved messages → dashboard
webhook history → application work. Webhook failure does not imply storage failure.
Give an authorized human account/mailbox
IDs, UTC interval, known email/event/request IDs, blocked reason and completed
checks. Use [Analytics](https://app.revdoku.com/analytics) and the source mailbox;
history is retention-limited. Report “not found in accessible saved messages”
without guessing why an external sender's mail is missing. Exclude bodies,
credentials and signed URLs from the handoff.

## Development and CI

Reuse development mailboxes. Run `npm ci`, `npm run build`, and `npm run check` in
`examples` for offline fixtures. Cover duplicates, bad signatures, empty pages,
restarts, uncertain creation and cross-customer denial. For live smoke tests,
externally send/read mail, download an attachment, then restart/catch up. Delete
only identified test messages/files individually.

## HIPAA and high-security accounts

Content-search filters may be unavailable; authorized reads still work. Signed API
download URLs check access and decrypt content. Fetch them without an API key.
See [account setup and download differences](../api.md#hipaa-and-high-security-accounts).
