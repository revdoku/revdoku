"""Download one selected attachment without sending API credentials to storage."""
import os
from pathlib import Path
import re
import sys
from urllib.parse import quote, urlsplit
import requests

if len(sys.argv) != 4:
    raise SystemExit("Usage: download-attachment.py EMAIL_ID ATTACHMENT_ID OUTPUT_PATH")
email_id, attachment_id, output = sys.argv[1:]
bucket_id = os.environ["REVDOKU_BUCKET_ID"]
if not re.fullmatch(r"bkt_[A-Za-z0-9]+", bucket_id):
    raise ValueError("Invalid bucket ID")
response = requests.get(
    f"https://api.revdoku.com/v1/buckets/{bucket_id}/emails/{quote(email_id, safe='')}/attachments/{quote(attachment_id, safe='')}",
    headers={"Authorization": f"Bearer {os.environ['REVDOKU_API_KEY']}"},
    params={"account_id": os.getenv("REVDOKU_ACCOUNT_ID")}, timeout=30, allow_redirects=False,
)
result = response.json()
if response.status_code != 200:
    raise RuntimeError(f"{result['error']['code']}: {result['error']['message']}")
attachment = result["data"]["download"]
url = urlsplit(attachment["url"])
if url.scheme != "https" or url.username or url.password:
    raise ValueError("Invalid download URL")
# Temporary links work without the API key. Do not log the link or follow redirects.
created = False
try:
    with requests.get(attachment["url"], timeout=30, allow_redirects=False, stream=True) as download:
        if download.status_code != 200:
            raise RuntimeError(f"Download HTTP {download.status_code}")
        destination = os.open(output, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
        created = True
        with os.fdopen(destination, "wb") as file:
            size = 0
            for chunk in download.iter_content(65536):
                size += len(chunk)
                if size > 41 * 1024 * 1024:
                    raise RuntimeError("Attachment exceeds the download limit")
                file.write(chunk)
except Exception:
    if created:
        Path(output).unlink(missing_ok=True)
    raise RuntimeError("Download failed. Request a fresh link and retry with a new output path.") from None
print(f"Saved {size} bytes to {output}")
