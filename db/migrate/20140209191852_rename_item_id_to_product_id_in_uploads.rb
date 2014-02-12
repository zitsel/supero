class RenameItemIdToProductIdInUploads < ActiveRecord::Migration
  def change
      rename_column :uploads, :item_id, :product_id
  end
end
