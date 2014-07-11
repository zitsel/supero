class Hat < Product
  store_accessor :properties, :brand, :style, :color, :material, :pattern, :tagged_size, :diameter, :depth
  
  before_save do
  	self.size = self.tagged_size
  end

  def description
  	"#{color} #{material} #{style} Hat"
  end

  def ebay_attributes
  	{
  		"Size" => size,
  		"Brand" => brand,
      "Style" => style,
  		"Color" => color,
  		"Material" => material
  	}
  end
  def details
  	{
  		"Brand" => brand,
		  "Style" => style,
  		"Color" => color,
  		"Material" => material,
		  "Pattern" => pattern
  	}
  end

  def measurements
  	{
	    "Diameter" => diameter,
	    "Depth" => depth
  	}
  end

  def ebay_title
  	"#{brand} #{description} #{size}"
  end

  def sizes_col 
    ["6," "6 1/2", "6 3/4", "6 7/8", "7,", "7 1/8", "7 1/4", "7 3/8", "7 5/8", "8", "8 1/2", "XS", "S", "M", "L", "XL", "2XL", "One Size", "Adjustable", "7 1/2", "7 3/4", "7 7/8",].sort
  end

  def styles_col
    ["Aviator/Trapper","Bandana","Baseball Cap","Beanie","Beret","Boonie/Bush","Bowler/Derby","Bucket","Cadet/Military","Cowboy/Western","Du-Rag/Biker","Fedora/Trilby","Newsboy/Cabbie","Panama","Russian Ushanka/Cossack","Ski","Top Hat","Trucker","Visor","Wide Brim"]
  end
 
end
