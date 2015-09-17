class Tag < ActiveRecord::Base
  has_many :user_tags
  has_many :user, through: :user_tags
end
