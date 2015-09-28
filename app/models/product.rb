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

  attr_accessor :abc

  def abc
    self.categories.collect(&:name).join(',')
  end

  def abc=(value)
    self.categories.delete_all
    names = value.split(',')
    names.each do |n|
      category = Category.find(n)
      self.categories << category
    end
  end

end
