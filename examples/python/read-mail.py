"""Read the messages of support tickets without changing a ticket or shared read status."""
import json
import os
import re
import sys
import time
from urllib.parse import quote
import requests

headers = {"Authorization": f"Bearer {os.environ['REVDOKU_API_KEY']}"}
account_id = os.getenv("REVDOKU_ACCOUNT_ID")
bucket_id = os.environ["REVDOKU_BUCKET_ID"]
if not re.fullmatch(r"bkt_[A-Za-z0-9]+", bucket_id):
    raise ValueError("Invalid bucket ID")
tickets_url = f"https://api.revdoku.com/v1/buckets/{bucket_id}/tickets"


def get(url, **params):
    response = requests.get(url, headers=headers, params={"account_id": account_id, **params},
                            timeout=30, allow_redirects=False)
    result = response.json()
    # Retry only a read whose email index is still being prepared.
    for attempt in range(3):
        if response.status_code == 200 or result.get("error", {}).get("code") != "EMAIL_INDEX_BUILDING":
            break
        time.sleep(2 ** attempt)
        response = requests.get(url, headers=headers, params={"account_id": account_id, **params},
                                timeout=30, allow_redirects=False)
        result = response.json()
    if response.status_code != 200:
        raise RuntimeError(f"{result['error']['code']}: {result['error']['message']}")
    return result["data"]


# Tickets with activity after the last check. Save the printed updated_after and pass it on the next run.
updated_after = os.getenv("REVDOKU_UPDATED_AFTER")
newest = updated_after
cursor = None
for page in range(100):
    tickets = get(tickets_url, updated_after=updated_after, cursor=cursor)
    for ticket in tickets["tickets"]:
        ticket_url = f"{tickets_url}/{quote(ticket['id'], safe='')}/messages"
        for summary in get(ticket_url)["messages"]:
            if summary.get("direction") == "sent":
                continue
            if any(label.get("name") == "Junk" for label in summary.get("labels") or []):
                continue  # Junk content is withheld.
            message = get(f"{ticket_url}/{quote(summary['id'], safe='')}")["message"]
            fields = ("id", "subject", "from_addresses", "body_status", "attachments")
            print(json.dumps({"ticket_id": ticket["id"], **{field: message.get(field) for field in fields}}))
            if "--show-body" in sys.argv:
                print(json.dumps({"body_text": message.get("body_text")}))
        if ticket.get("updated_at") and (newest is None or ticket["updated_at"] > newest):
            newest = ticket["updated_at"]
    pagination = tickets["pagination"]
    if not pagination["has_more"]:
        break
    if pagination["next_cursor"] == cursor:
        raise RuntimeError("Cursor did not advance")
    cursor = pagination["next_cursor"]
else:
    raise RuntimeError("Page limit reached; run again with the same updated_after.")
# Persist after processing; a ticket comes back when it gets a new message, so deduplicate work by message ID.
print(json.dumps({"updated_after": newest}))
