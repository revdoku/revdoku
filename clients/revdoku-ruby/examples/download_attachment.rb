require 'net/http'
require 'uri'
require 'revdoku_api'

key, mailbox, email, attachment, output = %w[REVDOKU_API_KEY REVDOKU_BUCKET_ID REVDOKU_EMAIL_ID REVDOKU_ATTACHMENT_ID REVDOKU_DOWNLOAD_PATH].map { |name| ENV.fetch(name) }
raise 'Set all required environment variables' if [key, mailbox, email, attachment, output].any?(&:empty?)
config = RevdokuApi::Configuration.new
config.access_token = key
api = RevdokuApi::DefaultApi.new(RevdokuApi::ApiClient.new(config))
download = api.download_email_attachment(mailbox, email, attachment,
  account_id: ENV['REVDOKU_ACCOUNT_ID'].to_s.empty? ? nil : ENV['REVDOKU_ACCOUNT_ID']).data.download
url = URI(download.url)
raise 'Expected an HTTPS download without API authentication' unless download.authentication == 'none' && url.is_a?(URI::HTTPS) && url.host && !url.userinfo
# A separate connection keeps API credentials off the signed download request.
response = Net::HTTP.start(url.host, url.port, use_ssl: true, open_timeout: 30, read_timeout: 60) do |http|
  http.get(url.request_uri)
end
raise "Download failed: HTTP #{response.code}" unless response.code == '200'
File.open(output, File::WRONLY | File::CREAT | File::EXCL, 0o600) { |file| file.write(response.body) }
puts output
