class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :payment_method
      t.decimal :amount
      t.string :currency_code
      t.string :ip_address
      t.string :name
      t.string :first_line
      t.string :second_line
      t.string :cite
      t.string :state
      t.string :zip
      t.string :country
      t.string :card_type
      t.string :card_expiration
      t.string :action
      t.boolean :success
      t.string :authorization


      t.timestamps
    end
  end
end
