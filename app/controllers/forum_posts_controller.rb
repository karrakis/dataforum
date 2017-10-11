class ForumPostsController < ApplicationController
  before_action :set_user


	def new
		@forum_post = ForumPost.new
	end

	def create
		@forum_post = ForumPost.new(@user ? forum_post_params.merge(users_id: @user.id) : forum_post_params)
	end	

	private

	    def set_user
	      @user = current_user
	    end

end