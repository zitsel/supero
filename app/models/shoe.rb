class Shoe < Product
	store_accessor :properties, :brand, :maker, :model, :model_number, :style, :color, :size, :width, :upper_material, :upper_condition, :sole_material, :sole_type, :sole_condition, :heel_material, :heel_condition, :insole_type, :insole_condition, :lining_type, :lining_condition

def sizes
	%w[5 6 7 8 9 10 11 12 13 14 15 16 17 18 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5].sort
end

def widths
	%w[aaa aa a b c d e ee eee].map(&:upcase)

end

end
