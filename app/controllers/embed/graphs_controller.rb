class Embed::GraphsController < ApplicationController
   layout false
   def show
      @graph = Graph.find params[:id]
   end
end