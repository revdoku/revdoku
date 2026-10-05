<?php
require __DIR__ . '/../vendor/autoload.php';
use Revdoku\Api\Api\DefaultApi;
use Revdoku\Api\Configuration;
use Revdoku\Api\ApiException;
use Revdoku\Api\Model\CreateMailboxRequest;
use Revdoku\Api\Model\CreateMailboxRequestMailbox;

$key = getenv('REVDOKU_API_KEY');
if (!$key) throw new RuntimeException('Set REVDOKU_API_KEY');
$api = new DefaultApi(null, (new Configuration())->setAccessToken($key));
try {
    $result = $api->createMailbox(new CreateMailboxRequest([
        'account_id' => getenv('REVDOKU_ACCOUNT_ID') ?: null,
        'mailbox' => new CreateMailboxRequestMailbox(['title' => 'Example mailbox']),
    ]));
    echo $result->getData()->getMailbox()->getId(), ' ', $result->getData()->getMailbox()->getEmail()->getAddress(), PHP_EOL;
} catch (ApiException $error) {
    fwrite(STDERR, 'HTTP ' . $error->getCode() . ': ' . $error->getResponseBody() . PHP_EOL);
    foreach (($error->getResponseHeaders() ?: []) as $name => $values) {
        if (strcasecmp($name, 'Retry-After') === 0) fwrite(STDERR, 'Retry-After: ' . implode(', ', (array) $values) . PHP_EOL);
    }
    fwrite(STDERR, "Creation was not confirmed. Check existing mailboxes before another creation attempt." . PHP_EOL);
    exit(1);
} catch (Throwable $error) {
    fwrite(STDERR, "Creation response unavailable. Check existing mailboxes before another creation attempt." . PHP_EOL);
    exit(1);
}
