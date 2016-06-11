class Book < ActiveRecord::Base
	has_many :tokens, :through => :taggings
	has_many :taggings, :as => :taggable
 
end
