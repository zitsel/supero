class AddImpressionsCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :impressions_count, :integer, :default => 0
  end
end
