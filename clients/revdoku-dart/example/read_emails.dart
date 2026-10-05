import 'dart:convert';
import 'dart:io';

import 'package:revdoku_api/api.dart';

Future<void> main() async {
  final key = Platform.environment['REVDOKU_API_KEY'];
  final mailbox = Platform.environment['REVDOKU_BUCKET_ID'];
  if (key == null || key.isEmpty || mailbox == null || mailbox.isEmpty)
    throw StateError('Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID');
  var account = Platform.environment['REVDOKU_ACCOUNT_ID'];
  if (account == '') account = null;
  final client = ApiClient(authentication: HttpBearerAuth()..accessToken = key);
  final api = DefaultApi(client);
  String? cursor;
  final seen = <String>{};
  try {
    while (true) {
      final page = (await api.listEmails(
        mailbox,
        accountId: account,
        limit: 100,
        order: 'asc',
        read: false,
        cursor: cursor,
      ))!.data;
      for (final summary in page.emails) {
        final email = (await api.getEmail(
          mailbox,
          summary.id,
          accountId: account,
        ))!.data.email;
        print(jsonEncode(email));
      }
      if (!page.pagination.hasMore) break;
      cursor = page.pagination.nextCursor;
      if (cursor.isEmpty || !seen.add(cursor))
        throw StateError('Email pagination did not advance');
    }
  } finally {
    client.client.close();
  }
  // Reading does not change shared read/unread status.
}
