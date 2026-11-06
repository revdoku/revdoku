"""Run the published Flask receiver offline, without changing its source."""
import hashlib
import hmac
import importlib.util
import json
import os
from pathlib import Path
import tempfile
import time
import unittest
from unittest.mock import patch, Mock


class ReceiverTest(unittest.TestCase):
    def test_signatures_duplicates_and_read_failure(self):
        source = Path(__file__).resolve().parents[1] / 'python/webhook-receiver.py'
        previous = os.getcwd()
        with tempfile.TemporaryDirectory() as work, patch.dict(os.environ, {
            'REVDOKU_WEBHOOK_SECRET': 'fixture-secret', 'REVDOKU_API_KEY': 'fixture-key',
            'REVDOKU_BUCKET_ID': 'bkt_fixture', 'REVDOKU_ACCOUNT_ID': 'acct_fixture',
        }):
            os.chdir(work)
            try:
                spec = importlib.util.spec_from_file_location('receiver', source)
                receiver = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(receiver)
                client = receiver.app.test_client()
                body = json.dumps({'id': 'email.received:eml_fixture', 'type': 'email.received',
                    'data': {'bucket_id': 'bkt_fixture', 'account_id': 'acct_fixture', 'email_id': 'eml_fixture'}}).encode()
                timestamp = str(int(time.time()))
                headers = {'X-Revdoku-Event-Id': 'email.received:eml_fixture', 'X-Revdoku-Timestamp': timestamp,
                    'X-Revdoku-Signature': 'v1=' + hmac.new(b'fixture-secret', timestamp.encode() + b'.' + body, hashlib.sha256).hexdigest()}
                with patch.object(receiver.requests, 'get') as get:
                    self.assertEqual(client.post('/webhook', data=body + b' ', headers=headers).status_code, 401)
                    self.assertEqual(client.post('/webhook', data=body, headers={**headers, 'X-Revdoku-Timestamp': '1000000000'}).status_code, 401)
                    self.assertEqual(client.post('/webhook', data=b'x' * 16385, headers=headers).status_code, 413)
                    self.assertEqual(client.post('/webhook', data=body, headers={**headers, 'X-Revdoku-Signature': 'v1=é'}).status_code, 401)
                    get.assert_not_called()
                    get.return_value = Mock(status_code=503)
                    self.assertEqual(client.post('/webhook', data=body, headers=headers).status_code, 503)
                    get.return_value = Mock(status_code=200)
                    get.return_value.json.return_value = {'data': {'email': {'id': 'eml_fixture', 'subject': 'Fixture'}}}
                    with patch('builtins.print'):
                        self.assertEqual(client.post('/webhook', data=body, headers=headers).status_code, 204)
                        self.assertEqual(client.post('/webhook', data=body, headers=headers).status_code, 204)
                    self.assertEqual(get.call_count, 2)
                    self.assertEqual(get.call_args.kwargs['params']['account_id'], 'acct_fixture')
                    self.assertFalse(get.call_args.kwargs['allow_redirects'])
            finally:
                os.chdir(previous)


if __name__ == '__main__':
    unittest.main()
