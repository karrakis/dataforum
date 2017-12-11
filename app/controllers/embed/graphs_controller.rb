class Embed::GraphsController < ApplicationController
    layout false
	def show
		response.headers["X-Frame-Options"] = "ALLOW-FROM 24.178.240.237"
    	@graph = Graph.find params[:id]
    end
end