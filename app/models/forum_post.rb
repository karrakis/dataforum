class ForumPost < ActiveRecord::Base
	belongs_to :graph
	belongs_to :user
end