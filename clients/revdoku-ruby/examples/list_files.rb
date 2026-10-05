require 'json'
require 'revdoku_api'

key = ENV.fetch('REVDOKU_API_KEY')
mailbox = ENV.fetch('REVDOKU_BUCKET_ID')
raise 'Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID' if key.empty? || mailbox.empty?
config = RevdokuApi::Configuration.new
config.access_token = key
api = RevdokuApi::DefaultApi.new(RevdokuApi::ApiClient.new(config))
offset = 0
loop do
  page = api.list_mailbox_files(mailbox, limit: 100, offset: offset,
    account_id: ENV['REVDOKU_ACCOUNT_ID'].to_s.empty? ? nil : ENV['REVDOKU_ACCOUNT_ID']).data
  page.files.each { |file| puts JSON.generate(file) }
  break unless page.pagination.has_more
  next_offset = page.pagination.next_offset
  raise 'File pagination did not advance' if next_offset.nil? || next_offset <= offset
  offset = next_offset
end
