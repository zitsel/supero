class Jacket < Product
	store_accessor :properties, :brand, :label, :retailer, :cloth_weave, :material, :tagged_size, :cloth_color, :cloth_pattern, :style, :buttons, :vents, :lining, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :full_length_measure, :sleeve_measure
	def details
		{
			"Brand"=>brand,
			"Label"=>label,
			"Retailer"=>retailer,
			"Material"=>material,
			"Color"=>cloth_color,
			"Weave"=>cloth_weave,
			"Pattern"=>cloth_pattern,
			"Buttons"=>buttons,
			"Vents"=>vents,
			"Lining"=>lining,
		}
	end
	def measurements
		{
			"Shoulder:"=>shoulder_measure,
			"Chest:"=>chest_measure,
			"Waist:"=>waist_measure,
			"Seat:"=>seat_measure,
			"Length:"=>full_length_measure,
			"Sleeve:"=>sleeve_measure
		}
	end
	def description
		"#{cloth_color} #{style}"
	end
	def price_col
		[8.00, 12.00, 18.00, 24.00, 34.00, 38.00, 44.00, 48.00, 54.00]
	end
		def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=75
		(weight.to_i++package_weight)/28.35
	end
	def sizes_col
		["XS","S","M","L","XL","2XL","3XL"]
	end
	def size
		tagged_size
	end
	def ebay_title
		title="#{brand.titleize}"
		title+=" #{label.titleize} " if label
		title+=" #{cloth_color.titleize} #{cloth_pattern.titleize} #{tagged_size} "
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
		"Size (Men's)"=>tagged_size,
		"Material"=>material,
		"Color"=>cloth_color,
		"Pattern"=>cloth_pattern
		}
	end


	

	def primary_category_id
		"57988"
	end


end
