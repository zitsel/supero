class Product < ActiveRecord::Base
	belongs_to :category
	has_many :etsy_listings
	accepts_nested_attributes_for :etsy_listings
	has_many :uploads
	has_many :ebay_listings
	accepts_nested_attributes_for :ebay_listings
	accepts_nested_attributes_for :uploads
	validates :sku, :type, :weight, :condition, presence: true
	validates_uniqueness_of :sku
	default_scope { where("on_hand > 0")}

	before_create { self.on_hand=1 }
	before_create { self.needs_photos=false }

	before_save { self.category_id=Category.where(:name=>type).take.id }
	before_save { self.brand=self.brand.try(:titleize) }
	before_save { save_brand unless brand.blank? }
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
	scope :available, -> { Product.has_photo.where("needs_cleaning != ? AND needs_photos != ? AND needs_repair != ? AND needs_review != ?",true,true,true,true) }
	scope :has_photo, -> { Product.includes(:uploads).where('uploads.product_id is not ?',nil).references(:uploads) }
	scope :tagged_needs_photo, -> { Product.where("needs_photos = true") }
	scope :needs_cleaning, -> {where("needs_cleaning = true")}
	scope :needs_repair, -> { where("needs_repair = true" ) }
	scope :needs_review, -> { where("needs_review = true" )}
	scope :needs_ebay, -> { Product.available.where("list_ebay = true").includes(:ebay_listings).where( :ebay_listings => { :product_id => nil } )}
	scope :needs_photos, -> { Product.includes(:uploads).where( :uploads => { :product_id => nil } ) }
	scope :needs_etsy, -> { Product.available.where("list_etsy=true").has_photo.where("etsy_id is ?", nil) }
	scope :sold, -> { Product.unscoped.where("on_hand = 0")}

	def save_brand
		BrandList.create(:name=>brand) unless BrandList.exists?(:name=>brand) 
	end
	def main_photo
		ordered_photos.count > 0 ? ordered_photos.first.uploaded_file(:large) : "placeholder.jpg"
	end
	def ordered_photos
		uploads.order("position")
	end
	def yn(i)
		i == "1" ? "Yes" : "No"
	end
	def etsy_title
		title=ebay_title.squish
		title.gsub! '&', 'and' if title.count('&')>1
		vintage? ? ["Vintage",decade,title].join(" ") : title
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

	def shipping_weight
         @oz_gross = (weight.to_i+self.category.package_weight.to_i)/28.35
         @lb_only = (@oz_gross/16).floor
         @oz_only = (@oz_gross%16).floor
         {
         	:lbs_only => @lb_only,
         	:oz_only => @oz_only,
         	:human => "#{@lb_only}lb #{@oz_only}oz",
         	:oz_gross => @oz_gross
         }
	end
	def shipping_service
		shipping_weight[:oz_gross] <= 13 ? "USPSFirstClass" : "USPSPriority"
		{
			:domestic => shipping_weight[:oz_gross] <= 13 ? "USPSFirstClass" : "USPSPriority",
			:international => shipping_weight[:oz_gross] <= 64 ? "USPSFirstClassMailInternational" : "USPSPriorityMailInternational"
		}
	end

end
