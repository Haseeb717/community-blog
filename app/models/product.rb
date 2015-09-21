class Product < ActiveRecord::Base
	belongs_to :user
  has_many :category_products
  has_many :categories , through: :category_products
  has_many :comments, as: :commentable
  has_many :images, as: :imageable

  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :comments

  validates :title, :description, :presence => true

  acts_as_likeable
end
