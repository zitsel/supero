class Brace < Product
  store_accessor :properties, :brand, :color, :material, :pattern
  
  before_save do
  	self.size = "OneSize"
  end

  def description
  	"#{color} #{material} Braces"
  end

  def ebay_attributes
  	{
  		"Size" => size,
  		"Brand" => brand,
  		"Color" => color,
  		"Material" => material
  	}
  end
  def details
  	{
  		"Brand" => brand,
  		"Color" => color,
  		"Material" => material
  	}
  end

  def measurements
  	{
  		
  	}
  end

  def ebay_title
  	"#{brand} #{description} #{size}"
  end


end
