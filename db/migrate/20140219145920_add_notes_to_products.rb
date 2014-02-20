class AddNotesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :notes, :text
    add_column :products, :condition_notes, :text
  end
end
