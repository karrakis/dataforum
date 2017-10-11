class HomeController < ApplicationController
	def frontpage
		@graphs = Graph.paginate(:page => params[:page], :per_page => 30)
	end
end	