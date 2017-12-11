class Embed::GraphsController < ApplicationController
    before_action :allow_iframe_requests
    layout false
	def show
    	@graph = Graph.find params[:id]
    	logger.debug("...")
    	logger.debug(response.headers)
    end

    def allow_iframe_requests
    	logger.debug(response.headers)
    	response.headers.delete "X-Frame-Options" #] = "ALLOWALL"
    	logger.debug(response.headers)
    end
end