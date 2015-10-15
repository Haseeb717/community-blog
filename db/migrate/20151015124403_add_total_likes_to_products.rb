class AddTotalLikesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :total_likes, :integer
  end
end
