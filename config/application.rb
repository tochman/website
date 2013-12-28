require File.expand_path('../boot', __FILE__)

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Website
  class Application < Rails::Application
    config.exceptions_app = self.routes
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs false
      g.helper_specs false
      g.stylesheets = false
      g.javascripts = false
      g.helper = false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end

require 'dropbox_sdk'

module CarrierWave
  module Storage
    class Dropbox < Abstract

      private

      def config
        @config ||= {}

        @config[:app_key] = "chjxxbhpojosbt3"
        @config[:app_secret] = "wlton1e4b7zwc7o"
        @config[:access_token] = "ihrfscnvk47fvvmt"
        @config[:access_token_secret] = "qgxe1qmj6zaxeaf"
        @config[:access_type] = "app_folder"
        #@config[:access_type] = "dropbox"
        @config[:user_id] = "52190197"

        @config
      end

    end
  end
end

