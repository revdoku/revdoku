<?php
require __DIR__ . '/../vendor/autoload.php';
use Revdoku\Api\Api\DefaultApi;
use Revdoku\Api\Configuration;

$key = getenv('REVDOKU_API_KEY');
if (!$key) throw new RuntimeException('Set REVDOKU_API_KEY');
$api = new DefaultApi(null, (new Configuration())->setAccessToken($key));
$result = $api->listMailboxes(getenv('REVDOKU_ACCOUNT_ID') ?: null);
foreach ($result->getData()->getMailboxes() as $mailbox) echo $mailbox->getId(), ' ', $mailbox->getTitle(), PHP_EOL;
