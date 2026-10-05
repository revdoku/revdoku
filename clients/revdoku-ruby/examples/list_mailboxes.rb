require 'revdoku_api'

key = ENV.fetch('REVDOKU_API_KEY')
raise 'Set REVDOKU_API_KEY' if key.empty?
config = RevdokuApi::Configuration.new
config.access_token = key
api = RevdokuApi::DefaultApi.new(RevdokuApi::ApiClient.new(config))
result = api.list_mailboxes(account_id: ENV['REVDOKU_ACCOUNT_ID'].to_s.empty? ? nil : ENV['REVDOKU_ACCOUNT_ID'])
result.data.mailboxes.each { |mailbox| puts "#{mailbox.id} #{mailbox.title}" }
