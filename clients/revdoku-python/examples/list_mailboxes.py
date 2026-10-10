import os
from revdoku_api import ApiClient, Configuration, DefaultApi

key = os.environ["REVDOKU_API_KEY"]
if not key:
    raise ValueError("Set REVDOKU_API_KEY")
with ApiClient(Configuration(access_token=key)) as client:
    api = DefaultApi(client)
    offset = 0
    while True:
        page = api.list_mailboxes(account_id=os.getenv("REVDOKU_ACCOUNT_ID") or None, status="active", limit=100, offset=offset).data
        for mailbox in page.mailboxes:
            print(mailbox.id, mailbox.email.address if mailbox.email else mailbox.id)
        if not page.pagination.has_more:
            break
        next_offset = page.pagination.next_offset
        if next_offset is None or next_offset <= offset:
            raise ValueError("Mailbox pagination did not advance")
        offset = next_offset
