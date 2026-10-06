# Quickstart

Clone [the SDK repository](https://github.com/revdoku/revdoku-rust) and enter its directory.

Requires a current stable Rust toolchain. From the cloned package directory:

```sh
cargo build --manifest-path examples/Cargo.toml
```

Set `REVDOKU_API_KEY` in your environment.

## List mailboxes

After source installation and credential setup, run this from the package directory:

```sh
cargo run --manifest-path examples/Cargo.toml --bin list_mailboxes
```

This makes one read request and prints each visible mailbox's ID and email address:

```text
bkt_RETURNED_ID example@revdokumail.com
```

[Runnable source](examples/src/bin/list_mailboxes.rs). Reuse one of these mailboxes for the email walkthrough; this request does not create a mailbox or consume creation capacity.

Keep the SDK's default API origin, `https://api.revdoku.com`. Its paths already include `/v1`; setting the SDK base to the REST base `https://api.revdoku.com/v1` would duplicate that prefix.
`REVDOKU_ACCOUNT_ID` is optional and selects an account granted to the key; otherwise its default account applies.
The response retains the API's `data` envelope. Copy one returned mailbox `id` into `REVDOKU_BUCKET_ID` for the walkthrough. An empty mailbox list means there are no visible active mailboxes for this key and account.

[Receive your first email](examples/README.md#receive-and-download) · [SDK fields and errors](examples/README.md#sdk-fields-and-errors) · [API reference](https://revdoku.com/api.md)
