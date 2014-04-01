class AddDecadeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :decade, :string
  end
end
