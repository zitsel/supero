module EtsyListingsHelper




Etsy.environment = :production

def access
	Etsy.api_key = 'muhtstr67euth90kral4ismi'
	Etsy.api_secret = 'cfh4vw7l99'
	{:access_token => 'd3945d56a13b3934485dc82f059d48', :access_secret => 'e114aa062d'}
end

#def user
#	Etsy.myself(access[:access_token],access[:access_secret])
#end
#
#def shop
#	Etsy.shop(user)
#end
#
#def sections
#	Etsy::Sections.find_by_shop(shop)
#end



def add_item(params)

	@ready = params.except("utf8","authenticity_token","commit","method","product_id","controller","action")
	@options = @ready.merge(access)
	#@options = @ready.merge({:access_token => 'd3945d56a13b3934485dc82f059d48', :access_secret => 'e114aa062d'})
	resp = Etsy::Listing.create(@options)
	raise "error! code: #{resp.code} body: #{resp.body} params: #{@options} ACCESS: #{access}" unless resp.success?	

	return resp.result['listing_id']
end

def add_images(listing_id,product_id)
	@listing=Etsy::Listing.find(listing_id)
	@imgList=Product.find(product_id).uploads.first(5).reverse
	@imgList.map do |img|
		Etsy::Image.create(
			@listing,
			img_path(img),
			access
			)
	end
end

def img_path(img)
 	"/usr/local/www/revive/public"+img.uploaded_file(:original).gsub(/\?.*/,"")
end

end
