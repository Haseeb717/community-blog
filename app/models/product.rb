class Product < ActiveRecord::Base
	belongs_to :user
  has_many :category_products
  has_many :categories , through: :category_products
end
