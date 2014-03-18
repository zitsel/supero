class Product < ActiveRecord::Base
	has_many :etsy_listings
	accepts_nested_attributes_for :etsy_listings
	has_many :uploads
	has_many :ebay_listings
	accepts_nested_attributes_for :ebay_listings
	accepts_nested_attributes_for :uploads
	validates :sku, :type, :weight, :condition, :on_hand, presence: true
	validates :sku, uniqueness: true

#	Type.all.each do |type|
#		scope type.name.underscore.downcase.pluralize.to_sym, -> { where(type: type) }
#	end	
	scope :shirts, -> { where(type: 'Shirt') }
	scope :dress_shirts, -> { where(type: 'DressShirt') }
	scope :casual_shirts, -> { where(type: 'CasualShirt') }
	scope :belts, -> { where(type: 'Belt') }
	scope :belts, -> { where(type: 'Belt') }
	scope :neckwears, -> { where(type: 'Neckwear') }
	scope :shoes, -> { where(type: 'Shoes') }
	scope :jackets, -> { where(type: 'Jacket') }
	scope :trousers, -> { where(type: 'Trouser') }
	scope :blazers, -> { where(type: 'Blazer') }
	scope :suits, -> { where(type: 'Suit') }
	scope :sweaters, -> { where(type: 'Sweater') }
	scope :overcoats, -> { where(type: 'Overcoat') }
	scope :dress_shoes, -> { where(type: 'DressShoe') }
	scope :casual_shoes, -> { where(type: 'CasualShoe') }
	scope :boots, -> { where(type: 'Boot') }
	scope :braces, -> { where(type: 'Brace') }

	scope :vintage, -> { where ( "vintage = true" )}
	scope :available, -> {where("on_hand > 0 AND needs_cleaning = false AND needs_repair = false")} 
	scope :needs_cleaning, -> {where("needs_cleaning = true")}
	scope :needs_repair, -> { where("needs_repair = true" ) }
	scope :needs_listing, -> { Product.includes(:ebay_listings).where( :ebay_listings => { :product_id => nil } )}
	scope :needs_photos, -> { Product.includes(:uploads).where( :uploads => { :product_id => nil } )}
	scope :needs_etsy, -> { Product.includes(:etsy_listings).where( :etsy_listings => { :product_id => nil } )}


	def yn(var)
		if var=="0"
			'No'
		elsif var =="1"
			'Yes'
		end	
	end

	def types
		["DressShirt","CasualShirt","Belt","Neckwear","DressShoe","CasualShoe","Boot","Brace","Blazer","Suit","Sweater","Overcoat","Jacket","Trouser"]
	end

	def brands_col
		["Brooks Brothers","J.Crew","Jos A. Bank","Forsyth of Canada","Thomas Pink","Turnbull & Asser","Coach","Allen Edmonds","Cole Haan"].sort
	end

	def conditions_col
		["Poor","Fair","Good","Very Good","New"]
	end

	def condition_description
		if condition=="Poor"
			"Very poor condition. Item is damaged and needs repair prior to wearing. #{condition_notes}"
		elsif condition =="Fair"
			"Item is in fair condition. It may have small flaws that may affect the wearabilty of the item. You may need to repair the garment prior to wearing. #{condition_notes}"
		elsif condition =="Good"
			"Item is in good condition. It is ready to wear and does not have any flaws. It shows normal signs of wear. #{condition_notes}"
		elsif condition =="Very Good"
			"Item is in very good condition. It is ready to wear and does not have any flaws. It shows very little sign of wear. #{condition_notes}"
		else
			"Item is in excellent, like new condition. It is ready to wear and shows no signs of wear. #{condition_notes}"
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
