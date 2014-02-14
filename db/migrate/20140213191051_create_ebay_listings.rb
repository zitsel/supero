class CreateEbayListings < ActiveRecord::Migration
  def change
    create_table :ebay_listings do |t|
      t.integer :item_id
      t.string :ebay_item_id
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :insertion_fees

      t.timestamps
    end
  end
end
