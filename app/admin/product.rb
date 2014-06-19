ActiveAdmin.register Product do
  config.per_page = 250

  batch_action :mark_sold do |selection|
    Product.find(selection).each do |product|
      product.mark_sold
      end
      redirect_to collection_path, :notice => "Items marked as sold!"
  end
  batch_action :mark_unsold do |selection|
    Product.find(selection).each do |product|
      product.mark_unsold
      end
      redirect_to collection_path, :notice => "Items marked as unsold!"
  end
  batch_action :tag_for_ebay do |selection|
    Product.find(selection).each do |product|
      product.update_attributes(:list_ebay=>true)
    end
    redirect_to collection_path, :notice => "Items tagged for eBay."
  end
  batch_action :tag_for_etsy do |selection|
    Product.find(selection).each do |product|
      product.update_attributes(:list_etsy=>true)
    end
    redirect_to collection_path, :notice => "Items tagged for etsy."
  end
  batch_action :tag_for_photos do |selection|
    Product.find(selection).each do |product|
      product.update_attributes(:needs_photos=>true)
    end
    redirect_to collection_path, :notice => "Items tagged for photos."
  end
  batch_action :untag_for_photos do |selection|
    Product.find(selection).each do |product|
      product.update_attributes(:needs_photos=>false)
    end
    redirect_to collection_path, :notice => "Items untagged for photos."
  end

  batch_action :destroy, false

  form :partial => "form"
  controller do
    before_action :set_type
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def set_type
      @type = type
    end
    def type
      params[:type] || "Product"
    end
    def type_class
      type.constantize
    end
    def new
      @product = type_class.new
      @product.sku =  Random.new.rand(10000..99999) 
      @product.condition = "Good"
    end
    def set_product
      @product = type_class.unscoped.find(params[:id])
    end
    def permitted_params
      params.require(type.underscore.downcase.to_sym).permit(:id, :category_id, :brand, :status, :tagged_size, :price, :size_only,:coat_size, :size_type, :size, :sleeve_length, :material, :style, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :sleeve_measure, :coat_length, :coat_chest_measure, :mfg_date, :needs_cleaning, :needs_repair, :vintage, :product, :fit, :material, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :mfg_date, :mfg_country, :retail, :on_hand, :buttons, :vents, :lining, :notes, :condition, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :full_length_measure, :sleeve_measure, :tagged_size, :style, :pattern, :color, :shoulder_measure, :sleeve_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :condition, :notes, :label, :retailer, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, :cloth_pattern, :trouser_style, :trouser_fly, :trouser_waistband_style, :trouser_waistband_lining, :belt_loops, :brace_buttons, :tab_adjust, :crotch_shield, :front_closure, :front_pockets_style, :trouser_lining, :trouser_bottoms, :trouser_condition, :trouser_waistband_width_measure, :trouser_waist_outlet_measure, :trouser_seat_measure, :thigh_measure, :knee_measure, :cuff_width_measure, :inseam_measure, :outseam_measure, :inseam_outlet_measure, :brand, :label, :retailer, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, :cloth_pattern, :coat_style, :no_buttons, :button_stance, :lapel_style, :lapel_width, :gorge, :no_vents, :canvas, :lining, :lining_material, :cuff_style, :no_cuff_buttons, :button_type, :pocket_style, :notes, :coat_condition, :coat_shoulder_measure, :coat_waist_measure, :coat_seat_measure, :coat_sideseam_outlet_measure, :coat_full_length_measure, :left_sleeve_top_measure, :left_sleeve_bottom_measure, :left_sleeve_outlet_measure, :right_sleeve_top_measure, :right_sleeve_bottom_measure, :right_sleeve_outlet_measure, :armscye_measure, :elbow_measure, :cuff_width_measure, :sku, :type, :weight, :properties, :maker, :model, :model_number, :style, :color, :size, :width, :upper_material, :upper_condition, :sole_material, :sole_type, :sole_condition, :heel_material, :heel_condition, :insole_type, :insole_condition, :lining_type, :lining_condition, :brand, :label, :weaves, :retailer, :color, :pattern, :collar_type, :cuff_type, :brand, :label, :retailer, :material, :width, :length, :pattern, :color, :style, :collar_size, :sleeve_size, :belt_material, :color, :size, :buckle_material, :length, :width, :fhole, :notes, :condition_notes, :lhole, :list_etsy, :list_ebay, :decade, :internal_notes, :needs_review, :needs_photos)
    end
    def product_params
      permitted_params
    end
    def destroy
      EtsyListing.deactivate_listing(@product.etsy_id) if @product.etsy_id?
      EbayListing.end_item(@product.ebay_id) if @product.ebay_id
      @product.update_attributes(:on_hand=>0)
      redirect_to admin_products_path
    end
    def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_products_path, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
    def create
      @product=Product.create(permitted_params)
      if @product.save
      redirect_to admin_products_path
      else
        render :new
        end 
    end

  end

  scope :sold_out
  scope :active
  scope :unavailable
  scope :processing


  scope :needs_etsy
  scope :needs_ebay
  scope :needs_photos
  scope :needs_cleaning
  scope :needs_repair
  scope :needs_review
  scope :tagged_needs_photo

  filter :id
  filter :type, :as => :select
  filter :size, :as => :select
  filter :sku
  filter :etsy_id


  index do
    selectable_column
    column :sku do |product|
      link_to "#{product.sku}", product_path(product)
    end
    column "Views", :sortable => :impressions_count do |product|
      "#{product.impressions_count}"
    end
    column :type
    column :brand, :sortable => false
    column :description
    column :size
    column :price, :sortable => :price do |product|
      div :class => "price" do
        number_to_currency product.price
      end
    end
    
    column :weight do |product|
      product.shipping_weight[:human]
    end

    column "Etsy" do |product|
      if product.list_etsy?
        product.etsy_id ? (link_to "active", "http://www.etsy.com/listing/#{product.etsy_id}") : (link_to "create", new_admin_product_etsy_listing_path(product))
      else 
        "na"
      end
    end 
    column "Ebay" do |product|
      if product.ebay_listings.count==0
        link_to "create", new_admin_product_ebay_listing_path(product)
      elsif product.ebay_listings.count>0
        product.ebay_listings.last.active? ? (link_to "active", "http://www.ebay.com/itm/#{product.ebay_listings.last.ebay_item_id}") : (link_to "create", new_admin_product_ebay_listing_path(product))
      end
    end
    column "eBay Count" do |product|
      EbayListing.unscoped.where(:product_id=>product.id).count
    end
    column "Uploads" do |product|
      link_to "#{product.uploads.count}", new_admin_product_upload_path(product)
    end
    column do |product|
      link_to "edit", edit_admin_product_path(product)
    end
  end
  action_item :only => [:show, :edit] do
    link_to("Show on Site", product_path(product))
  end
  action_item :only => [:show, :edit] do
    link_to "Uploads", new_admin_product_upload_path(product)
  end
  
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
