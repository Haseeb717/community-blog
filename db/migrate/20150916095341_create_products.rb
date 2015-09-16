class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.text :pros
      t.text :cons
      t.integer :price
      t.string :link
      t.integer :total_ratings
      
      t.timestamps
    end
  end
end
