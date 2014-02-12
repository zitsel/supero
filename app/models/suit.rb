class Suit < Product
	attr_accessor :properties, :brand, :label, :retailer, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, :cloth_pattern, :trouser_style, :trouser_fly, :trouser_waistband_style, :trouser_waistband_lining, :belt_loops, :brace_buttons, :tab_adjust, :crotch_shield, :front_closure, :front_pockets_style, :trouser_lining, :trouser_bottoms, :trouser_condition, :trouser_waistband_width_measure, :trouser_waist_outlet_measure, :trouser_seat_measure, :thigh_measure, :knee_measure, :cuff_width_measure, :inseam_measure, :outseam_measure, :inseam_outlet_measure,
 :coat_style, :no_buttons, :button_stance, :lapel_style, :lapel_width, :gorge, :no_vents, :canvas, :lining, :lining_material, :cuff_style, :no_cuff_buttons, :button_type, :pocket_style, :notes, :coat_condition, :coat_shoulder_measure, :coat_waist_measure, :coat_seat_measure, :coat_sideseam_outlet_measure, :coat_full_length_measure, :left_sleeve_top_measure, :left_sleeve_bottom_measure, :left_sleeve_outlet_measure, :right_sleeve_top_measure, :right_sleeve_bottom_measure, :right_sleeve_outlet_measure, :armscye_measure, :elbow_measure, :cuff_width_measure

	def no_buttons_col
		["One","Two","Three","3/2 Roll","Double Breasted"]
	end
	def button_stance_col
		["Low","Medium","High"]
	end
	def lapel_style_col
		["Peak","Notch","Shawl"]
	end
	def no_vents_col
		["None","Single","Dual"]
	end
	def canvas_col
		["Floating Chest","Half","Full"]
	end
	def coat_style_col
		["Lounge","Dinner","Blazer","Sport Coat","Tail Coat"]
	end
end