import 'dart:io';
import 'package:revdoku_api/api.dart';

Future<void> main() async {
  final key = Platform.environment['REVDOKU_API_KEY'];
  if (key == null || key.isEmpty) throw StateError('Set REVDOKU_API_KEY');
  final account = Platform.environment['REVDOKU_ACCOUNT_ID'];
  final client = ApiClient(authentication: HttpBearerAuth()..accessToken = key);
  final api = DefaultApi(client);
  String? cursor;
  final seen = <String>{};
  try {
    while (true) {
      final page = (await api.listMailboxes(accountId: account == null || account.isEmpty ? null : account, status: 'active', limit: 100, cursor: cursor))!.data;
      for (final mailbox in page.mailboxes) {
        print('${mailbox.id} ${mailbox.email.address ?? mailbox.id}');
      }
      if (!page.pagination.hasMore) break;
      cursor = page.pagination.nextCursor;
      if (cursor == null || cursor.isEmpty || !seen.add(cursor)) throw StateError('Mailbox pagination did not advance');
    }
  } finally {
    client.client.close();
  }
}
