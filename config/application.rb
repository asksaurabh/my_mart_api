require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyMartApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.api_only = true

    # To load the jwt lib file into our application, we must specify the lib folder in the list of Ruby on Rails _autoload_s
    config.eager_load_paths << Rails.root.join('lib')
  end
end
