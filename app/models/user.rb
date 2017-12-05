class User < ApplicationRecord
	has_many :graphs
	has_many :forum_posts
	before_create :generate_api_key
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :google_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def generate_api_key
  	self.auth_token = SecureRandom.hex(12)
  end
end
