class EtsyListing < ActiveRecord::Base
	belongs_to :product
	
	Etsy.environment = :production
	ETSY_CONFIG = YAML::load(File.open("config/config.yml"))["etsy"]

	def self.add_item(params)

		@ready = params.except("utf8","authenticity_token","commit","method","product_id","controller","action")
		@options = @ready.merge(access)
		resp = Etsy::Listing.create(@options)
		Logger.debug "error! code: #{resp.code} body: #{resp.body} params: #{@options} ACCESS: #{access}" unless resp.success?	

		return resp.result['listing_id']
	end

	def self.add_images(listing_id,product_id)
		@listing=Etsy::Listing.find(listing_id)
		@imgList=Product.ordered_photos.first(5).reverse
		@imgList.map do |img|
			Etsy::Image.create(
				@listing,
				img_path(img),
				access
				)
		end
	end


	def self.access
		Etsy.api_key = ETSY_CONFIG['api_key']
		Etsy.api_secret = ETSY_CONFIG['api_secret']
		{:access_token => ETSY_CONFIG['access_token'], :access_secret => ETSY_CONFIG['access_secret']}
	end

	def self.img_path(img)
		"/usr/local/www/revive/public"+img.uploaded_file(:original).gsub(/\?.*/,"")
	end
end
