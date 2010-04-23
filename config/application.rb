require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Eoraptor
  class Application < Rails::Application
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :test_unit, :fixture_replacement => :machinist
    end
    config.encoding           = "utf-8"
    config.filter_parameters += [:password]
  end
end
