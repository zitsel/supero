ActiveAdmin.register EtsyListing do
  belongs_to :product
  controller do
    def create
      @etsy_id = EtsyListing.add_item(params)
      @product_id = params["product_id"]
      EtsyListing.add_images(@etsy_id,@product_id)

      @etsy_listing = EtsyListing.new(:product_id=>@product_id,:etsy_id=>@etsy_id)
      Product.find(@product_id).update_attributes(:etsy_id=>@etsy_id)
      create! { "http://www.etsy.com/listing/#{@etsy_id}" }
    end

end

index do 
  column :product_id
  column :etsy_id
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
