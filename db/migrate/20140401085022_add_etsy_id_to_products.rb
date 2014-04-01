class AddEtsyIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :etsy_id, :string
  end
end
