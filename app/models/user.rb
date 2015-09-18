class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable

  acts_as_liker

	has_many :products
  has_many :user_tags
  has_many :tags, through: :user_tags
  has_many :comments
  has_many :ratings, as: :rate_able
  has_many :images, as: :imageable
  
  accepts_nested_attributes_for :images

end
