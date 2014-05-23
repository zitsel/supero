module SuitingMethods

	def no_buttons_col
		["One","Two","Three","Four","3/2 Roll","Double Breasted"]
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
		["2PC Lounge","3PC Lounge","2PC Dinner","3PC Dinner","Dinner Jacket","Norfolk","Blazer","Sport Coat","Tail Coat"]
	end
	def cloth_compositions_col
		["100% Wool","Wool Blend","100% Cashmere","Cashmere Blend","Linen","Cotton","Cotton Blend","Sythetic","Unknown","Camelhair","100% Silk","Silk Blend"]
	end

	def ebay_length
		if coat_length=="S"
			"Short"
		elsif coat_length=="R"
			"Regular"
		elsif coat_length=="L"
			"Long"
		else
			"X-Long"	
		end
	end
	def ebay_style
		if no_buttons=="One"
			"One Button"
		elsif no_buttons=="Two"
			"Two Button"
		elsif no_buttons=="3/2 Roll"
			"Two Buttons"
		elsif no_buttons=="Three"
			"Three Button"
		elsif no_buttons=="Double Breasted"
			"Double Breasted"
		end
	end	

	def find_coat_size(measurement)
		self.coat_size=measurement.to_i*2-4 unless measurement.empty?
	end
	
	def find_coat_length(measurement)
		self.coat_length = case measurement.to_i
			when 26..27 then "XS"
			when 28..29 then "S"
			when 30..32 then "R"
			when 32..33 then "L"
			when 33..34 then "XL"
			else ""
		end
	end

	def set_size
		unless coat_size.nil?
		find_coat_size(coat_chest_measure) if coat_size.empty?
		find_coat_length(coat_full_length_measure) if coat_length.empty?
		self.size=[coat_size,coat_length].join("")
		end
	end
end
