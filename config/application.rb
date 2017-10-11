require_relative 'boot'

require 'rails/all'
require 'open-uri'
require 'csv'
require 'rack/cors'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DataForum
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.serve_static_assets = true
  	config.middleware.insert_before ActionDispatch::Static, Rack::Cors do
	  allow do
	    origins '*'
	    resource '/embed.js', :headers => :any, :methods => [:get, :post, :options] #-> I believe resource needs to be a specific URL - will have to check this
	  	resource '/embed/*', :headers => :any, :methods => [:get, :post, :options]
	  end
	end
  end
end