Eoraptor::Application.configure do
  
  config.cache_classes                     = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets               = true
  config.i18n.fallbacks                    = true
  config.active_support.deprecation        = :notify
  
  # config.action_dispatch.x_sendfile_header = "X-Sendfile"
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  # config.log_level = :debug
  # config.logger = SyslogLogger.new
  # config.cache_store = :mem_cache_store
  # config.action_controller.asset_host = "http://assets.example.com"
  # config.action_mailer.raise_delivery_errors = false
  # config.threadsafe!
end
