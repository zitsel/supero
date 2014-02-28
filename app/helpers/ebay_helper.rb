module EbayHelper
	
	class Ebay
 		EBAY_CONFIG = YAML::load(File.open("config/config.yml"))[Rails.env]
	 	include HTTParty 
		
		def self.UploadPhoto(url)
               format :xml
               
               headers(ebay_headers.merge({"X-EBAY-API-CALL-NAME" => "UploadSiteHostedPictures"}))
               requestXml = "<?xml version='1.0' encoding='utf-8'?>
                    <UploadSiteHostedPicturesRequest xmlns=\"urn:ebay:apis:eBLBaseComponents\">
                       <ExternalPictureURL>#{url}</ExternalPictureURL>
                         <RequesterCredentials>
                              <eBayAuthToken>#{auth_token}</eBayAuthToken>
                         </RequesterCredentials>
                         <WarningLevel>High</WarningLevel>
                    </UploadSiteHostedPicturesRequest>"
               response = post(api_url, :body => requestXml)
               raise "Bad Response | #{response.inspect} | #{requestXml}" if response.parsed_response['UploadSiteHostedPicturesResponse']['Ack'] == 'Failure'
               response.parsed_response['UploadSiteHostedPicturesResponse']['SiteHostedPictureDetails']['FullURL']
		end
		
    def self.AddItem(listing_type,duration,quantity,condition_id,free_shipping,start_price,buy_it_now_price,id,description,ebay_title)
      product=Product.find(id)
      images=product.xml_photos
      if buy_it_now_price==""
	  bin_xml=""
      else 
	  bin_xml="<BuyItNowPrice>#{buy_it_now_price}</BuyItNowPrice>"
      end
      format :xml
      headers(ebay_headers.merge({"X-EBAY-API-CALL-NAME" => "AddItem"}))
      requestXml = "<?xml version='1.0' encoding='utf-8'?>
           <AddItemRequest xmlns='urn:ebay:apis:eBLBaseComponents'>
                <RequesterCredentials>
                <eBayAuthToken>#{auth_token}</eBayAuthToken>
                </RequesterCredentials>
                <Item ComplexType='ItemType'>
           <!--Constants-->
                <!--General Settings-->  
                     <IncludeRecommendations>true</IncludeRecommendations>
                     <HitCounter>BasicStyle</HitCounter>
                     <CategoryMappingAllowed>true</CategoryMappingAllowed>
                     <Country>US</Country>
                     <Currency>USD</Currency>
                     <Location>Historic Valley Junction, IA</Location>
                     <Site>US</Site>
                     <!--Payments-->
                              <AutoPay>false</AutoPay>
                              <PaymentMethods>PayPal</PaymentMethods>
                              <PayPalEmailAddress>revive.clothiers@gmail.com</PayPalEmailAddress>

                         <!--Shipping-->
                              <DispatchTimeMax>1</DispatchTimeMax>
                              <PostalCode>50265</PostalCode>
                              <ShippingTermsInDescription>true</ShippingTermsInDescription>
                              <GetItFast>false</GetItFast>

                         <!--Restrictions on Buyers-->
                              <DisableBuyerRequirements>false</DisableBuyerRequirements>
                              <BuyerRequirementDetails>
                                   <ShipToRegistrationCountry>true</ShipToRegistrationCountry>
                                   <MinimumFeedbackScore>-1</MinimumFeedbackScore>
                                   <MaximumItemRequirements>
                                        <MaximumItemCount>10</MaximumItemCount>
                                        <MinimumFeedbackScore>5</MinimumFeedbackScore>
                                   </MaximumItemRequirements>
                                   <LinkedPayPalAccount>false</LinkedPayPalAccount>
                                   <MaximumUnpaidItemStrikesInfo>
                                        <Count>2</Count>
                                        <Period>Days_180</Period>
                                   </MaximumUnpaidItemStrikesInfo>
                                   <MaximumBuyerPolicyViolations>
                                        <Count>4</Count>
                                        <Period>Days_30</Period>
                                   </MaximumBuyerPolicyViolations>
                              </BuyerRequirementDetails>
                              
                         <!--Returns-->
                              <ReturnPolicy>
                                   <RefundOption>MoneyBack</RefundOption>
                                   <ReturnsWithinOption>Days_14</ReturnsWithinOption>
                                   <ReturnsAcceptedOption>ReturnsAccepted</ReturnsAcceptedOption>
                                   <Description>You may return your item for a full refund for any reason within 14 days. Buyer is responsible for return shipping unless there was an error in the listing. </Description>
                                   <ShippingCostPaidByOption>Buyer</ShippingCostPaidByOption>
                              </ReturnPolicy>

                    <!--Unique to item-->

                              #{bin_xml}
                              <Description><![CDATA[#{description}]]></Description>
                              <ListingDuration>#{duration}</ListingDuration>
                              <ListingType>#{listing_type}</ListingType>
                              <StartPrice>#{start_price}</StartPrice>
                              <Title>#{ebay_title}</Title>
                              <PrimaryCategory>
                                   <CategoryID>#{product.primary_category_id}</CategoryID>
                              </PrimaryCategory>
                              <Quantity>#{quantity}</Quantity>

                              <ConditionID>#{condition_id}</ConditionID>
                              <ConditionDescription>#{product.condition_description}</ConditionDescription>
                              <SKU>#{product.sku}</SKU>

                              <ItemSpecifics>
                                   #{product.xml_attributes}
                              </ItemSpecifics>

                              <PictureDetails>
                                <GalleryType>Plus</GalleryType>
                                #{images}
        	               			</PictureDetails>
                         
                         <ShippingDetails>
                              <GlobalShipping>false</GlobalShipping>
                              <ShippingType>Calculated</ShippingType>
                              <PaymentInstructions>Please pay within 3 days of auction close.</PaymentInstructions>    
                              <CalculatedShippingRate>
                                   <OriginatingPostalCode>50265</OriginatingPostalCode>
                                   <PackagingHandlingCosts>0</PackagingHandlingCosts>
                                   <ShippingPackage>PackageThickEnvelope</ShippingPackage>
                                   <WeightMajor>#{product.weight_lb}</WeightMajor>
                                   <WeightMinor>#{product.weight_oz}</WeightMinor>
                                   <InternationalPackagingHandlingCosts>0</InternationalPackagingHandlingCosts>
                             </CalculatedShippingRate>
                             <ShippingServiceOptions>
                                   <ShippingService>#{product.choose_shipping_dom}</ShippingService>
                                   <ShippingServicePriority>1</ShippingServicePriority>
                                   <FreeShipping>#{free_shipping}</FreeShipping>
                              </ShippingServiceOptions>
                              <InternationalShippingServiceOption>
                                   <ShippingService>#{product.choose_shipping_int}</ShippingService>
                                   <ShippingServicePriority>1</ShippingServicePriority>
                                   <ShipToLocation>Worldwide</ShipToLocation>
                              </InternationalShippingServiceOption>
                          </ShippingDetails>
                        
                         </Item>

                         <ErrorLanguage>en_US</ErrorLanguage>
                         <Version>857</Version>
                         <ErrorHandling>FailOnError</ErrorHandling>
                         <WarningLevel>Low</WarningLevel>
                    </AddItemRequest>"

               requestXml
               response = post(api_url, :body => requestXml)
               raise "Bad Response | #{response.inspect}" if response.parsed_response['AddItemResponse']['Ack'] == 'Failure'
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
    end
end
