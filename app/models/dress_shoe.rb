class DressShoe < Product
	store_accessor :properties, :brand, :maker, :model, :model_number, :style, :color, :size_only, :width, :upper_material, :upper_condition, :sole_material, :sole_type, :sole_condition, :heel_material, :heel_condition, :insole_type, :insole_condition, :lining_type, :lining_condition
	before_update do 
		self.size=[size_only,width].join("")
	end
	
	def description
	description="#{color} "
	description+="#{model} " if model
	description+="#{style}"
	description
	end

	def details
	{
		"Brand"=>brand,
		"Maker"=>maker,
		"Model"=>model,
		"Model Number"=>model_number,
		"Style"=>style,
		"Color"=>color,
		"Upper Material"=>upper_material,
		"Upper Condition"=>upper_condition,
		"Sole Type"=>sole_type,
		"Sole Condition"=>sole_condition,
		"Heel Type"=>heel_material,
		"Heel Condition"=>heel_condition,
		"Lining"=>lining_type,
		"Lining Condition"=>lining_condition,
		"Insole"=>insole_type,
		"Insole Condition"=>insole_condition
	}
	end
	def measurements
		{

		}
	end
	def sizes_only
		%w[5 6 7 8 9 10 11 12 13 14 15 16 17 18 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5].sort
	end

	def widths
		%w[aaa aa a b c d e ee eee].map(&:upcase)
	end


	def ebay_title
		title="#{brand.try(:titleize)}"
		title+=" #{model.try(:titleize)} " if model
		title+=" #{color.try(:titleize)} #{style.try(:titleize)} #{size.try(:titleize)} " 
		title+=" Dress Shoe" if title.length<69
		title
	end

	def ebay_attributes
		{
		"Brand"=>brand,
		"Style"=>style,
		"US Shoe Size (Men's)"=>size_only,
		"Width"=>width,
		"Color"=>color,
		"Material"=>upper_material,
		}
	end

end
