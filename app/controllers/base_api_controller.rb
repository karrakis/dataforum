class BaseApiController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate, :parse_request

  private
  def authenticate
    Rails.logger.debug "HHHHEEEEERE WE AAAARE"
    authenticate_or_request_with_http_token do |token, options|
      Rails.logger.debug "HHHHHHHHHHHHHHH"
      Rails.logger.debug token
      Rails.logger.debug "GGGGGGGGGGGGGGG"
      @user = User.where(auth_token: token).first
    end
  end

   def parse_request
    logger.debug request.body.read
     @json = JSON.parse(request.body.read)
   end
end