class ApplicationMailer < ActionMailer::Base
  # Default from-address. Override by setting DEFAULT_FROM_EMAIL in the environment.
  default from: ENV.fetch("DEFAULT_FROM_EMAIL", "no-reply@localhost")
  layout "mailer"
end
