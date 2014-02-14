class Overcoat < Product
	store_accessor :properties, :brand, :label, :retailer, :cloth_weave, :coat_size, :cloth_mill, :cloth_color, :cloth_pattern, :style, :buttons, :vents, :lining, :material, :notes, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :full_length_measure, :sleeve_measure
	before_save :find_coat_size
	def find_coat_size
		if coat_size == ""
			self.coat_size=chest_measure.to_i*2-6
		end
	end
	def price_col
		[8.00, 12.00, 18.00, 24.00, 34.00, 38.00, 44.00, 48.00, 54.00]
	end
	def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=75
		(weight.to_i++package_weight)/28.35
	end

	def ebay_title
		title="#{brand.titleize}"
		title+=" #{label.titleize} " if label
		title+=" #{cloth_mill} Cloth" if cloth_mill
		title+=" #{cloth_color.titleize} #{cloth_pattern.titleize} #{coat_size} "
		title+=" #{style.titleize}" if title.length<69
		title+=" #{material.titleize}" if title.length<69
		title
	end
	def styles_col
		["Basic Coat","Basic Jacket","Fleece Jacket","Flight/Bomber","Jean Jacket","Military","Motorcycle","Parka","Peacoat","Poncho","Puffer","Rainwear","Trench","Varsity/Baseball","Vest","Windbreaker","Field Coat","Polo Coat","Chesterfield","Overcoat"].sort
	end
	def ebay_attributes
		{
		"Brand"=>brand,
		"Style"=>style,
		"Size Type"=>"Regular",
		"Size (Men's)"=>ebay_size,
		"Material"=>material,
		"Color"=>cloth_color,
		"Pattern"=>cloth_pattern
		}
	end
	def ebay_size
		if coat_size.to_i<=36
			"XS"
		elsif coat_size.to_i<=38
			"S"
		elsif coat_size.to_i<=40
			"M"
		elsif coat_size.to_i<=42
			"L"
		elsif coat_size.to_i<=44
			"XL"
		elsif coat_size.to_i<=46
			"2XL"
		else
			"3XL"
		end
	end

	def ebay_description
		"description"
	end

	def primary_category_id
		"57998"
	end
end
