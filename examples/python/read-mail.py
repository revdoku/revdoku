"""Read message metadata and selected bodies without changing shared read status."""
import json
import os
import re
import sys
from urllib.parse import quote
import requests

headers = {"Authorization": f"Bearer {os.environ['REVDOKU_API_KEY']}"}
account_id = os.getenv("REVDOKU_ACCOUNT_ID")
bucket_id = os.environ["REVDOKU_BUCKET_ID"]
if not re.fullmatch(r"bkt_[A-Za-z0-9]+", bucket_id):
    raise ValueError("Invalid bucket ID")
cursor = os.getenv("REVDOKU_CURSOR")
for page in range(100):
    response = requests.get(
        f"https://api.revdoku.com/v1/buckets/{bucket_id}/emails", headers=headers,
        params={"account_id": account_id, "cursor": cursor}, timeout=30, allow_redirects=False,
    )
    result = response.json()
    if response.status_code != 200:
        raise RuntimeError(f"{result['error']['code']}: {result['error']['message']}")
    for summary in result["data"]["emails"]:
        response = requests.get(
            f"https://api.revdoku.com/v1/buckets/{bucket_id}/emails/{quote(summary['id'], safe='')}",
            headers=headers, params={"account_id": account_id}, timeout=30, allow_redirects=False,
        )
        detail = response.json()
        if response.status_code != 200:
            raise RuntimeError(f"{detail['error']['code']}: {detail['error']['message']}")
        email = detail["data"]["email"]
        fields = ("id", "subject", "from", "body_status", "attachments")
        print(json.dumps({field: email.get(field) for field in fields}))
        if "--show-body" in sys.argv:
            print(json.dumps({"body_text": email.get("body_text")}))
    pagination = result["data"]["pagination"]
    if pagination["has_more"] and pagination["next_cursor"] == cursor:
        raise RuntimeError("Cursor did not advance")
    cursor = pagination["next_cursor"]
    # Persist after processing; deduplicate downstream work by email ID.
    print(json.dumps({"next_cursor": cursor}))
    if not pagination["has_more"]:
        break
else:
    raise RuntimeError("Page limit reached; resume using the last next_cursor.")
