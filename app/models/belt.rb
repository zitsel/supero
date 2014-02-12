class Belt < Product
	store_accessor :properties, :brand, :belt_material, :color, :size, :buckle_material, :length, :width, :fhole, :lhole
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

end