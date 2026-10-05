import 'dart:io';

import 'package:revdoku_api/api.dart';

Future<void> main() async {
  final key = Platform.environment['REVDOKU_API_KEY'];
  if (key == null || key.isEmpty) throw StateError('Set REVDOKU_API_KEY');
  final account = Platform.environment['REVDOKU_ACCOUNT_ID'];
  final client = ApiClient(authentication: HttpBearerAuth()..accessToken = key);
  try {
    final result = await DefaultApi(client).createMailbox(
      CreateMailboxRequest(
        accountId: account == null || account.isEmpty ? null : account,
        mailbox: CreateMailboxRequestMailbox(title: 'Example mailbox'),
      ),
    );
    print('${result!.data.mailbox.id} ${result.data.mailbox.email.address}');
  } on ApiException catch (error) {
    stderr.writeln('HTTP ${error.code}: ${error.message}');
    stderr.writeln('Creation was not confirmed. Check existing mailboxes before another creation attempt.');
    exitCode = 1;
  } on Exception {
    stderr.writeln('Creation response unavailable. Check existing mailboxes before another creation attempt.');
    exitCode = 1;
  } finally {
    client.client.close();
  }
}
