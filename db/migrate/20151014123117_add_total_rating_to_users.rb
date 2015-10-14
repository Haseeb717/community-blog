class AddTotalRatingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_rating, :integer
  end
end
