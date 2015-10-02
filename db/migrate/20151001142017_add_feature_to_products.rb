class AddFeatureToProducts < ActiveRecord::Migration
  def change
    add_column :products, :feature, :boolean, :default => false
  end
end
