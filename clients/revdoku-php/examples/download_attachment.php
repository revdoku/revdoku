<?php
require __DIR__ . '/../vendor/autoload.php';
use Revdoku\Api\Api\DefaultApi;
use Revdoku\Api\Configuration;
use GuzzleHttp\Client;

foreach (['REVDOKU_API_KEY', 'REVDOKU_BUCKET_ID', 'REVDOKU_EMAIL_ID', 'REVDOKU_ATTACHMENT_ID', 'REVDOKU_DOWNLOAD_PATH'] as $name) {
    if (!getenv($name)) throw new RuntimeException('Set ' . $name);
}
$api = new DefaultApi(null, (new Configuration())->setAccessToken(getenv('REVDOKU_API_KEY')));
$download = $api->getEmailAttachmentDownloadUrl(getenv('REVDOKU_BUCKET_ID'), getenv('REVDOKU_EMAIL_ID'),
    getenv('REVDOKU_ATTACHMENT_ID'), account_id: getenv('REVDOKU_ACCOUNT_ID') ?: null)->getData()->getDownload();
$url = parse_url((string) $download->getUrl());
if ($download->getAuthentication() !== 'none' || !$url || ($url['scheme'] ?? '') !== 'https' || empty($url['host']) || isset($url['user']) || isset($url['pass'])) {
    throw new RuntimeException('Expected an HTTPS download without API authentication');
}
// Separate client: no API token and no redirects on the signed download.
$response = (new Client())->get((string) $download->getUrl(), ['allow_redirects' => false, 'timeout' => 60]);
if ($response->getStatusCode() !== 200) throw new RuntimeException('Download failed: HTTP ' . $response->getStatusCode());
$bytes = (string) $response->getBody();
$file = fopen(getenv('REVDOKU_DOWNLOAD_PATH'), 'xb');
if ($file === false) throw new RuntimeException('Cannot create download file');
try {
    if (fwrite($file, $bytes) !== strlen($bytes)) throw new RuntimeException('Incomplete file write');
} finally {
    fclose($file);
}
echo getenv('REVDOKU_DOWNLOAD_PATH'), PHP_EOL;
