class Embed::GraphsController < ApplicationController
   layout false
   def show
   	  response.headers.delete "X-Frame-Options" #] = "ALLOWALL"
      @graph = Graph.find params[:id]
   end
end