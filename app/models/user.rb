class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :presence => true

  acts_as_liker
  acts_as_follower
  acts_as_followable
  
	has_many :products
  has_many :comments
  has_many :ratings, as: :rate_able
  has_many :images, as: :imageable
  
  searchable do
    text :first_name, :boost => 5
    text :last_name
  end

  accepts_nested_attributes_for :images

  def self.user_ids
    all.map(&:id)
  end

  def self.products
    Product.where(user_id: user_ids)
  end

end
