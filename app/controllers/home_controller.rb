class HomeController < ApplicationController
	def frontpage
		@graphs = Graph.all
	end
end	