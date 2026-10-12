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
  String? cursor;
  final seen = <String>{};
  try {
    while (true) {
      final page = (await api.listFiles(
        mailbox,
        limit: 100,
        cursor: cursor,
        accountId: account == null || account.isEmpty ? null : account,
      ))!.data;
      for (final file in page.files) print(jsonEncode(file));
      if (!page.pagination.hasMore) break;
      cursor = page.pagination.nextCursor;
      if (cursor == null || cursor.isEmpty || !seen.add(cursor))
        throw StateError('File pagination did not advance');
    }
  } finally {
    client.client.close();
  }
}
