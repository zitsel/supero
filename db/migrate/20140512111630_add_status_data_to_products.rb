class AddStatusDataToProducts < ActiveRecord::Migration
  def up
  	Product.unscoped.where("on_hand = 0").each do |i|
  		i.update_attributes(:status=>"sold_out")
  	end
  	Product.available.where("on_hand > 0").each do |i|
  		i.update_attributes(:status=>"active")
  	end
  	Product.where("status is ?",nil).each do |i|
  		i.update_attributes(:status=>"unavailable")
  	end
  end
  def down
  	Product.unscoped.all.each do |i|
  		i.update_attributes(:status=>nil)
  	end
  end
end
