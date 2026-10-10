require 'revdoku_api'

key = ENV.fetch('REVDOKU_API_KEY')
raise 'Set REVDOKU_API_KEY' if key.empty?
config = RevdokuApi::Configuration.new
config.access_token = key
api = RevdokuApi::DefaultApi.new(RevdokuApi::ApiClient.new(config))
offset = 0
loop do
  page = api.list_mailboxes(account_id: ENV['REVDOKU_ACCOUNT_ID'].to_s.empty? ? nil : ENV['REVDOKU_ACCOUNT_ID'], status: 'active', limit: 100, offset: offset).data
  page.mailboxes.each { |mailbox| puts "#{mailbox.id} #{mailbox.email&.address || mailbox.id}" }
  break unless page.pagination.has_more
  next_offset = page.pagination.next_offset
  raise 'Mailbox pagination did not advance' if next_offset.nil? || next_offset <= offset
  offset = next_offset
end
