class Neckwear < Product
	store_accessor :properties, :brand, :label, :retailer, :material, :width, :length, :pattern, :color, :style, :weave
	before_save do
		if length.to_i<57
			self.size="Short"
		elsif length.to_i<61
			self.size="Regular"
		else
			self.size="Long"
		end
	end

	def ebay_category_information
		"Neckwear is sold based on its actual mesaurements."
	end
	def description
		"#{color} #{pattern} #{style}"
	end
	def details
		{
			"Brand"=>brand,
			"Label"=>label,
			"Retailer"=>retailer,
			"Material"=>material,
			"Pattern"=>pattern,
			"Color"=>color,
			"Weave"=>weave
		}
	end
	def measurements
		{
			"Width"=>width,
			"Length"=>length
		}
	end
	def materials_col
		["100% Silk","100% Cotton","100% Wool","Silk Blend","Cotton Blend","Wool Blend","Unknown","Synthetic"]
	end
	def widths_col
		%w[2.5 2.75 3 3.25 3.5 3.75 4 4.25 4.5]
	end
	def lengths_col
		%w[48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64]
	end
	def styles_col
		%w[Bowtie Necktie Cravet]
	end
	def weaves_col
		["Repp","Grenadine","Plain","Knit","Printed"]
	end
	def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=20
		(weight.to_i++package_weight)/28.35
	end

	def ebay_title
		title="#{brand.try(:titleize)}"
		title+=" #{label.try(:titleize)} " if label
		title+=" #{color.try(:titleize)} #{material.try(:titleize)} #{weave} #{pattern.try(:titleize)} "
		title+=" #{style.try(:titleize)}" if title.length<69
		title
	end

	def ebay_attributes
		{
		"Brand"=>brand,
		"Style"=>ebay_style,
		"Color"=>color,
		"Material"=>material,
		"Attachment"=>"Tied",
		"Length"=>ebay_length,
		"Width"=>ebay_width,
		"Pattern"=>pattern
		}
	end
	def ebay_style
		if style=="Necktie"
			"Neck Tie"
		else
			style
		end
	end

	def ebay_length
		if length.to_i<57
			"Short (&lt;57 in.)"
		elsif length.to_i<61
			"Classic (57 in.-60 in.)"
		else
			"Long (&gt;60&quot;)"
		end
	end
	def ebay_width
		if width.to_d<3.5
			"Skinny (&lt; 3 1/2 in)"
		elsif width.to_d<4
			"Classic (3 1/2 in.-3 3/4 in.)"
		else "Wide (&gt; 3 3/4 in.)"
		end
	end

	def primary_category_id
		"15662"
	end

end
