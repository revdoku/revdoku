import 'dart:convert';
import 'dart:io';

import 'package:revdoku_api/api.dart';

Future<void> main() async {
  final key = Platform.environment['REVDOKU_API_KEY'];
  final mailbox = Platform.environment['REVDOKU_BUCKET_ID'];
  if (key == null || key.isEmpty || mailbox == null || mailbox.isEmpty)
    throw StateError('Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID');
  final account = Platform.environment['REVDOKU_ACCOUNT_ID'];
  final client = ApiClient(authentication: HttpBearerAuth()..accessToken = key);
  final api = DefaultApi(client);
  var offset = 0;
  try {
    while (true) {
      final page = (await api.listMailboxFiles(
        mailbox,
        limit: 100,
        offset: offset,
        accountId: account == null || account.isEmpty ? null : account,
      ))!.data;
      for (final file in page.files) print(jsonEncode(file));
      if (!page.pagination.hasMore) break;
      final next = page.pagination.nextOffset;
      if (next == null || next <= offset)
        throw StateError('File pagination did not advance');
      offset = next;
    }
  } finally {
    client.client.close();
  }
}
