class CreateBrandLists < ActiveRecord::Migration
  def change
    create_table :brand_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
