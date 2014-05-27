class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :address_id 
      t.boolean :paid
      t.boolean :shipped
      t.decimal :subtotal_amount
      t.decimal :tax_amount
      t.decimal :shipping_amount
      t.decimal :discount_amount
      t.decimal :grandtotal_amount

      t.timestamps
    end
  end
end
