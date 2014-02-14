class AddColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :condition, :string
    add_column :products, :price_tier, :integer
    add_column :products, :vintage, :boolean
    add_column :products, :mfg_date, :datetime
    add_column :products, :mfg_country, :string
    add_column :products, :on_hand, :integer
    add_column :products, :needs_repair, :boolean
    add_column :products, :needs_cleaning, :boolean
  end
end
