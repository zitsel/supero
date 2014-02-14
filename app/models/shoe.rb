class Shoe < Product
	store_accessor :properties, :brand, :maker, :model, :model_number, :style, :color, :size, :width, :upper_material, :upper_condition, :sole_material, :sole_type, :sole_condition, :heel_material, :heel_condition, :insole_type, :insole_condition, :lining_type, :lining_condition

def sizes
	%w[5 6 7 8 9 10 11 12 13 14 15 16 17 18 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5].sort
end

def widths
	%w[aaa aa a b c d e ee eee].map(&:upcase)

end
def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=300
		(weight.to_i++package_weight)/28.35
end

	def ebay_title
		title="#{brand.titleize}"
		title+=" #{model.titleize} " if model
		title+=" #{color.titleize} #{style.titleize} #{size.titleize} #{width.titleize}"
		title+=" Dress Shoe" if title.length<69
		title
	end

	def ebay_attributes
		{
		"Brand"=>brand,
		"Style"=>style,
		"US Shoe Size (Men's)"=>size,
		"Width"=>width,
		"Color"=>color,
		"Material"=>upper_material,
		}
	end
	
	def ebay_description
		"description"
	end

	def primary_category_id
		"53120"
	end

	def price_col
		[34.00, 54.00, 74.00, 94.00, 124.00, 148.00, 174.00, 189.00]
	end

end
