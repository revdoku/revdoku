import 'dart:io';
import 'package:revdoku_api/api.dart';

Future<void> main() async {
  final key = Platform.environment['REVDOKU_API_KEY'];
  if (key == null || key.isEmpty) throw StateError('Set REVDOKU_API_KEY');
  final account = Platform.environment['REVDOKU_ACCOUNT_ID'];
  final client = ApiClient(authentication: HttpBearerAuth()..accessToken = key);
  try {
    final result = await DefaultApi(client).listMailboxes(accountId: account == null || account.isEmpty ? null : account);
    for (final mailbox in result!.data.mailboxes) {
      print('${mailbox.id} ${mailbox.title}');
    }
  } finally {
    client.client.close();
  }
}
