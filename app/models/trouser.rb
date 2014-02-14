class Trouser < Product
	store_accessor :properties, :brand, :label, :retailer, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, :cloth_pattern, :trouser_style, :trouser_fly, :trouser_waistband_style, :trouser_waistband_lining, :belt_loops, :brace_buttons, :tab_adjust, :crotch_shield, :front_closure, :front_pockets_style, :trouser_lining, :trouser_bottoms, :trouser_condition, :trouser_waistband_width_measure, :trouser_waist_outlet_measure, :trouser_seat_measure, :thigh_measure, :knee_measure, :cuff_width_measure, :inseam_measure, :outseam_measure, :inseam_outlet_measure
	def price_col
		[8.00, 12.00, 18.00, 24.00, 34.00, 38.00, 44.00, 48.00, 54.00]
	end
	def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=75
		(weight.to_i++package_weight)/28.35
	end
	def trouser_styles_col
		["Casual Pants","Corduroys","Dress - Flat Front","Dress - Pleat","Khakis, Chinos",]	
	end
	def ebay_title
		title="#{brand.titleize}"
		title+=" #{label.titleize} " if label
		title+=" #{cloth_color.titleize} #{waist_size}/#{ebay_inseam}"
		title+=" #{trouser_style.titleize}" if title.length<69
		title+=" #{cloth_composition.titleize}" if title.length<69
		title
	end

	def ebay_attributes
		{
		"Brand"=>brand,
		"Style"=>trouser_style,
		"Size Type"=>"Regular",
		"Bottoms Size (Men's)"=>waist_size,
		"Inseam"=>ebay_inseam,
		"Material"=>cloth_composition,
		"Color"=>cloth_color,
		}
	end
	def ebay_inseam
		if trouser_bottoms=="Unfinished"
			"Unfinished"
		else
			inseam_measure.floor
		end
	end
	def waist_size
		(trouser_waistband_width_measure.to_d*2).floor
	end

	def ebay_description
		"description"
	end

	def primary_category_id
		"57989"
	end
end
