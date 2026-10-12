import json
import os
from revdoku_api import ApiClient, Configuration, DefaultApi

key = os.environ["REVDOKU_API_KEY"]
mailbox = os.environ["REVDOKU_BUCKET_ID"]
if not key or not mailbox:
    raise ValueError("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID")
with ApiClient(Configuration(access_token=key)) as client:
    api = DefaultApi(client)
    cursor = None
    seen = set()
    while True:
        page = api.list_files(mailbox, account_id=os.getenv("REVDOKU_ACCOUNT_ID") or None,
                              limit=100, cursor=cursor).data
        for file in page.files:
            print(json.dumps(client.sanitize_for_serialization(file), ensure_ascii=False))
        if not page.pagination.has_more:
            break
        cursor = page.pagination.next_cursor
        if not cursor or cursor in seen:
            raise RuntimeError("File pagination did not advance")
        seen.add(cursor)
