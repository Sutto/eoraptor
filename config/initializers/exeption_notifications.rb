if Settings.failtale?
  require 'rack/failtale'
  Eoraptor::Application.configure do
    config.middleware.insert_after 'ActionDispatch::ShowExceptions',  Rack::Failtale, Settings.failtale.api_key
  end
end

