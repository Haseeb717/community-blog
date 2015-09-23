class AddTypeToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :type, :string
  end
end
