# Ticket events

Hosted applications receive signed HTTP webhooks. Local projects open an outbound
WebSocket through Rails Action Cable; no public domain or tunnel is required.
Both deliver the same event after the complete message and its attachments are saved:
`ticket.created` for the first message of a new ticket and `ticket.message_received` for a later message.
A ticket starts with an email, a message left on the docs site (`channel` `chat`) or page feedback.
Read contents through the ticket API.

| Endpoint | Permission | Result |
| --- | --- | --- |
| GET /v1/buckets/:bucket_id/webhook | Bucket admin | Endpoint, or webhook: null; excludes the signing secret. |
| PUT /v1/buckets/:bucket_id/webhook | Bucket admin | Set one URL; returns the endpoint and signing secret. |
| DELETE /v1/buckets/:bucket_id/webhook | Bucket admin | Disable delivery; 200 with data.deleted and data.id (the bucket ID). |
| GET /v1/buckets/:bucket_id/events/subscription | Bucket read | Signed subscription token valid for 60 seconds. |

Requests go to `https://api.revdoku.com`. Every path starts with `/v1`, for
example `https://api.revdoku.com/v1/buckets`. Use your normal bearer API key.
Select another granted account with account_id in
the query for GET/DELETE, or in the JSON body for PUT. Endpoints must use public
HTTPS, including explicit ports such as 8443, with no URL user/password or fragment. Local/private addresses
and redirects are rejected. Invalid configuration returns INVALID_ARGUMENT (422).

| PUT field | Meaning |
| --- | --- |
| webhook_url | Required public HTTPS receiver URL, up to 2048 bytes. |
| rotate_secret | Optional boolean, default false. Replace the secret even when the URL is unchanged; pending deliveries are canceled. |
| account_id | Optional explicitly granted account; defaults to the credential's account. |

### Hosted application workflow

1. Implement an HTTPS POST receiver.
2. PUT {"webhook_url":"https://example.org/ticket-events"} to configure it. Securely save
   data.webhook.signing_secret. Repeating PUT with the same URL retains the secret
   and does not return it again; replacing the URL rotates it and cancels pending
   old-endpoint deliveries.
3. Verify the exact request bytes before parsing JSON.
4. Deduplicate the event ID, durably accept the event, and return any 2xx.
5. Fetch /v1/buckets/:bucket_id/tickets/:ticket_id/messages/:message_id with your own API key.

~~~json
{
  "id": "ticket.created:eml_example",
  "type": "ticket.created",
  "created_at": "2026-10-01T12:00:00.000000Z",
  "data": {
    "account_id": "acct_example",
    "bucket_id": "bkt_example",
    "ticket_id": "tkt_example",
    "message_id": "eml_example",
    "channel": "email",
    "received_at": "2026-10-01T11:59:58.000000Z",
    "attachment_count": 1
  }
}
~~~

| Field | Meaning |
| --- | --- |
| id | Stable event ID for deduplication; unchanged on retries. |
| type | ticket.created (the first message of a new ticket) or ticket.message_received (a later message). |
| created_at | UTC time when intake queued the event. |
| data.account_id, data.bucket_id | Account and bucket that saved the message. |
| data.ticket_id | The ticket of the message. |
| data.message_id | Stable message ID for the read endpoint. |
| data.channel | email, chat or feedback: how the message arrived. |
| data.received_at | UTC receipt time. |
| data.attachment_count | Number of saved attachments. |

While the AI filter is on for the account, an event waits until the filter has checked the
message, at most one minute. A message labeled Junk sends no event; if a person removes the
Junk label, the event is sent then.

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
| Buckets with a webhook | Existing active-mailbox capacity; read `limits.max_buckets`. |
| Endpoints per bucket | One. |
| New ticket events | Follow accepted messages within incoming count, byte and storage limits. |
| Delivery history | Read `limits.audit_retention_days`. |

Webhook capacity follows the account's existing mailbox and incoming-email limits, including overrides and shared billing. There is no separate webhook event allowance.

Delivery history is available in **Analytics → Webhooks**.

### Local project workflow

1. GET a subscription token (`data.subscription.token`) with your read-authorized API key.
2. Open the returned `websocket_url`, adding `subscription_token=TOKEN`
   within 60 seconds, using the `actioncable-v1-json` subprotocol.
3. Subscribe to BucketEventsChannel with the returned account_id and bucket_id.
   Wait for confirm_subscription.
4. List tickets with `updated_after` set to your saved last check time and process every page.
   Deduplicate message IDs against live events received during catch-up.
5. Handle each live event and fetch its message through REST.
6. On a temporary disconnect, get a fresh token, reconnect, and repeat the catch-up. Stop if the server rejects the subscription or sends `reconnect: false`.

Runnable [JavaScript/TypeScript and Python examples](https://github.com/revdoku/revdoku/tree/main/examples) cover signed receivers and reconnects. The Node `watch-mail.js` example waits for subscription confirmation, catches up with a saved check time, detects stale connections, and requests a fresh subscription token on reconnect.

| Client guard | Limit |
| --- | --- |
| Duplicate bucket subscriptions | One per connection |
| Bucket subscriptions | 32 per connection; a token authorizes one bucket |
| Connections | 32 per credential per web process |
| Handshakes | 120 per minute per source IP |
| Client commands | 120 per minute per connection; 4 KiB maximum per command |

Keep the account and bucket unchanged between checks, and save the last check time. WebSocket events are live hints; REST catch-up with `updated_after` supplies messages received while disconnected.

Token expiry limits connection establishment; an established subscription lasts
until disconnect or access revocation. Credentials and membership are checked before
each transmitted event. Treat the token as a temporary credential: it authorizes
only its selected bucket channel, never account notification streams.


[API guide](https://revdoku.com/api.md) · [API reference](https://revdoku.com/api/reference.md)
