class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable

	has_many :products
  has_many :user_tags
  has_many :tags, through: :user_tags
  has_many :comments
  has_many :ratings, as: :rate_able

  acts_as_liker
  
end
