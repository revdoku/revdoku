"""Single-process Flask example: pip install flask requests"""
import hashlib
import hmac
import json
import os
import re
import sqlite3
import threading
import time

import requests
from flask import Flask, request

app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 16384
secret = os.environ['REVDOKU_WEBHOOK_SECRET']
api_key = os.environ['REVDOKU_API_KEY']
mailbox_id = os.environ['REVDOKU_BUCKET_ID']
account_id = os.environ.get('REVDOKU_ACCOUNT_ID')
os.makedirs('.revdoku-examples', mode=0o700, exist_ok=True)
lock = threading.Lock()
with sqlite3.connect('.revdoku-examples/webhooks.sqlite3') as db:
    db.execute('CREATE TABLE IF NOT EXISTS processed (id TEXT PRIMARY KEY)')


@app.post('/webhook')
def webhook():
    body = request.get_data()
    timestamp = request.headers.get('X-Revdoku-Timestamp', '')
    signature = request.headers.get('X-Revdoku-Signature', '')
    if not re.fullmatch(r'\d{10}', timestamp) or abs(time.time() - int(timestamp)) > 300:
        return '', 401
    expected = 'v1=' + hmac.new(secret.encode(), timestamp.encode() + b'.' + body, hashlib.sha256).hexdigest()
    if not re.fullmatch(r'v1=[a-f0-9]{64}', signature) or not hmac.compare_digest(expected, signature):
        return '', 401
    try:
        event = json.loads(body)
        data = event['data']
        if (event['type'] != 'email.received' or data['mailbox_id'] != mailbox_id
                or (account_id and data['account_id'] != account_id)
                or event['id'] != request.headers.get('X-Revdoku-Event-Id')
                or not re.fullmatch(r'eml_[A-Za-z0-9]+', data['email_id'])):
            return '', 400
    except (ValueError, KeyError, TypeError):
        return '', 400
    # Keep duplicate work out of this single process. Multiple workers need a
    # shared durable queue and deduplication in the application's existing DB.
    if not lock.acquire(blocking=False):
        return '', 503, {'Retry-After': '5'}
    try:
        with sqlite3.connect('.revdoku-examples/webhooks.sqlite3') as db:
            if db.execute('SELECT 1 FROM processed WHERE id = ?', (event['id'],)).fetchone():
                return '', 204
            response = requests.get(
                f"https://api.revdoku.com/v1/mailboxes/{mailbox_id}/emails/{data['email_id']}",
                params={'account_id': data['account_id'], 'purpose': 'background'},
                headers={'Authorization': f'Bearer {api_key}'}, timeout=8, allow_redirects=False)
            if response.status_code != 200:
                return '', 503, {'Retry-After': '5'}
            email = response.json()['data']['email']
            print(json.dumps({'id': email['id'], 'subject': email.get('subject')}), flush=True)
            # Deduplicate downstream effects by email ID too: a process crash
            # after the effect but before this commit may repeat it.
            db.execute('INSERT INTO processed VALUES (?)', (event['id'],))
        return '', 204
    except (requests.RequestException, sqlite3.Error, ValueError, KeyError):
        return '', 503, {'Retry-After': '5'}
    finally:
        lock.release()


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=False)
