class Shirt < Product
	store_accessor :properties, :brand, :label, :retailer, :color, :pattern, :collar_type, :cuff_type, :collar_size, :sleeve_size, :fit, :material, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure

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

	def ebay_sleeve
		if sleeve_size.to_i <= 33
			"32/33"
		elsif sleeve_size.to_i <= 35
			"34/35"
		elsif sleeve_size.to_i <= 37
			"36/37"
		else
			"38/39"
		end
	end
	
	def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=110
		(weight.to_i++package_weight)/28.35
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

	def ebay_attributes
		{
		"Brand"=>brand,
		"Size Type"=>"Regular",
		"Dress Shirt Size"=>collar_size.to_s.sub(".5","1/2"),
		"Fit"=>fit,
		"Color"=>color,
		"Collar"=>collar_type,
		"Material"=>material,
		"Pattern"=>pattern,
		"Cuff Style"=>ebay_cuff,
		"Sleeve Length"=>ebay_sleeve
		}
	end
	


	def ebay_description
		"description"
	end

	def primary_category_id
		"57991"
	end

	def price_col
		[8.00, 12.00, 18.00, 24.00, 34.00, 38.00, 44.00, 48.00, 54.00]
	end

	def ebay_cuff
		if cuff_type=="French Cuff"
			"French Cuff"
		else
			"Standard Cuff"
		end
	end
end	