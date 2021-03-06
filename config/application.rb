require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Isetan
  class Application < Rails::Application
    config.generators do |g|
      g.assets         false
      g.helper         false
      g.test_framework :rspec,
        fixtures:         true,
        view_specs:       false,
        helper_specs:     false,
        routing_specs:    false,
        controller_specs: false,
        request_specs:    false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
    config.assets.paths << "#{Rails}/vender/assets/fonts"
    config.i18n.default_locale = :ja
  end
end
