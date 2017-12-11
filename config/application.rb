require_relative 'boot'

require 'rails/all'
require 'open-uri'
require 'csv'
#require 'rack/cors'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DataForum
  class Application < Rails::Application
  	Figaro.load
  	config.autoload_paths << Rails.root.join('lib')
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

	#config.middleware.insert_before 0, Rack::Cors do
    #  allow do
    #    origins '*'
    #    resource '*', :headers => :any, :methods => [:get, :post, :options]
    #  end
    #end
  end

  #This opens the Devise RegistrationsController class for editing and adds a method to create a user API key and save it.
  module Devise
    class RegistrationsController
      def boop
        puts "so that worked, huh?"
      end
    end
  end
end