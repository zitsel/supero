class CasualShirt < Product
	store_accessor :properties, :brand, :label, :retailer, :color, :pattern, :size_type, :size, :tagged_size, :sleeve_length, :material, :style, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :sleeve_measure
	before_save do
		self.size=tagged_size
	end
	def shipping_weight_oz
	#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=25
		weight.to_i++package_weight)/28.35
    end 
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

	def size_types_col
		["Regular","Big & Tall"]
	end
	def styles_col
		["Button-Front","Hawaiian","Henley","Polo, Rugby","Tank","Turtleneck","Western"]
	end
	def sizes_col
		["XS","S","M","L","XL","2XL","3XL"]
	end
	def sleeve_lengths_col
	    ["Sleeveless","Short Sleeve","Long Sleeve"]
	end
end
