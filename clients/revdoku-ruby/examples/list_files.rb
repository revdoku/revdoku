require 'json'
require 'set'
require 'revdoku_api'

key = ENV.fetch('REVDOKU_API_KEY')
mailbox = ENV.fetch('REVDOKU_BUCKET_ID')
raise 'Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID' if key.empty? || mailbox.empty?
config = RevdokuApi::Configuration.new
config.access_token = key
api = RevdokuApi::DefaultApi.new(RevdokuApi::ApiClient.new(config))
cursor = nil
seen = Set.new
loop do
  page = api.list_files(mailbox, limit: 100, cursor: cursor,
    account_id: ENV['REVDOKU_ACCOUNT_ID'].to_s.empty? ? nil : ENV['REVDOKU_ACCOUNT_ID']).data
  page.files.each { |file| puts JSON.generate(file) }
  break unless page.pagination.has_more
  cursor = page.pagination.next_cursor
  raise 'File pagination did not advance' if cursor.to_s.empty? || seen.include?(cursor)
  seen.add(cursor)
end
