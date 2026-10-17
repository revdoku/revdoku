# Python receiving examples

These examples use direct HTTP calls with Python 3.10+ and `requests`. For the Python SDK (`pip install revdoku`), see the [Python SDK guide](https://revdoku.com/docs/sdks/python.md).

```sh
python3 -m venv .venv
. .venv/bin/activate
pip install requests
```

Set `REVDOKU_API_KEY` in your secret manager or local environment, then run:

```sh
python python/create-mailbox.py
export REVDOKU_MAILBOX_ID=bkt_RETURNED_ID
python python/read-mail.py
python python/download-attachment.py eml_RETURNED_ID df_RETURNED_ID attachment.pdf
```

Run from `examples/`. Set `REVDOKU_ACCOUNT_ID` to select another granted account.
Omit the username to generate one. To choose a name, pass it as the argument;
`EMAIL_ALREADY_EXISTS` means it is unavailable. If a creation response is lost,
list your mailboxes before deciding whether to create another one.

Creation prints the mailbox ID and ready receiving address. Reading prints JSON
metadata, attachment IDs and `next_cursor`; `--show-body` also prints body text.
Save the last processed cursor and set `REVDOKU_CURSOR` for the next run. Use the
same filters and deduplicate downstream effects by email ID. GET requests leave
shared read status unchanged. Attachment download prints the saved byte count.

Errors include the API's code and message. For 429 request rate limits, respect `Retry-After`; monthly
allowances require waiting until reset or changing the plan. Never retry a write
blindly. Temporary attachment links expire after 15 minutes and take no API key.
Use [the JavaScript/TypeScript examples](../README.md) for file uploads and a
bounded retry recipe.
