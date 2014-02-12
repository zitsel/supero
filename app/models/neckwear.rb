class Neckwear < Product
	store_accessor :properties, :brand, :label, :retailer, :material, :width, :length, :pattern, :color, :style, :weave
	def materials
		["100% Silk","100% Cotton","100% Wool","Silk Blend","Cotton Blend","Wool Blend","Unknown","Synthetic"]
	end
	def widths
		%w[2.5 2.75 3 3.25 3.5 3.75 4 4.25 4.5]
	end
	def lengths
		%w[48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64]
	end
	def styles
		%w[Bowtie Necktie Cravet]
	end
	def weaves
		["Repp","Grenadine","Plain","Knit","Printed"]
	end
end