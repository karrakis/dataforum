class User < ApplicationRecord
	has_many :graphs
	has_many :forum_posts
	attr_accessor :gauth_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :google_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         

         #:jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist
end

