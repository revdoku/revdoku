# frozen_string_literal: true

require "cgi"

module Revdoku
  module LocalAccess
    PURPOSE = "revdoku-local-access"
    TOKEN_TTL = 2.minutes
    LOCAL_EMAIL = "local@revdoku.local"

    Result = Struct.new(:user, :error, keyword_init: true) do
      def success?
        !!user
      end
    end

    module_function

    def issue_url!
      raise "Local access is not enabled" unless Revdoku.local_access_enabled?

      nonce = SecureRandom.urlsafe_base64(32)
      Rails.cache.write(cache_key(nonce), true, expires_in: TOKEN_TTL)
      token = verifier.generate({ "nonce" => nonce }, purpose: PURPOSE, expires_in: TOKEN_TTL)

      "#{Revdoku.local_access_base_url}/users/local_access?local_access_token=#{CGI.escape(token)}"
    end

    def consume!(token, request:)
      return Result.new(error: "Local access is not enabled.") unless Revdoku.local_access_enabled?
      return Result.new(error: "Local access is only available from localhost.") unless request_allowed?(request)

      nonce = verified_nonce(token)
      return Result.new(error: "This local access link is invalid or expired.") unless nonce
      return Result.new(error: "This local access link has already been used.") unless consume_nonce(nonce)

      Result.new(user: local_user!)
    rescue => e
      Rails.logger.warn("[LocalAccess] failed: #{e.class}: #{e.message}")
      Result.new(error: e.message.presence || "Local access failed.")
    end

    def request_allowed?(request)
      Revdoku.local_access_host_allowed?(request.host)
    end

    def local_user!
      if (user = User.find_by(email: LOCAL_EMAIL))
        return prepare_user!(user)
      end

      users = User.order(:id).to_a
      return create_local_user! if users.empty?
      return prepare_user!(users.first) if users.one?

      raise "Local access cannot choose between multiple users. Sign in normally."
    end

    def create_local_user!
      password = SecureRandom.base64(48)
      user = User.new(
        email: LOCAL_EMAIL,
        first_name: "Local",
        last_name: "User",
        password: password,
        password_confirmation: password
      )
      user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
      user.skip_confirmation_notification! if user.respond_to?(:skip_confirmation_notification!)
      user.save!
      prepare_user!(user)
    end

    def prepare_user!(user)
      user.complete_account_setup!
      user.reload
    end

    def verified_nonce(token)
      payload = verifier.verified(token.to_s, purpose: PURPOSE)
      payload.is_a?(Hash) ? payload["nonce"].presence : nil
    end

    def consume_nonce(nonce)
      key = cache_key(nonce)
      return false unless Rails.cache.read(key)

      Rails.cache.delete(key)
      true
    end

    def cache_key(nonce)
      "revdoku:local_access:#{nonce}"
    end

    def verifier
      secret = ENV.fetch("REVDOKU_LOCAL_ACCESS_SECRET")
      ActiveSupport::MessageVerifier.new(secret, digest: "SHA256", serializer: JSON)
    end
  end
end
