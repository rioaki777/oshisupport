require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Animanage
  class Application < Rails::Application
    config.load_defaults 7.2

    config.autoload_lib(ignore: %w[assets tasks])

    config.generators do |g|
      g.stylesheets false # CSSを自動生成しない
      g.javascripts false # JavaScriptを自動生成しない
      g.helper false  # ビューヘルパーを自動生成しない

      g.test_framework :rspec,
        fixtures: false, # FactoryBotを使用するため自動生成しない
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: true
    end

    config.i18n.default_locale = :ja
  end
end
