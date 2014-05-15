class CreateOrderedItems < ActiveRecord::Migration
  def change
    create_table :ordered_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.decimal :price

      t.timestamps
    end
  end
end
