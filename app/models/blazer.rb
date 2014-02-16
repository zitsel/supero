class Blazer < Product
	store_accessor :properties, :brand, :tagged_size, :label, :retailer, :coat_chest_measure, 
	:coat_size, :coat_length, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, 
	:cloth_pattern, :coat_style, :no_buttons, :button_stance, :lapel_style, :lapel_width, :gorge, 
	:no_vents, :canvas, :lining, :lining_material, :cuff_style, :no_cuff_buttons, :button_type, 
	:pocket_style, :notes, :coat_condition, :coat_shoulder_measure, :coat_waist_measure, 
	:coat_seat_measure, :coat_sideseam_outlet_measure, :coat_full_length_measure, 
	:left_sleeve_top_measure, :left_sleeve_bottom_measure, :left_sleeve_outlet_measure, 
	:right_sleeve_top_measure, :right_sleeve_bottom_measure, :right_sleeve_outlet_measure, 
	:armscye_measure, :elbow_measure, :cuff_width_measure
	before_save :find_coat_size, :find_coat_length

	include SuitingMethods 
	def description
		"#{cloth_color} #{coat_style}"
	end
	def details
		{
			"Brand"=>brand,
			"Label"=>label,
			"Retailer"=>retailer,
			"Cloth Mill"=>cloth_mill,
			"Color"=>cloth_color,
			"Weave"=>cloth_weave,
			"Pattern"=>cloth_pattern,
			"Composition"=>cloth_composition,
			"Number of Buttons"=>no_buttons,
			"Button Stance"=>button_stance,
			"Lapel Style"=>lapel_style,
			"Gorge"=>gorge,
			"Vents"=>no_vents,
			"Canvas"=>canvas,
			"Lining"=>lining,
			"Lining Material"=>lining_material,
			"Cuff Style"=>cuff_style,
			"Number of Buttons (Cuff)"=>no_cuff_buttons,
			"Button Type"=>button_type,
			"Pocket Style"=>pocket_style,
			"Notes"=>notes

		}
	end
	def measurements
		{
			"Shoulder"=>coat_shoulder_measure,
			"Chest"=>coat_chest_measure,
			"Waist"=>coat_waist_measure,
			"Seat"=>coat_seat_measure,
			"Sideseam Outlet"=>coat_sideseam_outlet_measure,
			"Length (Full)"=>coat_full_length_measure,
			"Sleeve Top (Left)"=>left_sleeve_top_measure,
			"Sleeve Bottom (Left)"=>left_sleeve_bottom_measure,
			"Sleeve Outlet (Left)"=>left_sleeve_outlet_measure,
			"Sleeve Top (Right)"=>right_sleeve_top_measure,
			"Sleeve Bottom (Right)"=>right_sleeve_bottom_measure,
			"Sleeve Outlet (Right)"=>right_sleeve_outlet_measure,
			"Armscye"=>armscye_measure,
			"Elbow Widtth"=>elbow_measure,
			"Cuff Width"=>cuff_width_measure
		}
	end
		
	def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=75
		(weight.to_i++package_weight)/28.35
	end
	def size	
		coat_size+coat_length
	end
	def ebay_title
		title="#{brand.titleize}"
		title+=" #{label.titleize} " if label
		title+=" #{cloth_mill} Cloth" if cloth_mill
		title+=" #{cloth_color.titleize} #{cloth_pattern.titleize} #{coat_size} #{coat_length}"
		title+=" #{cloth_composition.titleize}" if title.length<69
		title+=" #{coat_style.titleize}" if title.length<69
		title
	end

	def ebay_attributes
		{
		"Brand"=>brand,
		"Size Type"=>"Regular",
		"Jacket Size"=>coat_size,
		"Jacket Length"=>ebay_length,
		"Style"=>ebay_style,
		"Material"=>cloth_composition,
		"Color"=>cloth_color,
		"Pattern"=>cloth_pattern,
		}
	end



	def primary_category_id
		"3002"
	end

	def price_col
		[24.00, 34.00, 48.00, 74.00, 94.00, 124.00, 148.00, 174.00, 189.00, 209.00, 249.00]
	end
end
