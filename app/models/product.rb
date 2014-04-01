class Product < ActiveRecord::Base
	belongs_to :category
	#has_many :etsy_listings
	#accepts_nested_attributes_for :etsy_listings
	has_many :uploads
	has_many :ebay_listings
	accepts_nested_attributes_for :ebay_listings
	accepts_nested_attributes_for :uploads
	validates :sku, :type, :weight, :condition, presence: true
	validates_uniqueness_of :sku
	default_scope { where("on_hand > 0")}
	before_create do
		self.on_hand=1
	end

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
	scope :available, -> { Product.has_photo.where.not("needs_cleaning = true AND needs_repair = true AND needs_review = true") }
	scope :has_photo, -> { Product.includes(:uploads).where('uploads.product_id is not ?',nil).references(:uploads) }
	scope :needs_cleaning, -> {where("needs_cleaning = true")}
	scope :needs_repair, -> { where("needs_repair = true" ) }
	scope :needs_review, -> { where("needs_review = true" )}
	scope :needs_ebay, -> { Product.available.where("list_ebay = true").includes(:ebay_listings).where( :ebay_listings => { :product_id => nil } )}
	scope :needs_photos, -> { Product.includes(:uploads).where( :uploads => { :product_id => nil } )}
	scope :needs_etsy, -> { Product.available.where("list_etsy=true").has_photo.where("etsy_id is ?", nil) }
	scope :sold, -> { Product.unscoped.where("on_hand = 0")}
	def main_photo
		ordered_photos.count > 0 ? ordered_photos.first.uploaded_file(:large) : "placeholder.jpg"
	end
	def ordered_photos
		uploads.order("position")
	end

	def etsy_title
		title=ebay_title.squish
		if title.count('&')>1
			title.gsub! '&', 'and'
		else
			title
		end
	end

	def yn(var)
		if var=="0"
			'No'
		elsif var =="1"
			'Yes'
		end	
	end

	def decades_col
		["2010s","2000s","1990s","1980s","1970s","1960s","1950s","1940s","1930s","1920s","1910s","1900s"]
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
	def shipping_weight_oz(item_weight,packaging_weight)
     #takes item weight in grams, adds in the weight of the packaging and returns total shipping weight in oz
         (weight.to_i++category.package_weight)/28.35
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
