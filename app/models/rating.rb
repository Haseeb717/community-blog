class Rating < ActiveRecord::Base
  belongs_to :rate_able, polymorphic: true
end
