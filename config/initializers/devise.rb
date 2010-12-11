Devise.setup do |config|
  require 'devise/orm/active_record'
  
  config.stretches     = 10
  config.encryptor     = :bcrypt
  config.mailer_sender = Settings.mailer.from
  config.pepper        = Settings.devise.pepper

end
