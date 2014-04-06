ActiveAdmin.register EbayListing do
  belongs_to :product
  controller do
    def create
      listing_info=EbayListing.add_item(params) #params[:listing_type],params[:duration],params[:quantity],params[:condition_id],params[:free_shipping],params[:start_price],params[:buy_it_now_price],params[:product_id],params[:description].squish,params[:ebay_title])
      @ebay_listing = EbayListing.new(listing_info)
      create! { "http://www.ebay.com/itm/#{@ebay_listing.ebay_item_id}" }
    end

end

index do 
  column :product_id
  column :ebay_id
  default_actions
end

form :partial => "form"
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
