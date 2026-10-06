import os
import sys
from revdoku_api import ApiClient, Configuration, DefaultApi, CreateMailboxRequest, MailboxCreateOptions
from revdoku_api.exceptions import ApiException

key = os.environ["REVDOKU_API_KEY"]
if not key:
    raise ValueError("Set REVDOKU_API_KEY")
try:
    with ApiClient(Configuration(access_token=key)) as client:
        result = DefaultApi(client).create_mailbox(CreateMailboxRequest(
            account_id=os.getenv("REVDOKU_ACCOUNT_ID") or None,
            mailbox=MailboxCreateOptions(),
        ))
        print(result.data.mailbox.id, result.data.mailbox.email.address)
except ApiException as error:
    print(f"HTTP {error.status}: {error.body}", file=sys.stderr)
    delay = (error.headers or {}).get("Retry-After")
    if delay:
        print(f"Retry-After: {delay}", file=sys.stderr)
    print("Creation was not confirmed. Check existing mailboxes before another creation attempt.", file=sys.stderr)
    sys.exit(1)
except Exception:
    print("Creation response unavailable. Check existing mailboxes before another creation attempt.", file=sys.stderr)
    sys.exit(1)
