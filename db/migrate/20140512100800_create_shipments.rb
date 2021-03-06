class CreateShipments < ActiveRecord::Migration
  def change
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
