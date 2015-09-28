class AddFlagToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :flag, :boolean
  end
end
