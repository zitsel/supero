class AddEbayAttributesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ebay_attributes, :hstore
  end
end
