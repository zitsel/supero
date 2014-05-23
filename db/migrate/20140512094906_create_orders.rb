class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :status
      #t.text :buyer_message
      t.decimal :tax_amount
      t.decimal :items_amount
      t.decimal :discounts_amount
      t.decimal :shipping_amount
      #t.decimal :subtotal_amount
      #t.decimal :grandtotal_amount
      t.boolean :paid
      t.boolean :shipped

      t.timestamps
    end
  end
end
