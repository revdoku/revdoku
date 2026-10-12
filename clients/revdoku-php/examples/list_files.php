<?php
require __DIR__ . '/../vendor/autoload.php';
use Revdoku\Api\Api\DefaultApi;
use Revdoku\Api\Configuration;

$key = getenv('REVDOKU_API_KEY');
$mailbox = getenv('REVDOKU_BUCKET_ID');
if (!$key || !$mailbox) throw new RuntimeException('Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID');
$api = new DefaultApi(null, (new Configuration())->setAccessToken($key));
$cursor = null;
$seen = [];
while (true) {
    $page = $api->listFiles($mailbox, limit: 100, cursor: $cursor, account_id: getenv('REVDOKU_ACCOUNT_ID') ?: null)->getData();
    foreach ($page->getFiles() as $file) echo json_encode($file, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE), PHP_EOL;
    if (!$page->getPagination()->getHasMore()) break;
    $cursor = $page->getPagination()->getNextCursor();
    if (!$cursor || isset($seen[$cursor])) throw new RuntimeException('File pagination did not advance');
    $seen[$cursor] = true;
}
