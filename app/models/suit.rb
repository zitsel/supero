class Suit < Product
	store_accessor :properties, :tagged_size, :brand, :label, :retailer, :coat_size, :coat_length, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, :cloth_pattern, :trouser_style, :trouser_fly, :trouser_waistband_style, :trouser_waistband_lining, :belt_loops, :brace_buttons, :tab_adjust, :crotch_shield, :front_closure, :front_pockets_style, :trouser_lining, :trouser_bottoms, :trouser_condition, :trouser_waistband_width_measure, :trouser_waist_outlet_measure, :trouser_seat_measure, :thigh_measure, :knee_measure, :cuff_width_measure, :inseam_measure, :outseam_measure, :inseam_outlet_measure,
 :coat_style, :no_buttons, :button_stance, :lapel_style, :lapel_width, :gorge, :no_vents, :canvas, :lining, :lining_material, :cuff_style, :no_cuff_buttons, :button_type, :pocket_style, :notes, :coat_condition, :coat_shoulder_measure, :coat_chest_measure, :coat_waist_measure, :coat_seat_measure, :coat_sideseam_outlet_measure, :coat_full_length_measure, :left_sleeve_top_measure, :left_sleeve_bottom_measure, :left_sleeve_outlet_measure, :right_sleeve_top_measure, :right_sleeve_bottom_measure, :right_sleeve_outlet_measure, :armscye_measure, :elbow_measure, :cuff_width_measure
	before_save :find_coat_size, :find_coat_length
	
 	include SuitingMethods
 	def description
 		"#{cloth_color} #{coat_style} Suit"
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
			"Fly"=>trouser_fly,
			"Waistband"=>trouser_waistband_style,
			"Belt Loops"=>yn(belt_loops),
			"Brace Buttons"=>yn(brace_buttons),
			"Tab Adjust"=>yn(tab_adjust),
			"Croth Shield"=>yn(crotch_shield),
			"Front Closure"=>front_closure,
			"Front Pockets"=>front_pockets_style,
			"Trouser Lining"=>trouser_lining,
			"Trouser Bottoms"=>trouser_bottoms,
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
			"Cuff Width"=>cuff_width_measure,
			"Trouser Waist"=>waist_size,
			"Trouser Waist Outlet"=>trouser_waist_outlet_measure,
			"Trouser Seat"=>trouser_seat_measure,
			"Trouser Thigh"=>thigh_measure,
			"Trouser Knee"=>knee_measure,
			"Trouser Cuff"=>cuff_width_measure,
			"Inseam"=>inseam_measure,
			"Outseam"=>outseam_measure,
			"Inseam Outlet"=>inseam_outlet_measure
		}
	end
	def shipping_weight_oz
		#takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
		package_weight=75
		(weight.to_i++package_weight)/28.35
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
	def size
		coat_size+coat_length
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
		"Inseam"=>ebay_inseam,
		"Waist Size"=>waist_size
		}
	end
	
	def ebay_inseam
		if trouser_bottoms=="Unfinished"
			"Unfinished"
		else
			inseam_measure.floor
		end
	end

	def trouser_styles_col
		["Pleated","Plain Front"]
	end

	def waist_size
		(trouser_waistband_width_measure.to_d*2).floor
	end


	def primary_category_id
		"3001"
	end

	def price_col
		[24.00, 34.00, 48.00, 74.00, 94.00, 124.00, 148.00, 174.00, 189.00, 209.00, 249.00]
	end
	
end