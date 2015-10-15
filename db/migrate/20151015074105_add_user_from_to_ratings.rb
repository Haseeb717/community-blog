class AddUserFromToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :user_from, :integer
  end
end
