class AddCategoryIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category_id, :integer
    Product.all.each do |i|
	n=Category.where(:name=>i.type).take.id
	i.update_attributes(:category_id=>n)
    end
  end
end
