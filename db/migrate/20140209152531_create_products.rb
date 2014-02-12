class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.string :type
      t.decimal :weight

      t.timestamps
    end
  end
end
