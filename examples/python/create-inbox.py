"""Create a mailbox. Success returns its ready receiving address."""
import os
import sys
import requests

username = sys.argv[1] if len(sys.argv) > 1 else None
response = requests.post(
    "https://api.revdoku.com/v1/buckets",
    headers={"Authorization": f"Bearer {os.environ['REVDOKU_API_KEY']}"},
    timeout=30, allow_redirects=False,
    json={"account_id": os.getenv("REVDOKU_ACCOUNT_ID"),
          "bucket": {"email": {"username": username} if username else {}}},
)
result = response.json()
if response.status_code != 201:
    raise RuntimeError(f"{result['error']['code']}: {result['error']['message']}")
inbox = result["data"]["bucket"]
print(f"Bucket: {inbox['id']}")
print(f"Receiving ready: {inbox['email']['address']}")
