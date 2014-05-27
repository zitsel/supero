class DropColumnsFromOrders < ActiveRecord::Migration
  def change
  	change_table :orders do |t|
  		t.remove :subtotal_amount, :tax_amount, :shipping_amount, :discount_amount, :grandtotal_amount
  	end
  end
end
