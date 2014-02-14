class RenameItemIdInEbayListing < ActiveRecord::Migration
  def change
      rename_column :ebay_listings, :item_id, :product_id
  end
end
