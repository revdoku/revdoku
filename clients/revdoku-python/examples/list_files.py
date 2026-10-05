import json
import os
from revdoku_api import ApiClient, Configuration, DefaultApi

key = os.environ["REVDOKU_API_KEY"]
mailbox = os.environ["REVDOKU_BUCKET_ID"]
if not key or not mailbox:
    raise ValueError("Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID")
with ApiClient(Configuration(access_token=key)) as client:
    api = DefaultApi(client)
    offset = 0
    while True:
        page = api.list_mailbox_files(mailbox, account_id=os.getenv("REVDOKU_ACCOUNT_ID") or None,
                                     limit=100, offset=offset).data
        for file in page.files:
            print(json.dumps(file, ensure_ascii=False))
        if not page.pagination.has_more:
            break
        next_offset = page.pagination.next_offset
        if next_offset is None or next_offset <= offset:
            raise RuntimeError("File pagination did not advance")
        offset = next_offset
