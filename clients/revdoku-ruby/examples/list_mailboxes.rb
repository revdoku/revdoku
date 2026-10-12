require 'set'
require 'revdoku_api'

key = ENV.fetch('REVDOKU_API_KEY')
raise 'Set REVDOKU_API_KEY' if key.empty?
config = RevdokuApi::Configuration.new
config.access_token = key
api = RevdokuApi::DefaultApi.new(RevdokuApi::ApiClient.new(config))
cursor = nil
seen = Set.new
loop do
  page = api.list_mailboxes(account_id: ENV['REVDOKU_ACCOUNT_ID'].to_s.empty? ? nil : ENV['REVDOKU_ACCOUNT_ID'], status: 'active', limit: 100, cursor: cursor).data
  page.mailboxes.each { |mailbox| puts "#{mailbox.id} #{mailbox.email&.address || mailbox.id}" }
  break unless page.pagination.has_more
  cursor = page.pagination.next_cursor
  raise 'Mailbox pagination did not advance' if cursor.to_s.empty? || seen.include?(cursor)
  seen.add(cursor)
end
