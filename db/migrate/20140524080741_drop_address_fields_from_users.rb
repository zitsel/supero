class DropAddressFieldsFromUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
		t.remove 	:full_name
		t.remove	:address_line1
		t.remove	:address_line2
		t.remove	:city
		t.remove	:state
		t.remove	:zip
		t.remove	:country
	end
	add_column :users, :address_id, :integer 
  end
end
