class Tag < ActiveRecord::Base
  has_many :product_tags
  has_many :products, through: :product_tags

  searchable do
    text :name
  end
end
