class Category < ActiveRecord::Base
	validates :display_name, :name, presence: true
	validates :name, :display_name, uniqueness: true
	validates :ebay_category_id,:etsy_category_id,:etsy_shipping_template_id,:etsy_shop_section_id,:package_weight, numericality: true


	def symbolize
		name.underscore.downcase.pluralize.to_sym
	end	

end
