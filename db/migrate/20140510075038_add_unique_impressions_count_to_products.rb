class AddUniqueImpressionsCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :unique_impressions_count, :integer, :default => 0
  end
end
