class Product < ActiveRecord::Base
	is_impressionable :counter_cache => true, :column_name => :impressions_count
	STATUSES = ["active","sold_out","unavailable","processing","pending"]
	belongs_to :category
	has_many :etsy_listings
	accepts_nested_attributes_for :etsy_listings
	has_many :uploads
	has_many :ebay_listings
	accepts_nested_attributes_for :ebay_listings
	accepts_nested_attributes_for :uploads
	validates :sku, :type, :weight, :condition, presence: true
	has_many :ordered_items
	validates :status, inclusion: STATUSES
	validates_uniqueness_of :sku

	before_create { self.on_hand = 1 }
	before_save { self.category_id = Category.find_by_name(type).id }
	before_save :save_brand

	def save_brand
			self.brand = self.brand.try(:titleize) unless brand.nil?
	end
	
	def self.sizes
		sizes = self.uniq.pluck(:size)
		sizes.delete(nil)
		sizes.sort
	end	

	def self.colors
		["Blue","Red","Yellow"]
	end
	def self.styles
		["Foo","Bar","Baz"]
	end

	Category.all.each do |cat|
		scope cat.symbolize, -> { where(type: cat.name) }
	end

	scope :active, -> { where(status: 'active') }
	scope :sold_out, -> { where(status: 'sold_out') }
	scope :unavailable, -> { where(status: 'unavailable') }
	scope :processing, -> { where(status: 'processing') }
	scope :pending, -> { where(status: 'pending') }

	scope :vintage, -> { where ( "vintage = true" )}
	scope :available, -> { Product.active.has_photo.where("needs_cleaning != ? AND needs_photos != ? AND needs_repair != ? AND needs_review != ?",true,true,true,true) }
	scope :has_photo, -> { Product.includes(:uploads).where('uploads.product_id is not ?',nil).references(:uploads) }
	scope :tagged_needs_photo, -> { Product.where("needs_photos = true") }
	scope :needs_cleaning, -> {where("needs_cleaning = true")}
	scope :needs_repair, -> { where("needs_repair = true" ) }
	scope :needs_review, -> { where("needs_review = true" )}
	scope :needs_ebay, -> { Product.available.where("list_ebay = true").includes(:ebay_listings).where( :ebay_listings => { :product_id => nil } )}
	scope :needs_photos, -> { Product.includes(:uploads).where( :uploads => { :product_id => nil } ) }
	scope :needs_etsy, -> { Product.available.where("list_etsy=true").has_photo.where("etsy_id is ?", nil) }
	scope :sold, -> { Product.unscoped.where("on_hand = 0")}
	scope :new_arrivals, -> { Product.active.order("created_at desc").limit(50)}

	def active?
		self.status == "active"
	end

	def slug
		[brand,description,"Size",size].join(" ")
	end

	def mark_sold
	  EtsyListing.deactivate_listing(etsy_id) if etsy_id?
      EbayListing.end_listing(ebay_id) if ebay_id
      update_attributes(:on_hand=>0,:status=>'sold_out')
	end

	def mark_unsold
		EtsyListing.reactivate_listing(etsy_id) if etsy_id?
		update_attributes(:on_hand=>1,:status=>'active')
	end

	def new_arrival?
		self.created_at >= 30.days.ago
	end
	def ebay_id
		ebay_listings.last.ebay_item_id if ebay_listings.any?
	end

	def save_brand
		BrandList.create(:name=>brand) unless BrandList.exists?(:name=>brand) 
	end
	def main_photo
		ordered_photos.exists? ? ordered_photos.first.uploaded_file(:large) : "placeholder.jpg"
	end
	def thumb
		ordered_photos.exists? ? ordered_photos.first.uploaded_file(:medium) : "placeholder.jpg"

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
