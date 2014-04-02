class AddNeedsPhotosToProducts < ActiveRecord::Migration
  def change
    add_column :products, :needs_photos, :boolean
  end
end
