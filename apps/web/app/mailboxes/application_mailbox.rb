class ApplicationMailbox < ActionMailbox::Base
  # Match on any recipient header (To / Cc / Bcc / X-Original-To /
  # X-Forwarded-To). Action Mailbox's default regex-matcher only looks at
  # `mail.recipients` which parses from the primary headers — but SES may
  # stash the plus-addressed recipient on X-Original-To after DKIM rewriting,
  # which the built-in matcher misses. Using `recipients_addresses` keeps
  # routing in lockstep with `UploadsMailbox#find_upload_recipient`.
  routing ->(inbound) {
    Array(inbound.mail.recipients_addresses).any? do |addr|
      raw = addr.respond_to?(:address) ? addr.address.to_s : addr.to_s
      raw.match?(/\Auploads(\+[^@]+)?@/i)
    end
  } => :uploads

  # Anything else falls into DefaultMailbox which audit-logs + bounces so we
  # can see silent drops instead of wondering where mail went.
  routing all: :default
end
