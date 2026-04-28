# frozen_string_literal: true

# Shared inbound-email ingress selector. Mirrors the ACTIVE_STORAGE_SERVICE
# pattern: a single env var picks the backend, no edition awareness in
# shared code. Set INBOUND_EMAIL_INGRESS to one of:
#
#   mailgun | postmark | sendgrid | mandrill | relay
#       Push-based providers built into Rails Action Mailbox. The matching
#       handler ships with Rails — no extra dependency.
#
#   (unset / "" / "disabled")
#       Inbound email disabled. Action Mailbox is still loaded so its routes
#       under /rails/action_mailbox/* exist, but no ingress is wired and all
#       those endpoints 404. The Account → Email card renders the per-account
#       address greyed-out with a "Not configured" hint.
#
# Other initializers (running after this one) may register additional
# ingresses they own — `Rails.application.config.action_mailbox.ingress`
# is the single source of truth, queryable via `InboundEmailIngress.configured?`.

module InboundEmailIngress
  DISABLED = %w[disabled].freeze

  module_function

  # Raw provider name from INBOUND_EMAIL_INGRESS, lowercased. Returns nil
  # when unset / blank / explicitly "disabled". Used by the API to label
  # the configured provider for the UI; treat unknown values as opaque.
  def provider
    raw = ENV["INBOUND_EMAIL_INGRESS"].to_s.strip.downcase
    return nil if raw.empty? || DISABLED.include?(raw)
    raw
  end

  # True iff some initializer actually wired an ingress on Action Mailbox.
  # This survives typos / unsupported values gracefully — `configured?`
  # only goes true once a real ingress is in place.
  def configured?
    !!Rails.application.config.action_mailbox.ingress
  end
end

Rails.application.configure do
  case InboundEmailIngress.provider
  when "mailgun", "postmark", "sendgrid", "mandrill", "relay"
    config.action_mailbox.ingress = InboundEmailIngress.provider.to_sym
    Rails.logger&.info("[inbound-email] ingress configured: #{InboundEmailIngress.provider}")
  when nil
    Rails.logger&.info("[inbound-email] no ingress configured — INBOUND_EMAIL_INGRESS unset")
  end
  # Other values are intentionally not handled here — additional
  # initializers may claim them. If nothing claims, the boot finishes with
  # no ingress wired and `InboundEmailIngress.configured?` returns false.
end
