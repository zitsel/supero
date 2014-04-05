class Category < ActiveRecord::Base
	validates :display_name, :name, presence: true
	validates :name, :display_name, uniqueness: true
	validates_numericality_of :ebay_category_id,:etsy_category_id,:etsy_shipping_template_id,:etsy_shop_section_id,:package_weight, allow_blank: true
	has_many :products

	def symbolize
		name.underscore.downcase.pluralize.to_sym
	end	

	def ebay_about
		about.gsub("\n","<br>").gsub("\r","<br>")
	end

end
