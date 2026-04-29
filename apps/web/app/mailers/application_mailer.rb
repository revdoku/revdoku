class ApplicationMailer < ActionMailer::Base
  # Default from-address. Override by setting DEFAULT_FROM_EMAIL in the environment.
  default from: ENV["DEFAULT_FROM_EMAIL"].presence || "no-reply@localhost"
  layout "mailer"
end
