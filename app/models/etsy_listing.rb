class EtsyListing < ActiveRecord::Base
	belongs_to :product
	
	Etsy.environment = :production
	ETSY_CONFIG = YAML::load(File.open("config/config.yml"))["etsy"]

	def self.add_item(params)
		params[:tags]=params[:tags].split(", ")
		@ready = params.except("utf8","authenticity_token","commit","method","product_id","controller","action")
		@options = @ready.merge(access)
		response = Etsy::Listing.create(@options)
		response.success? ? response.result['listing_id'] : (Rails.logger.info "something went wrong! code: #{response.code} body: #{response.body}")
	end

	def self.add_images(listing_id,product_id)
		@listing=Etsy::Listing.find(listing_id)
		@imgList=Product.find(product_id).ordered_photos.first(5)
		@imgList.map.with_index do |img,index|
			Etsy::Image.create(
				@listing,
				img.path,
				access.merge(:rank=>index+1)
				)
		end
	end


	def self.access
		Etsy.api_key = ETSY_CONFIG['api_key']
		Etsy.api_secret = ETSY_CONFIG['api_secret']
		{:access_token => ETSY_CONFIG['access_token'], :access_secret => ETSY_CONFIG['access_secret']}
	end

	def self.when_made(decade)
		["1980s","1970s","1960s","1950s","1940s","1930s","1920s","1910s","1900s","1800s","1700s"].include?(decade) ? decade : "before_1995"
	end
end
