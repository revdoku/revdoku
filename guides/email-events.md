# Email events

Hosted applications receive signed HTTP webhooks. Local projects open an outbound
WebSocket through Rails Action Cable; no public domain or tunnel is required.
Both deliver the same event after the complete email and attachments are saved.
Read contents through the existing email API.

| Endpoint | Permission | Result |
| --- | --- | --- |
| GET /v1/mailboxes/:mailbox_id/email/webhook | Mailbox admin | Endpoint, or webhook: null; excludes the signing secret. |
| PUT /v1/mailboxes/:mailbox_id/email/webhook | Mailbox admin | Set one URL; returns the endpoint and signing secret. |
| DELETE /v1/mailboxes/:mailbox_id/email/webhook | Mailbox admin | Disable delivery; 204 No Content. |
| GET /v1/mailboxes/:mailbox_id/email/subscription | Mailbox read | Signed WebSocket ticket valid for 60 seconds. |

Use your normal bearer API key. Select another granted account with account_id in
the query for GET/DELETE, or in the JSON body for PUT. Endpoints must use public
HTTPS, including explicit ports such as 8443, with no URL user/password or fragment. Local/private addresses
and redirects are rejected. Invalid configuration returns INVALID_EMAIL_WEBHOOK (422).

| PUT field | Meaning |
| --- | --- |
| webhook_url | Required public HTTPS receiver URL, up to 2048 bytes. |
| rotate_secret | Optional boolean, default false. Replace the secret even when the URL is unchanged; pending deliveries are canceled. |
| account_id | Optional explicitly granted account; defaults to the credential's account. |

### Hosted application workflow

1. Implement an HTTPS POST receiver.
2. PUT {"webhook_url":"https://example.org/email-events"} to configure it. Securely save
   data.webhook.signing_secret. Repeating PUT with the same URL retains the secret;
   replacing the URL rotates it and cancels pending old-endpoint deliveries.
3. Verify the exact request bytes before parsing JSON.
4. Deduplicate the event ID, durably accept the event, and return any 2xx.
5. Fetch /v1/mailboxes/:mailbox_id/emails/:email_id with your own API key.

~~~json
{
  "id": "email.received:eml_example",
  "type": "email.received",
  "created_at": "2026-10-01T12:00:00.000000Z",
  "data": {
    "account_id": "acct_example",
    "mailbox_id": "bkt_example",
    "email_id": "eml_example",
    "received_at": "2026-10-01T11:59:58.000000Z",
    "attachment_count": 1
  }
}
~~~

| Field | Meaning |
| --- | --- |
| id | Stable event ID for deduplication; unchanged on retries. |
| type | email.received. |
| created_at | UTC time when intake queued the event. |
| data.account_id, data.mailbox_id | Account and mailbox that saved the message. |
| data.email_id | Stable email ID for the existing read endpoint. |
| data.received_at | UTC email receipt time. |
| data.attachment_count | Number of saved attachments. |

Events contain no subjects, senders, bodies, download links or API credentials.
Only new accepted deliveries emit them. Edits, copies, backfills and read changes
do not. Configuring a webhook does not replay history. Copies and account moves
clear the webhook; configure the destination explicitly.

| Header | Meaning |
| --- | --- |
| X-Revdoku-Event-Id | Event id. |
| X-Revdoku-Timestamp | Unix seconds for this delivery attempt. |
| X-Revdoku-Signature | v1= followed by lowercase HMAC-SHA256 hex. |

Sign timestamp + "." + raw_body. Reject timestamps outside a five-minute window
and compare signatures in constant time. A Rails receiver can use:

~~~ruby
timestamp = request.headers["X-Revdoku-Timestamp"].to_s
body = request.raw_post
provided = request.headers["X-Revdoku-Signature"].to_s.delete_prefix("v1=")
fresh = timestamp.match?(/\A\d+\z/) && (Time.current.to_i - timestamp.to_i).abs <= 300
expected = OpenSSL::HMAC.hexdigest("SHA256", ENV.fetch("REVDOKU_WEBHOOK_SECRET"), "#{timestamp}.#{body}")
return head :unauthorized unless fresh && ActiveSupport::SecurityUtils.secure_compare(expected, provided)
event = JSON.parse(body)
# Persist/deduplicate event["id"] and queue application work before returning 2xx.
head :no_content
~~~

Use your application's normal webhook CSRF exemption. Verify signatures before accepting requests.

| Delivery rule | Behavior |
| --- | --- |
| Automatic attempts | Up to 8 total for network failures, HTTP 408, 429 and 5xx |
| Retry delay | Polynomial backoff; valid `Retry-After` on 429/503 is bounded to 1–3,600 seconds |
| Other failures | Other non-2xx responses, redirects, private destinations, or responses over 64 KiB stop delivery |
| Timeout | 15 seconds total per request; acknowledge promptly after durable acceptance |
| Disable / replace / rotate | Cancels pending attempts; an in-flight request may finish |
| Retry identity | Same event ID, fresh timestamp and signature; no additional incoming-email charge |

Delivery can repeat or arrive out of order; deduplicate by event ID.

### Plans and delivery history

| Allowance | Effective value |
| --- | --- |
| Mailboxes with a webhook | Existing active-mailbox capacity; read `limits.max_mailboxes`. |
| Endpoints per mailbox | One. |
| New email events | Follow accepted messages within incoming count, byte and storage limits. |
| Delivery history | Read `limits.audit_retention_days`. |

Webhook capacity follows the account's existing mailbox and incoming-email limits, including overrides and shared billing. There is no separate webhook event allowance.

Delivery history is available in **Analytics → Webhooks**.

### Local project workflow

1. GET a subscription ticket with your read-authorized API key.
2. Open the returned `websocket_url`, adding `email_subscription_token=TICKET`
   within 60 seconds, using the `actioncable-v1-json` subprotocol.
3. Subscribe to EmailReceivedChannel with the returned account_id and mailbox_id.
   Wait for confirm_subscription.
4. List messages with your saved ascending arrival cursor and process every page.
   Deduplicate email IDs against live events received during catch-up.
5. Handle each live event's message and fetch its email through REST.
6. On a temporary disconnect, get a fresh ticket, reconnect, and repeat cursor catch-up. Stop if the server rejects the subscription or sends `reconnect: false`.

Runnable [JavaScript/TypeScript and Python examples](https://github.com/revdoku/revdoku/tree/main/examples) cover signed receivers and reconnects. The Node `watch-mail.js` example waits for subscription confirmation, catches up with a saved cursor, detects stale connections, and requests a fresh ticket on reconnect.

| Client guard | Limit |
| --- | --- |
| Duplicate mailbox subscriptions | One per connection |
| Mailbox subscriptions | 32 per connection; tickets authorize one mailbox |
| Connections | 32 per credential per web process |
| Handshakes | 120 per minute per source IP |
| Client commands | 120 per minute per connection; 4 KiB maximum per command |

Keep account, mailbox and filters unchanged when reusing a cursor. Preserve `pagination.next_cursor` even after an empty page. WebSocket events are live hints; REST catch-up supplies messages received while disconnected.

Ticket expiry limits connection establishment; an established subscription lasts
until disconnect or access revocation. Credentials and membership are checked before
each transmitted event. Treat the ticket as a temporary credential: it authorizes
only its selected mailbox channel, never account notification streams.


[API reference](../api.md)
