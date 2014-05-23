class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :payment_method
      t.decimal :amount
      t.string :currency_code
      t.string :ip_address
      t.text :billing_address
      t.string :action
      t.boolean :success



      t.timestamps
    end
  end
end
