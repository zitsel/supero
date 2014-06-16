class AddNewCategories < ActiveRecord::Migration
  def change
  	Category.create(
  		:name => "Boot",
  		:display_name => "Boots",
  		:ebay_category_id => "11498",
  		:etsy_category_id => "69164513",
  		:etsy_shop_section_id => "15145414",
  		:etsy_shipping_template_id => "3324188298",
  		:package_weight => "300",
  		:about => ""
  		)
  	  	Category.create(
  		:name => "CasualShoe",
  		:display_name => "Casual Shoes",
  		:ebay_category_id => "24087",
  		:etsy_category_id => "69164513",
  		:etsy_shop_section_id => "15145414",
  		:etsy_shipping_template_id => "3324188298",
  		:package_weight => "300",
  		:about => ""
  		)
  		Category.create(
  		:name => "PocketSquare",
  		:display_name => "Pocket Squares",
  		:ebay_category_id => "",
  		:etsy_category_id => "69164513",
  		:etsy_shop_section_id => "15590088",
  		:etsy_shipping_template_id => "33324225952",
  		:package_weight => "75",
  		:about => ""
  		)
  		Category.create(
  		:name => "Scarf",
  		:display_name => "Scarves",
  		:ebay_category_id => "52382",
  		:etsy_category_id => "69164513",
  		:etsy_shop_section_id => "15590088",
  		:etsy_shipping_template_id => "33324225952",
  		:package_weight => "75",
  		:about => ""
  		)
  		Category.create(
  		:name => "Luggage",
  		:display_name => "Luggage",
  		:ebay_category_id => "",
  		:etsy_category_id => "69164513",
  		:etsy_shop_section_id => "15590088",
  		:etsy_shipping_template_id => "3324188298",
  		:package_weight => "300",
  		:about => ""
  		)
  		Category.create(
  		:name => "CuffLink",
  		:display_name => "Cuff Links",
  		:ebay_category_id => "",
  		:etsy_category_id => "69164513",
  		:etsy_shop_section_id => "15590088",
  		:etsy_shipping_template_id => "33324225952",
  		:package_weight => "75",
  		:about => ""
  		)

  end
end
