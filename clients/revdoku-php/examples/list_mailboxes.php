<?php
require __DIR__ . '/../vendor/autoload.php';
use Revdoku\Api\Api\DefaultApi;
use Revdoku\Api\Configuration;

$key = getenv('REVDOKU_API_KEY');
if (!$key) throw new RuntimeException('Set REVDOKU_API_KEY');
$api = new DefaultApi(null, (new Configuration())->setAccessToken($key));
$offset = 0;
while (true) {
    $page = $api->listMailboxes(account_id: getenv('REVDOKU_ACCOUNT_ID') ?: null, status: 'active', limit: 100, offset: $offset)->getData();
    foreach ($page->getMailboxes() as $mailbox) echo $mailbox->getId(), ' ', ($mailbox->getEmail()?->getAddress() ?? $mailbox->getId()), PHP_EOL;
    if (!$page->getPagination()->getHasMore()) break;
    $next = $page->getPagination()->getNextOffset();
    if ($next === null || $next <= $offset) throw new RuntimeException('Mailbox pagination did not advance');
    $offset = $next;
}
