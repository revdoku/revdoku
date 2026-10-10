import 'dart:io';
import 'package:revdoku_api/api.dart';

Future<void> main() async {
  final key = Platform.environment['REVDOKU_API_KEY'];
  if (key == null || key.isEmpty) throw StateError('Set REVDOKU_API_KEY');
  final account = Platform.environment['REVDOKU_ACCOUNT_ID'];
  final client = ApiClient(authentication: HttpBearerAuth()..accessToken = key);
  final api = DefaultApi(client);
  var offset = 0;
  try {
    while (true) {
      final page = (await api.listMailboxes(accountId: account == null || account.isEmpty ? null : account, status: 'active', limit: 100, offset: offset))!.data;
      for (final mailbox in page.mailboxes) {
        print('${mailbox.id} ${mailbox.email.address ?? mailbox.id}');
      }
      if (!page.pagination.hasMore) break;
      final next = page.pagination.nextOffset;
      if (next == null || next <= offset) throw StateError('Mailbox pagination did not advance');
      offset = next;
    }
  } finally {
    client.client.close();
  }
}
