class Misc < Product
	store_accessor :properties, :brand, :color, :size, :description
	
	def details
	{
		"Brand"	=>	:brand,
		"Color" =>	:color,
		"Size"	=>	:size
	}
	end

end