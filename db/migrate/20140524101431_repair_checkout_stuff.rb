class RepairCheckoutStuff < ActiveRecord::Migration
  def change
  	drop_table :orders
	drop_table :ordered_items
	drop_table :payments
	drop_table :shipments

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
    create_table :ordered_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.decimal :price

      t.timestamps
    end

    create_table :payments do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :payment_method
      t.decimal :payment_amount
      t.timestamps
    end
   create_table :shipments do |t|
      t.integer :order_id
      t.string :carrier_name
      t.string :tracking_code
      t.string :tracking_url
      t.date :shipped_date
      t.decimal :shipping_cost_amount
      t.timestamps
    end
	end
end
