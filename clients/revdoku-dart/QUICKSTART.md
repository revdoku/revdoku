[Install and configure this SDK](example/README.md#install-from-source) before running the request below.

## List mailboxes

After source installation and credential setup, run this from the package directory:

```sh
dart run example/list_mailboxes.dart
```

This makes one read request and prints each visible mailbox's ID and title:

```text
bkt_RETURNED_ID My Mailbox
```

[Runnable source](example/list_mailboxes.dart). Reuse one of these mailboxes for the email walkthrough; this request does not create a mailbox or consume creation capacity.

Keep the SDK's default API origin, `https://api.revdoku.com`. Its paths already include `/v1`; setting the SDK base to the REST base `https://api.revdoku.com/v1` would duplicate that prefix.
`REVDOKU_ACCOUNT_ID` is optional and selects an account granted to the key; otherwise its default account applies.
The response retains the API's `data` envelope. Copy one returned mailbox `id` into `REVDOKU_BUCKET_ID` for the walkthrough. An empty mailbox list means there are no visible active mailboxes for this key and account.

[Receive your first email](example/README.md#receive-and-download) · [SDK fields and errors](example/README.md#sdk-fields-and-errors) · [API reference](https://revdoku.com/api.md)
