class MakeAddressPolymorphic < ActiveRecord::Migration
  def change
  	change_table :orders do |t|
  		t.remove :address_id
  	end
  	change_table :users do |t|
  		t.remove :address_id
  	end
  	change_table :addresses do |t|
  		t.references :addressable, polymorphic: true
  	end
  end
end
