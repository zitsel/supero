class AddProductIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :product_id, :integer
  end
end
