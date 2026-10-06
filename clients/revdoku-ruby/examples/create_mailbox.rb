require 'revdoku_api'

key = ENV.fetch('REVDOKU_API_KEY')
raise 'Set REVDOKU_API_KEY' if key.empty?
config = RevdokuApi::Configuration.new
config.access_token = key
api = RevdokuApi::DefaultApi.new(RevdokuApi::ApiClient.new(config))
begin
  result = api.create_mailbox(RevdokuApi::CreateMailboxRequest.new(
    account_id: ENV['REVDOKU_ACCOUNT_ID'].to_s.empty? ? nil : ENV['REVDOKU_ACCOUNT_ID'],
    mailbox: RevdokuApi::MailboxCreateOptions.new
  ))
  puts "#{result.data.mailbox.id} #{result.data.mailbox.email.address}"
rescue RevdokuApi::ApiError => error
  warn "HTTP #{error.code}: #{error.response_body}"
  (error.response_headers || {}).each do |name, value|
    warn "Retry-After: #{value}" if name.downcase == 'retry-after'
  end
  warn 'Creation was not confirmed. Check existing mailboxes before another creation attempt.'
  exit 1
rescue StandardError
  warn 'Creation response unavailable. Check existing mailboxes before another creation attempt.'
  exit 1
end
