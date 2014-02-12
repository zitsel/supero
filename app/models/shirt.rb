class Shirt < Product
	store_accessor :properties, :brand, :label, :retailer, :color, :pattern, :collar_type, :cuff_type, :collar_size, :sleeve_size, :fit, :material, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure
	#store_accessor :ebay_attributes, :brand, :size_type, :dress_shirt_size, :fit, :color, :collar, :material, :pattern, :cuff_style, :sleeve_length, :title, :weight_lb, :weight_oz, 

	def collar_types
		["Point","Button-Down","Spread","Cutaway","Tab","Wing"]
	end
	def cuff_types
		["Barrel","Notch","French","Convertable","Double Barrel"]
	end
	def collar_sizes
		%w[14 14.5 15 15.5 16 16.5 17 17.5 18 18.5 19 19.5 20 20.5 21 21.5 22 22.5]
	end
	def sleeve_sizes
		%w[28 28.5 29 29.5 30 30.5 31 31.5 32 32.5 33 33.5 34 34.5 35 35.5 36 36.5 37 37.5 38 38.5 39 39.5]
	end

	def ebay_sleeve(sleeve_measure)
		if sleeve_measure.to_i <= 33
			"32/33"
		elsif sleeve_measure.to_i <= 35
			"34/35"
		elsif sleeve_measure.to_i <= 37
			"36/37"
		else
			"38/39"
		end
	end
	
	def shipping_weight
		package_weight=110
		weight.to_i++package_weight

	end

	def ebay_title
		title="#{brand.titleize}"
		title+=" #{label.titleize} " if label
		title+=" Slim Fit " if fit=="Slim Fit, Fitted"
		title+=" #{color.titleize} #{collar_size}/#{sleeve_size} #{collar_type.titleize} Collar"
		title+=" #{material.titleize}" if title.length<69
		title+=" Dress Shirt" if title.length<69
		title
	end

	def attributes
		{
		"Brand"=>brand,
		"Size Type"=>size_type,
		"Dress Shirt Size"=>dress_shirt_size,
		"Fit"=>fit,
		"Color"=>color,
		"Collar"=>collar,
		"Material"=>material,
		"Pattern"=>pattern,
		"Cuff Style"=>cuff_style,
		"Sleeve Length"=>sleeve_length
		}
	end
end