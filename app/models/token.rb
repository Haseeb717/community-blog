class Token < ActiveRecord::Base
	has_many :books, :through => :taggings, :source => :taggable, :source_type => "Book"
	has_many :taggings
end
