class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :payment_method
      t.decimal :payment_amount
      t.timestamps
    end
  end
end
