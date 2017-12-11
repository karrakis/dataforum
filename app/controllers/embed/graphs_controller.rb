class Embed::GraphsController < ApplicationController
    before_filter :allow_iframe_requests
    layout false
	def show
    	@graph = Graph.find params[:id]
    end

    def allow_iframe_requests
    	response.headers.delete "X-Frame-Options" #] = "ALLOWALL"
    end
end