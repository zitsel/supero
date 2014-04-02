class SetSwitchesToFalse < ActiveRecord::Migration
  def change
      Product.where(:needs_cleaning=>nil).each do |i|
	  i.update_attributes(:needs_cleaning=>false)
      end
      Product.where(:needs_repair=>nil).each do |i|
	  i.update_attributes(:needs_repair=>false)
      end
      Product.where(:needs_photos=>nil).each do |i|
	  i.update_attributes(:needs_photos=>false)
      end
      Product.where(:needs_review=>nil).each do |i|
	  i.update_attributes(:needs_review=>false)
      end
  end
end
