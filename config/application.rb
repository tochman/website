require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'dotenv'
Dotenv.load


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

      # Stubs we must implement to create and save
      # files (here on Dropbox)

      # Store a single file
      def store!(file)
        location = uploader.store_path
        location = "/Public/#{location}" if config[:access_type] == "dropbox"

        dropbox_client.put_file(location, file.to_file)
      end

      # Retrieve a single file
      def retrieve!(file)
        CarrierWave::Storage::Dropbox::File.new(uploader, config, uploader.store_path(file), dropbox_client)
      end

      private

      def dropbox_client
        @dropbox_client ||= begin
          session = DropboxSession.new(config[:app_key], config[:app_secret])
          session.set_access_token(config[:access_token], config[:access_token_secret])
          DropboxClient.new(session, config[:access_type])
        end
      end

      def config
        @config ||= {}

        @config[:app_key] = "chjxxbhpojosbt3"
        @config[:app_secret] = "wlton1e4b7zwc7o"
        @config[:access_token] = "t9iznd2jdniaob89"
        @config[:access_token_secret] = "fj8m1eg7u3v89zg"
        @config[:access_type] = "app_folder"
        @config[:user_id] = "52190197"

        @config
      end

      class File
        include CarrierWave::Utilities::Uri
        attr_reader :path

        def initialize(uploader, config, path, client)
          @uploader, @config, @path, @client = uploader, config, path, client
        end

        def url
          user_id, path = @config[:user_id], @path
          if @config[:access_type] == "dropbox"
            "https://dl.dropboxusercontent.com/u#{user_id}/#{path}"
          else
            @client.media(path)["url"]
          end
        end

        def delete
          path = @path
          path = "/Public/#{path}" if @config[:access_type] == "dropbox"
          begin
            @client.file_delete(path)
          rescue DropboxError
          end
        end
      end
    end
  end
end

