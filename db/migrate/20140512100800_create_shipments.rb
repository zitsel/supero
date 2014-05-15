class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.integer :order_id
      t.string :carrier_name
      t.string :tracking_code
      t.string :tracking_url
      t.date :shipped_date
      t.decimal :amount
      t.string :name
      t.string :first_line
      t.string :second_line
      t.string :city
      t.string :state
      t.string :zip
      t.string :country

      t.timestamps
    end
  end
end
