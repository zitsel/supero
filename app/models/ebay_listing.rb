class EbayListing < ActiveRecord::Base
	belongs_to :product

	EBAY_CONFIG = YAML::load(File.open("config/config.yml"))[Rails.env]
	include HTTParty 

	def self.upload_photo(url)
		format :xml

		headers(ebay_headers.merge({"X-EBAY-API-CALL-NAME" => "UploadSiteHostedPictures"}))
		@xm = ::Builder::XmlMarkup.new
		@xm.instruct!
		@xm.tag!('UploadSiteHostedPicturesRequest', {"xmlns"=>"urn:ebay:apis:eBLBaseComponents"}) do
			@xm.ExternalPictureURL(url)
			@xm.RequesterCredentials {
				@xm.eBayAuthToken(auth_token)
			}
			@xm.WarningLevel("High")
		end
		response = post(api_url, :body => @xm.target!)
		#logger.debug "xml: #{@xm}"
		Rails.logger.info "Bad Response | #{response.inspect} | #{@xm}" if response.parsed_response['UploadSiteHostedPicturesResponse']['Ack'] == 'Failure'
		response.parsed_response['UploadSiteHostedPicturesResponse']['SiteHostedPictureDetails']['FullURL']
	end

	def self.add_item(params) #listing_type,duration,quantity,condition_id,free_shipping,start_price,buy_it_now_price,id,description,ebay_title)
		product=Product.find(params["product_id"])
		listing_type=params["listing_type"]
		duration=params["duration"]
		quantity=params["quantity"]
		condition_id=params["condition_id"]
		free_shipping=params["free_shipping"]
		start_price=params["start_price"]
		buy_it_now_price=params["buy_it_now_price"]
		description=params["description"].squish
		ebay_title=params["ebay_title"]
		@photos=Array.new
		product.ordered_photos.limit(12).each do |photo|
			@photos.push(upload_photo(photo.uri))
		end


		format :xml
		headers(ebay_headers.merge({"X-EBAY-API-CALL-NAME" => "AddItem"}))
		@xm = ::Builder::XmlMarkup.new
		@xm.instruct!
		@xm.tag!('AddItemRequest', {"xmlns"=>"urn:ebay:apis:eBLBaseComponents"}) do
			@xm.RequesterCredentials {
				@xm.eBayAuthToken(auth_token)
			}
			
			@xm.tag!('Item', {"ComplexType"=>"ItemType"}) do
				@xm.IncludeRecommendations("true")
				@xm.HitCounter("BasicStyle")
				@xm.CategoryMappingAllowed("true")
				@xm.Country("US")
				@xm.Currency("USD")
				@xm.Location("History Valley Junction, IA")
				@xm.Site("US")
				@xm.AutoPay("false")
				@xm.PaymentMethods("PayPal")
				@xm.PayPalEmailAddress("cale_n_ash@yahoo.com")
				@xm.DispatchTimeMax("1")
				@xm.PostalCode("50265")
				@xm.ShippingTermsInDescription("true")
				@xm.GetItFast("false")
				@xm.DisableBuyerRequirements("false")
				@xm.BuyerRequirementDetails {
					@xm.ShipToRegistrationCountry("true")
					@xm.MinimumFeedbackScore("-1")
					@xm.MaximumItemRequirements {
						@xm.MaximumItemCount("10")
						@xm.MinimumFeedbackScore("5")
					}
					@xm.LinkedPayPalAccount("false")
					@xm.MaximumUnpaidItemStrikesInfo {
						@xm.Count("2")
						@xm.Period("Days_180")
					}
					@xm.MaximumBuyerPolicyViolations {
						@xm.Count("4")
						@xm.Period("Days_30")
					}
				}
				@xm.ReturnPolicy {
					@xm.RefundOption("MoneyBack")
					@xm.RetrunsWithinOption("Days_14")
					@xm.ReturnsAcceptedOption("ReturnsAccepted")
					@xm.Description("You may return your item for a full refund for any reason within 14 days. Buyer is responsible for return shipping unless there was an error in the listing.")
					@xm.ShippingCostPaidByOption("Buyer")
				}
				@xm.BuyItNowPrice(buy_it_now_price) unless buy_it_now_price.empty?
				@xm.Description{
					@xm.cdata!(description)
				}
				@xm.ListingDuration(duration)
				@xm.ListingType(listing_type)
				@xm.StartPrice(start_price)
				@xm.Title(ebay_title)
				@xm.PrimaryCategory {
					@xm.CategoryID(product.category.ebay_category_id)
				}
				@xm.Quantity(quantity)
				@xm.ConditionID(condition_id)
				@xm.SKU(product.sku)
				@xm.ItemSpecifics {
					product.ebay_attributes.each do |k,v|
						@xm.NameValueList {
							@xm.Name(k)
							@xm.Value(v)
						}
					end
				}
				@xm.PictureDetails {
					@xm.GalleryType("Plus")
						@photos.each do |i|
							@xm.PictureURL(i)
						end
						#@xm.PictureURL(upload_photo("http://revive-clothiers.com/#{photo.uploaded_file(:original)}"))
						#@xm.PictureURL((EbayListing.upload_photo(photo.uri)))
					
					}
					@xm.ShippingDetails {
						@xm.GlobalShipping("false")
						@xm.ShippingType("Calculated")
						@xm.PaymentInstructions("Please pay within 3 days of auction close")
						@xm.CalculatedShippingRate {
							@xm.OriginatingPostalCode("50265")
							@xm.PackagingHandlingCosts("0")
							@xm.ShippingPackage("PackageThickEnvelope")
							@xm.WeightMajor(product.shipping_weight[:lbs_only])
							@xm.WeightMinor(product.shipping_weight[:oz_only])
							@xm.InternationalPackagingHandlingCosts("0")
						}
						@xm.ShippingServiceOptions {
							@xm.ShippingService(product.shipping_service[:domestic])
							@xm.ShippingServicePriority("1")
							@xm.FreeShipping(free_shipping)
						}
						@xm.InternationalShippingServiceOption {
							@xm.ShippingService(product.shipping_service[:international])
							@xm.ShippingServicePriority("1")
							@xm.ShipToLocation("Worldwide")
						}
					}

				end

				@xm.ErrorLanguage("en_us")
				@xm.Version("857")
				@xm.ErrorHandling("BestEffort")
				@xm.WarningLevel("Low")
			end
			#logger.debug "xml:#{@xm}"
			response = post(api_url, :body => @xm.target!)
			#Rails.logger.debug "#{@xm.target!}"
			Rails.logger.info "Bad Response | #{response.inspect}" if response.parsed_response['AddItemResponse']['Ack'] == 'Failure'
			add_item_response=response.parsed_response['AddItemResponse']
			return {"product_id"=>product.id,
				"ebay_item_id"=>add_item_response['ItemID'],
				"start_time"=>add_item_response['StartTime'],
				"end_time"=>add_item_response['EndTime']}
            	#insertion_fees= fees logic needs added
               #EbayListing.create(:product_id=>product.id,:ebay_item_id=>ebay_item_id,:start_time=>start_time,:end_time=>end_time)
    end

	private
		def self.ebay_headers
			{"X-EBAY-API-COMPATIBILITY-LEVEL" => "857",
			"X-EBAY-API-DEV-NAME" => EBAY_CONFIG['dev_id'],
			"X-EBAY-API-APP-NAME" => EBAY_CONFIG['app_id'],
			"X-EBAY-API-CERT-NAME" => EBAY_CONFIG['cert_id'],
			"X-EBAY-API-SITEID" => "0",
			"Content-Type" => "text/xml"}
		end
		def self.auth_token
			EBAY_CONFIG['auth_token']
		end
		def self.api_url
			EBAY_CONFIG['uri']
		end	
		def build_description

		end

end
