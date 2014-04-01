class AddInternalNotesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :internal_notes, :text
  end
end
