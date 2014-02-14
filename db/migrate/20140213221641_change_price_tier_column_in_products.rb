class ChangePriceTierColumnInProducts < ActiveRecord::Migration
  def change
      rename_column :products, :price_tier, :price
      change_column :products, :price, :decimal
  end
end
