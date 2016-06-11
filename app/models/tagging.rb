class Tagging < ActiveRecord::Base
	belongs_to :token
	belongs_to :taggable, :polymorphic => true
end
