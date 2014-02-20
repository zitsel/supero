class CasualShirt < Product
	store_accessor :properties, :brand, :label, :retailer, :color, :pattern, :size_type, :size, :sleeve_length, :material, :style, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :sleeve_measure
	def ebay_category_information
		"Casual shirts are sold by their tagged size."
	end
	def display_name
		"Casual Shirts"
	end
	def description
		"#{color} #{pattern} #{style} Shirt"
	end
	def ebay_attributes
		{
			"Brand"=>brand,
			"Style"=>style,
			"Size Type"=>size_type,
			"Size (Men's)"=>size,
			"Sleeve Length"=>sleeve_length,
			"Material"=>material,
			"Color"=>color,
			"Pattern"=>pattern
		}
	end
	def details
		{
			"Brand"=>brand,
			"Label"=>label,
			"Retailer"=>retailer,
			"Color"=>color,
			"Pattern"=>pattern,
			"Sleeve Length"=>sleeve_length,
			"Material"=>material,
		}
	end
	def measurements
		{
			"Shoulder"=>shoulder_measure,
			"Chest"=>chest_measure,
			"Waist"=>waist_measure,
			"Seat"=>seat_measure,
			"Length"=>length_measure,
			"Sleeve"=>sleeve_measure
		}
	end
	def ebay_title
		title="#{brand.try(:titleize)}"
		title+=" #{label.try(:titleize)} " if label
		title+=" #{color.try(:titleize)} #{size} #{style.try(:titleize)}"
		title+=" #{material.try(:titleize)}" if title.length<69
		title+=" Dress Shirt" if title.length<69
		title="VTG "+title if vintage
		title

	end
	def primary_category_id
		"57990"
	end
	def price_col
		[8.00, 12.00, 18.00, 24.00, 34.00, 38.00, 44.00, 48.00, 54.00]
	end
	def size_types_col
		["Regular","Big & Tall"]
	end
	def styles_col
		["Button-Front","Hawaiian","Henley","Polo, Rugby","Tank","Turtleneck","Western"]
	end
	def sizes_col
		["XS","S","M","L","XL","2XL","3XL"]
	end
end