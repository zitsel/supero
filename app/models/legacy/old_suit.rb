class OldSuit < ActiveRecord::Base
	self.table_name = "suits"
	establish_connection :legacy

	def to_model
		Suit.create!(:sku=>sku,:weight=>weight,:mfg_date=>mfg_date,:vintage=>vintage,:brand=>brand,:label=>label,:retailer=>retailer,:coat_style=>style,:no_buttons=>no_buttons,:button_stance=>button_stance,:lapel_style=>lapel_style,:lapel_width=>lapel_width,:gorge=>gorge,:no_vents=>no_vents)
	end

end