import os
from revdoku_api import ApiClient, Configuration, DefaultApi

key = os.environ["REVDOKU_API_KEY"]
if not key:
    raise ValueError("Set REVDOKU_API_KEY")
with ApiClient(Configuration(access_token=key)) as client:
    result = DefaultApi(client).list_mailboxes(account_id=os.getenv("REVDOKU_ACCOUNT_ID") or None)
    for mailbox in result.data.mailboxes:
        print(mailbox.id, mailbox.title)
