import 'dart:io';

import 'package:revdoku_api/api.dart';

Future<void> main() async {
  final env = Platform.environment;
  for (final name in [
    'REVDOKU_API_KEY',
    'REVDOKU_BUCKET_ID',
    'REVDOKU_EMAIL_ID',
    'REVDOKU_ATTACHMENT_ID',
    'REVDOKU_DOWNLOAD_PATH',
  ]) {
    if (env[name] == null || env[name]!.isEmpty) throw StateError('Set $name');
  }
  final account = env['REVDOKU_ACCOUNT_ID'];
  final client = ApiClient(
    authentication: HttpBearerAuth()..accessToken = env['REVDOKU_API_KEY']!,
  );
  late EmailDownload download;
  try {
    download = (await DefaultApi(client).getEmailAttachmentDownloadUrl(
      env['REVDOKU_BUCKET_ID']!,
      env['REVDOKU_EMAIL_ID']!,
      env['REVDOKU_ATTACHMENT_ID']!,
      accountId: account == null || account.isEmpty ? null : account,
    ))!.data.download;
  } finally {
    client.client.close();
  }
  final url = Uri.parse(download.url);
  if (download.authentication != EmailDownloadAuthenticationEnum.none ||
      url.scheme != 'https' ||
      url.host.isEmpty ||
      url.userInfo.isNotEmpty) {
    throw StateError('Expected an HTTPS download without API authentication');
  }
  // A separate client sends no API token and follows no redirects.
  final http = HttpClient()..connectionTimeout = const Duration(seconds: 30);
  try {
    final request = await http.getUrl(url);
    request.followRedirects = false;
    final response = await request.close().timeout(const Duration(seconds: 60));
    if (response.statusCode != 200)
      throw StateError('Download failed: HTTP ${response.statusCode}');
    final bytes = await response.fold<List<int>>(
      [],
      (data, chunk) => data..addAll(chunk),
    );
    final file = await File(env['REVDOKU_DOWNLOAD_PATH']!)
        .create(exclusive: true);
    await file.writeAsBytes(bytes, flush: true);
    print(file.path);
  } finally {
    http.close(force: true);
  }
}
