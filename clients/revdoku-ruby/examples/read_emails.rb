require 'json'
require 'set'
require 'revdoku_api'

key = ENV.fetch('REVDOKU_API_KEY')
mailbox = ENV.fetch('REVDOKU_BUCKET_ID')
raise 'Set REVDOKU_API_KEY and REVDOKU_BUCKET_ID' if key.empty? || mailbox.empty?
account = ENV['REVDOKU_ACCOUNT_ID'].to_s.empty? ? nil : ENV['REVDOKU_ACCOUNT_ID']
config = RevdokuApi::Configuration.new
config.access_token = key
api = RevdokuApi::DefaultApi.new(RevdokuApi::ApiClient.new(config))
cursor = nil
seen = Set.new
loop do
  page = api.list_emails(mailbox, account_id: account, limit: 100, order: 'asc', read: false, cursor: cursor).data
  page.emails.each do |summary|
    email = api.get_email(mailbox, summary.id, account_id: account).data.email
    puts JSON.generate(id: email.id, subject: email.subject, body_status: email.body_status,
                       body_text: email.body_text, attachments: email.attachments.map(&:to_hash))
  end
  break unless page.pagination.has_more
  cursor = page.pagination.next_cursor
  raise 'Email pagination did not advance' if cursor.to_s.empty? || seen.include?(cursor)
  seen.add(cursor)
end
# Reading leaves shared read/unread status unchanged.
