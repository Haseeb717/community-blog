class Product < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

	belongs_to :user
  has_many :category_products
  has_many :categories , through: :category_products
  has_many :comments, as: :commentable
  has_many :images, as: :imageable
  has_many :product_tags
  has_many :tags, through: :product_tags

  searchable do
      text :title, :boost => 5
      text :categories do
        categories.map { |category| category.name }
      end
      text :tags do
        tags.map { |tag| tag.name }
      end
  end


  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :comments

  validates :title, :description, :presence => true

  acts_as_likeable

  attr_accessor :abc,:def

  def abc
    self.categories.collect(&:name).join(',')
  end

  def def
    self.tags.collect(&:name).join(',')
  end

  def abc=(value)
    self.categories.delete_all
    names = value.split(',')
    names.each do |n|

      category = Category.find(n)
      self.categories << category
    end
  end

  def def=(value)
    self.tags.delete_all
    tags = value.split(',')
    tags.each do |n|
      tag = Tag.find_by_name(n)
      if tag.nil?
        t = Tag.create(:name=>n)
        self.tags << t
      else
        self.tags << tag
      end
    end 
  end
  
end
