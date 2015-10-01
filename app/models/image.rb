class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  has_attached_file :avatar, styles: { thumb: "30x30", small: "66x66", med: "150x84", large: "535x780", e_large: "800x449"}
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
end
