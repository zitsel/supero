    class OldShirt < ActiveRecord::Base
	self.table_name = "shirts"
	establish_connection :legacy 
	def fit
		if slim_fit == "true"
			"Slim Fit, Fitted"
		else
			"Classic Fit"
		end
	end
    def to_model
	    Shirt.create!(:brand=>brand,:collar_size=>collar_m,:sku=>sku,:weight=>weight,:label=>label,:retailer=>retailer,:color=>color,:pattern=>pattern,:collar_type=>collar_type,:sleeve_size=>sleeve_m,:material=>fabric_type,:price=>retail,:needs_repair=>needs_repair,:needs_cleaning=>needs_cleaned,:cuff_type=>cuff_type,:fit=>fit)
	end


end
