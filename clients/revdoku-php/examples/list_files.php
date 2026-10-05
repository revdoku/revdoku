<?php
require __DIR__ . '/../vendor/autoload.php';
use Revdoku\Api\Api\DefaultApi;
use Revdoku\Api\Configuration;

$key = getenv('REVDOKU_API_KEY');
$mailbox = getenv('REVDOKU_BUCKET_ID');
if (!$key || !$mailbox) throw new RuntimeException('Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID');
$api = new DefaultApi(null, (new Configuration())->setAccessToken($key));
$offset = 0;
while (true) {
    $page = $api->listMailboxFiles($mailbox, limit: 100, offset: $offset, account_id: getenv('REVDOKU_ACCOUNT_ID') ?: null)->getData();
    foreach ($page->getFiles() as $file) echo json_encode($file, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE), PHP_EOL;
    if (!$page->getPagination()->getHasMore()) break;
    $next = $page->getPagination()->getNextOffset();
    if ($next === null || $next <= $offset) throw new RuntimeException('File pagination did not advance');
    $offset = $next;
}
