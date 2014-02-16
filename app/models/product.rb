class Product < ActiveRecord::Base
	has_many :uploads
	has_many :ebay_listings
	accepts_nested_attributes_for :ebay_listings
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
	scope :available, -> {where("on_hand > 0 AND needs_cleaning = false AND needs_repair = false")} 


	def yn(var)
		if var=="0"
			'No'
		elsif var =="1"
			'Yes'
		end	
	end

	def types
		["Shirt","Belt","Neckwear","Shoe","Blazer","Suit","Sweater","Overcoat","Jacket","Trouser"]
	end

	def brands_col
		["Brooks Brothers","J.Crew","Jos A. Bank","Forsyth of Canada","Thomas Pink","Turnbull & Asser","Coach","Allen Edmonds","Cole Haan"].sort
	end

	def conditions_col
		["Poor","Fair","Good","Very Good","Excellent"]
	end

	def condition_description
		if condition=="Poor"
			"Very poor condition. Item is damaged and needs repair prior to wearing."
		elsif condition =="Fair"
			"Item is in fair condition. It may have small flaws that may affect the wearabilty of the item. You may need to repair the garment prior to wearing."
		elsif condition =="Good"
			"Item is in good condition. It is ready to wear and does not have any flaws. It shows normal signs of wear."
		elsif condition =="Very Good"
			"Item is in very good condition. It is ready to wear and does not have any flaws. It shows very little sign of wear."
		else
			"Item is in excellent, like new condition. It is ready to wear and shows no signs of wear."
		end
	end

	def xml_photos
		xml=String.new
		self.uploads.limit(12).each do |i|
			url="http://revive-clothiers.com"+"#{i.uploaded_file(:original)}"
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
		(shipping_weight_oz/16).floor
	end

	def weight_oz
		(shipping_weight_oz%16).floor
	end

	def choose_shipping_dom
		if shipping_weight_oz <= 13
			"USPSFirstClass"
		else
		 	"USPSPriority"
		end
	end
	def choose_shipping_int
		if shipping_weight_oz <= 64
			"USPSFirstClassMailInternational"
		else
			"USPSPriorityMailInternational"
		end
	end
end
