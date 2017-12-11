class Embed::GraphsController < ApplicationController
    before_action :allow_iframe_requests
    layout false
	def show
		response.headers.delete "X-Frame-Options"
    	@graph = Graph.find params[:id]
    	render :show
    end

    def allow_iframe_requests
    	logger.debug(response.headers)
    	response.headers.delete "X-Frame-Options" #] = "ALLOWALL"
    	logger.debug(response.headers)
    end
end