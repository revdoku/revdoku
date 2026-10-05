import json
import os
from revdoku_api import ApiClient, Configuration, DefaultApi

key = os.environ["REVDOKU_API_KEY"]
mailbox = os.environ["REVDOKU_BUCKET_ID"]
if not key or not mailbox:
    raise ValueError("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID")
account = os.getenv("REVDOKU_ACCOUNT_ID") or None
with ApiClient(Configuration(access_token=key)) as client:
    api = DefaultApi(client)
    cursor = None
    seen = set()
    while True:
        page = api.list_emails(mailbox, account_id=account, limit=100,
                               order="asc", read=False, cursor=cursor).data
        for summary in page.emails:
            email = api.get_email(mailbox, summary.id, account_id=account).data.email
            print(json.dumps({"id": email.id, "subject": email.subject,
                              "body_status": email.body_status, "body_text": email.body_text,
                              "attachments": [item.to_dict() for item in email.attachments]}, ensure_ascii=False))
        if not page.pagination.has_more:
            break
        cursor = page.pagination.next_cursor
        if not cursor or cursor in seen:
            raise RuntimeError("Email pagination did not advance")
        seen.add(cursor)
# Reading does not change the shared read/unread status.
