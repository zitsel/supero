class Overcoat < Product
	store_accessor :properties, :brand, :label, :retailer, :cloth_weave, :coat_size, :cloth_mill, :cloth_color, :cloth_pattern, :style, :buttons, :vents, :lining, :material, :notes, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :full_length_measure, :sleeve_measure
	before_save do
		find_coat_size(coat_chest_measure) if coat_size.empty?
		self.size=coat_size
	end

	def ebay_category_information
		"Coats are sold by tagged size when available or by measurement otherwise (usually chest w/ 6\" of ease)."
	end
	def details
		{
			"Brand"=>brand,
			"Label"=>label,
			"Retailer"=>retailer,
			"Cloth Mill"=>cloth_mill,
			"Material"=>material,
			"Color"=>cloth_color,
			"Weave"=>cloth_weave,
			"Pattern"=>cloth_pattern,
			"Buttons"=>buttons,
			"Vents"=>vents,
			"Lining"=>lining,
			"Notes"=>notes
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

	def find_coat_size(measurement)
		self.coat_size=measurement.to_i*2-6 unless measurement.empty?
	end
	
	def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=75
		(weight.to_i++package_weight)/28.35
	end

	def ebay_title
		title="#{brand.try(:titleize)}"
		title+=" #{label.try(:titleize)} " if label
		title+=" #{cloth_color.try(:titleize)} #{cloth_pattern.try(:titleize)} #{coat_size} "
		title+=" #{style.try(:titleize)}" if title.length<69
		title+=" #{material.try(:titleize)}" if title.length<69
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


	def primary_category_id
		"57988"
	end
end
