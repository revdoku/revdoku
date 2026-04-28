# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.font_src    :self, :data
    policy.img_src     :self, :data, :blob
    policy.object_src  :none
    policy.script_src  :self
    policy.connect_src :self, :blob

    # Allow @vite/client to hot reload javascript changes in development
    if Rails.env.development?
      policy.script_src  *policy.script_src, :unsafe_eval, "http://#{ViteRuby.config.host_with_port}"
      policy.connect_src *policy.connect_src, "ws://#{ViteRuby.config.host_with_port}", "http://#{ViteRuby.config.host_with_port}"
    end

    # Allow blob: for PDF.js worker
    policy.script_src *policy.script_src, :blob if Rails.env.test?
    policy.worker_src :self, :blob

    # Allow inline styles for PDF.js rendering and shadcn/ui components
    policy.style_src :self, :unsafe_inline
  end

  # Generate nonces for inline scripts
  config.content_security_policy_nonce_generator = ->(request) { SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w[script-src]

  # Enforce the Content Security Policy
  config.content_security_policy_report_only = false
end

# Apply edition-specific CSP extensions AFTER all initializers have loaded.
# Rails sorts initializers by full path, so this file (apps/web/config/...)
# runs before any sibling-edition initializers (apps/web/ee/config/...) — at
# the time the policy block above executes, only the no-op
# extend_content_security_policy from 00_revdoku.rb is in scope. Any override
# in a later-loaded initializer is not registered yet. Deferring to
# after_initialize guarantees the override is registered before we apply it.
# The CSP middleware reads this mutable policy object on every request, so
# post-boot mutations propagate to served headers.
Rails.application.config.after_initialize do
  if (policy = Rails.application.config.content_security_policy)
    Revdoku.extend_content_security_policy(policy)
  end
end
