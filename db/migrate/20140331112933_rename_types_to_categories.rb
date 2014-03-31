class RenameTypesToCategories < ActiveRecord::Migration
  def change
      rename_table :types, :categories
  end
end
