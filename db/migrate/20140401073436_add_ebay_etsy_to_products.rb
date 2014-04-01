class AddEbayEtsyToProducts < ActiveRecord::Migration
  def change
    add_column :products, :list_etsy, :boolean
    add_column :products, :list_ebay, :boolean
  end
end
