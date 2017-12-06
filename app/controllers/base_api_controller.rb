class BaseApiController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate, :parse_request

  private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(auth_token: token).first
    end
  end

   def parse_request
    logger.debug request.body.read
     @json = JSON.parse(request.body.read)
   end
end