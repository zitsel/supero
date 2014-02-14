module SuitingMethods

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
		["2PC Lounge","3PC Lounge","2PC Dinner","3PC Dinner","Dinner Jacket","Norfolk","Blazer","Sport Coat","Tail Coat"]
	end
	def cloth_compositions_col
		["100% Wool","Wool Blend","100% Cashmere","Cashmere Blend","Linen","Cotton","Cotton Blend","Sythetic","Unknown"]
	end
	def find_coat_size
		if coat_size == ""
			self.coat_size=coat_chest_measure.to_i*2-4
		end
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
	def find_coat_length
		if coat_length == ""
			if coat_full_length_measure.to_i < 30
				self.coat_length="S"
			elsif coat_full_length_measure.to_i < 32
				self.coat_length="R"
			elsif coat_full_length_measure.to_i < 34
				self.coat_length="L"
			else
				self.coat_length="XL"
			end
		end
	end
end