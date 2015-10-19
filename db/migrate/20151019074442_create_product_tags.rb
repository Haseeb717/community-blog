class CreateProductTags < ActiveRecord::Migration
  def change
    create_table :product_tags do |t|
      t.belongs_to :product, index: true
      t.belongs_to :tag, index: true
      t.timestamps null: false
    end
  end
end
