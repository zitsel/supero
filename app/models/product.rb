class Product < ActiveRecord::Base
	has_many :uploads
	validates :sku, :type, :weight, presence: true
	validates :sku, uniqueness: true
	
	scope :shirts, -> { where(type: 'Shirt') }
	scope :belts, -> { where(type: 'Belt') }
	scope :neckwears, -> { where(type: 'Neckwear') }
	scope :shoes, -> { where(type: 'Shoes') }
	scope :jackets, -> { where(type: 'Jacket') }
	scope :trousers, -> { where(type: 'Trouser') }
	scope :blazers, -> { where(type: 'Blazer') }
	scope :suits, -> { where(type: 'Suit') }
	scope :sweaters, -> { where(type: 'Sweater') }
	scope :overcoats, -> { where(type: 'Overcoat') }

	def types
		["Shirt","Belt","Neckwear","Shoe","Blazer","Suit","Sweater","Overcoat","Jacket","Trouser"]
	end

	def brand_col
		["Brooks Brothers","J.Crew","Jos A. Bank","Forsyth of Canada","Thomas Pink","Turnbull & Asser","Coach","Allen Edmonds","Cole Haan"].sort
	end

	def condition_col
		%w[1 2 3 4 5]
	end

	def condition_description
		"Condition Description Logic"
	end

	def xml_photos
		xml=String.new
		self.uploads.limit(12).each do |i|
			#url="http://revive-clothiers.com"+"#{i.uploaded_file(:original)}"
			url="http://revive-clothiers.com/wp-content/uploads/2014/01/DSC_6325.jpg"
			xml+="<PictureURL>#{EbayHelper::Ebay::UploadPhoto(url)}</PictureURL>"
		end
		xml
	end

	def xml_attributes
		xml = String.new
		ebay_attributes.each do |k,v|
			xml+="<NameValueList><Name>#{k}</Name><Value>#{v}</Value></NameValueList>"
		end
		xml
	end

	def weight_lb
		shipping_weight/453
	end

	def weight_oz
		((shipping_weight%453)/28.3495).round
	end

	def choose_shipping
		if weight_lb/16+weight_oz <= 13
			USPSFirstClass
		else
			USPSPriority
		end
	end
end
