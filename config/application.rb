require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)


module MoneySuperMarket
  class Application < Rails::Application
    config.load_defaults 5.1

    config.time_zone = 'Europe/London'

    # Don't generate system test files.
    config.generators.system_tests = nil

    auto_load_paths = [
      Rails.root.join('app', 'services'),
      Rails.root.join('lib', 'utils'),
      Rails.root.join('lib', 'exceptions')
    ]

    config.autoload_paths.push(*auto_load_paths)

    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec
    end
  end
end
