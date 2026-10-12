import os
from revdoku_api import ApiClient, Configuration, DefaultApi

key = os.environ["REVDOKU_API_KEY"]
if not key:
    raise ValueError("Set REVDOKU_API_KEY")
with ApiClient(Configuration(access_token=key)) as client:
    api = DefaultApi(client)
    cursor = None
    seen = set()
    while True:
        page = api.list_mailboxes(account_id=os.getenv("REVDOKU_ACCOUNT_ID") or None, status="active", limit=100, cursor=cursor).data
        for mailbox in page.mailboxes:
            print(mailbox.id, mailbox.email.address if mailbox.email and mailbox.email.address else mailbox.id)
        if not page.pagination.has_more:
            break
        cursor = page.pagination.next_cursor
        if not cursor or cursor in seen:
            raise ValueError("Mailbox pagination did not advance")
        seen.add(cursor)
