class CreateEtsyListings < ActiveRecord::Migration
  def change
    create_table :etsy_listings do |t|
      t.integer :product_id
      t.string :etsy_id

      t.timestamps
    end
  end
end
