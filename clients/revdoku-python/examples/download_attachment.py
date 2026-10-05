import http.client
import os
from urllib.parse import urlsplit
from revdoku_api import ApiClient, Configuration, DefaultApi

key, mailbox, email, attachment, output = [os.environ[name] for name in (
    "REVDOKU_API_KEY", "REVDOKU_BUCKET_ID", "REVDOKU_EMAIL_ID",
    "REVDOKU_ATTACHMENT_ID", "REVDOKU_DOWNLOAD_PATH")]
if not all((key, mailbox, email, attachment, output)):
    raise ValueError("Set all required environment variables")
with ApiClient(Configuration(access_token=key)) as client:
    download = DefaultApi(client).download_email_attachment(
        mailbox, email, attachment, account_id=os.getenv("REVDOKU_ACCOUNT_ID") or None).data.download
url = urlsplit(str(download.url))
if download.authentication != "none" or url.scheme != "https" or not url.hostname or url.username or url.password:
    raise ValueError("Expected an HTTPS download without API authentication")
# Use a separate HTTP connection: the signed URL needs no bearer token or redirects.
connection = http.client.HTTPSConnection(url.hostname, url.port or 443, timeout=60)
try:
    connection.request("GET", url.path + ("?" + url.query if url.query else ""))
    response = connection.getresponse()
    if response.status != 200:
        raise RuntimeError(f"Download failed: HTTP {response.status}")
    content = response.read()
finally:
    connection.close()
with open(output, "xb") as file:
    file.write(content)
print(output)
