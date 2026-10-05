<?php
require __DIR__ . '/../vendor/autoload.php';
use Revdoku\Api\Api\DefaultApi;
use Revdoku\Api\Configuration;

$key = getenv('REVDOKU_API_KEY');
$mailbox = getenv('REVDOKU_BUCKET_ID');
if (!$key || !$mailbox) throw new RuntimeException('Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID');
$account = getenv('REVDOKU_ACCOUNT_ID') ?: null;
$api = new DefaultApi(null, (new Configuration())->setAccessToken($key));
$cursor = null;
$seen = [];
while (true) {
    $page = $api->listEmails($mailbox, account_id: $account, limit: 100, cursor: $cursor, order: 'asc', read: false)->getData();
    foreach ($page->getEmails() as $summary) {
        $email = $api->getEmail($mailbox, $summary->getId(), account_id: $account)->getData()->getEmail();
        echo json_encode($email, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE), PHP_EOL;
    }
    if (!$page->getPagination()->getHasMore()) break;
    $cursor = $page->getPagination()->getNextCursor();
    if (!$cursor || isset($seen[$cursor])) throw new RuntimeException('Email pagination did not advance');
    $seen[$cursor] = true;
}
// Reading does not change shared read/unread status.
