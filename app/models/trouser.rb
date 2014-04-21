class Trouser < Product
	store_accessor :properties, :brand, :label, :retailer, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, :cloth_pattern, :trouser_style, :trouser_fly, :trouser_waistband_style, :trouser_waistband_lining, :belt_loops, :brace_buttons, :tab_adjust, :crotch_shield, :front_closure, :front_pockets_style, :trouser_lining, :trouser_bottoms, :trouser_condition, :trouser_waistband_width_measure, :trouser_waist_outlet_measure, :trouser_seat_measure, :thigh_measure, :knee_measure, :cuff_width_measure, :inseam_measure, :outseam_measure, :inseam_outlet_measure
    before_update do
    	self.size=waist_size
    end

 	def ebay_category_information
 		"We sell all of our dress trousers by their <i>actual measurements</i>. Please check your measurements before ordering to ensure that you get a good fit. 
 		Please contact us if you need any assistance with fitting.<br />
 		<br />
 		<br />
 		<p>We make every effort to offer only the absolute highest quality products. 
 		All of our suiting goes through our extensive inspection and revitalization process prior to being offered for sale.
 		This includes un-hemming the trousers, clipping loose stitches, making minor repairs, cleaning and a proper pressing.</p>
 		<h2>Alterations</h2>
 		<p>Basic alterations are free when you \"Buy it Now\"! Trouser hemming is included with all auctions. <br />
		Please see auction description for available outlets. All outlet measurements are the actual amount of fabric. Each seam will need an allowance of .25\" on each side or .5\" per seam.</p>"

 	end	

	def trouser_styles_col
		["Casual Pants","Corduroys","Dress - Flat Front","Dress - Pleat","Khakis, Chinos",]	
	end
	def ebay_title
		title="#{brand.try(:titleize)}"
		title+=" #{label.try(:titleize)} " if label
		title+=" #{cloth_color.try(:titleize)} #{waist_size}/#{ebay_inseam}"
		title+=" #{trouser_style.try(:titleize)}" if title.length<69
		title+=" #{cloth_composition.try(:titleize)}" if title.length<69
		title
	end
	def size
		waist_size
	end
	def description
		"#{cloth_color} #{trouser_style} Trousers"
	end
	def measurements
		{
			"Waist"=>waist_size,
			"Waist Outlet"=>trouser_waist_outlet_measure,
			"Seat"=>trouser_seat_measure,
			"Thigh"=>thigh_measure,
			"Knee"=>knee_measure,
			"Cuff"=>cuff_width_measure,
			"Inseam"=>inseam_measure,
			"Outseam"=>outseam_measure,
			"Inseam Outlet"=>inseam_outlet_measure

		}
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
			"Trouser Style"=>trouser_style,
			"Fly"=>trouser_fly,
			"Waistband"=>trouser_waistband_style,
			"Waistband Lining"=>trouser_waistband_lining,
			"Belt Loops"=>yn(belt_loops),
			"Brace Buttons"=>yn(brace_buttons),
			"Tab Adjust"=>yn(tab_adjust),
			"Crotch Shield"=>yn(crotch_shield),
			"Front Closure"=>front_closure,
			"Front Pockets"=>front_pockets_style,
			"Trouser Lining"=>trouser_lining,
			"Trouser Bottoms"=>trouser_bottoms,
		}
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
			inseam_measure.to_d.floor
		end
	end
	def waist_size
		(trouser_waistband_width_measure.to_d*2).floor.to_s unless trouser_waistband_width_measure.nil?
	end

end
