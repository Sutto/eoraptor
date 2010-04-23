if Settings.exception_notifier?
  require 'exception_notifier'
  Eoraptor::Application.config.middleware.use ExceptionNotifier,
      :email_prefix         => "[Eoraptor] ",
      :sender_address       => %{"Eoraptor" <#{Settings.mailer.from}>},
      :exception_recipients => Array(Settings.exception_notifier.recipients)
end