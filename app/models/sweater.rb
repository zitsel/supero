class Sweater < Product
	store_accessor :properties, :brand, :label, :retailer, :material, :tagged_size, :style, :pattern, :color, :shoulder_measure, :sleeve_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :condition, :notes
	before_update do
		self.size=tagged_size
	end
	def price_col
		[8.00, 12.00, 18.00, 24.00, 34.00, 38.00, 44.00, 48.00, 54.00]
	end
	def description
		"#{color} #{pattern} #{style} Sweater"
	end
	def details
		{
			"Brand"=>brand,
			"Label"=>label,
			"Retailer"=>retailer,
			"Material"=>material,
			"Notes"=>notes
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
	def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=75
		(weight.to_i++package_weight)/28.35
	end

	def ebay_title
		title="#{brand.try(:titleize)}"
		title+=" #{label.try(:titleize)} " if label
		title+=" #{color.try(:titleize)} #{pattern.try(:titleize)} #{style.try(:titleize)} #{tagged_size.try(:titleize)}"
		title+=" #{material.try(:titleize)}" if title.length<69
		title
	end
	def sizes_col
		["XS","S","M","L","XL","2XL","3XL"]
	end
	def styles_col
		["1/2 Zip","Crewneck","Full Zip","Cardigan","Hooded","Polo","Turtleneck","Vest","V-Neck"]
	end
		
	def ebay_attributes
		{
		"Brand"=>brand,
		"Style"=>style,
		"Size Type"=>"Regular",
		"Size (Men's)"=>tagged_size,
		"Color"=>color,
		"Pattern"=>pattern,
		"Material"=>material
		}
	end

	def primary_category_id
		"11484"
	end
	def ebay_category_information
		"We sell our sweaters based on their actual measurements. Generally, this is the same as the tagged size. We do this to ensure that you get a proper fit and so that sizing is consistent across brands and eras. Tagged size is indicated where available."
	end
end

