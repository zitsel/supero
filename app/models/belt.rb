class Belt < Product
	store_accessor :properties, :tagged_size, :brand, :belt_material, :color, :buckle_material, :length, :width, :fhole, :lhole
	before_save do
		self.size=tagged_size
	end
	def ebay_category_information
		"The belt's stated size corresponds to roughly the middle hole. You should order a belt in your actual waist size. Please check your actual measurements before ordering as it may be larger than your trouser size. Many manufacturers (especially for casual pants) cut the waist of the trousers as much as 4\" larger than tagged."
	end
	def belt_materials
		["Leather","Exotic Leather","Canvas","Other"]
	end
	def sizes
		%w[28 30 32 34 36 38 40 42 44 46 48 50 52 54 56]
	end
	def buckle_materials
		["Brass","Nickle","Other"]
	end
	def lengths
		%w[28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60]
	end
	def widths
		%w[.50 .675 .750 .875 1.00 1.125 1.25 1.5 1.75 2.0]
	end
	def fholes
		%w[28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60]
	end
	def lholes
		%w[28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60]
	end
           

	def ebay_title
		title="#{brand.try(:titleize)}"
		title+=" #{color.try(:titleize)} #{belt_material.try(:titleize)} #{size} Belt"
		title
	end

	def description
		"#{color} #{belt_material} Belt"
	end
	
	def details
	{
		"Brand"=>brand,
		"Material"=>belt_material,
		"Color"=>color,
		"Buckle Material"=>buckle_material,
	}
	end
	def measurements
	{
		"Length"=>length,
		"Width"=>width,
		"First Hole"=>fhole,
		"Last Hole"=>lhole,
	} 
	end

	def ebay_attributes
		{
		"Brand"=>brand,
		"Size"=>ebay_size,
		"Color"=>color,
		"Material"=>belt_material,
		}
	end

	def ebay_size
	    self.size = size.to_i
		if size <= 26
			"25-26"
		elsif size <= 28
			"27-28"
		elsif size <= 30
			"29-30"
		elsif size <= 32
			"31-32"
		elsif size <= 34
			"33-34"
		elsif size <= 36
			"35-36"
		elsif size <= 38
			"37-38"
		elsif size <= 40
			"39-40"
		elsif size <= 42
			"41-42"
		elsif size <= 44
			"43-44"
		elsif size <= 46
			"45-46"
		elsif size <= 48
			"47-48"
		elsif size <= 50
			"49-50"
		elsif size <= 52
			"51-52"
		elsif size <= 54
			"53-54"
		elsif size <= 56
			"55-56"
		elsif size <= 58
			"57-58"
		else
			"59-60"
		end 
	end
	def price_col
		[8.00, 12.00, 18.00, 24.00, 34.00]
	end
end
