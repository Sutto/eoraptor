Settings.mailer.tap do |s|
  ActionMailer::Base.default_url_options[:host] = s.host                      if s.host?
  ActionMailer::Base.delivery_method            = s.delivery_method.to_sym    if s.delivery_method?
  ActionMailer::Base.smtp_settings              = s.smtp_settings.to_hash     if s.smtp_settings?
  ActionMailer::Base.sendmail_settings          = s.sendmail_settings.to_hash if s.sendmail_settings?
  ActionMailer::Base.default              :from => s.from                     if s.from?
end if Settings.mailer?