#class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
#end


class ApplicationController < ActionController::Base
	attr_reader :current_user

	private

end