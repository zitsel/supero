class EtsyListingsController < ApplicationController
  before_action :set_etsy_listing, only: [:show, :edit, :update, :destroy]
  include EtsyListingsHelper
  # GET /etsy_listings
  # GET /etsy_listings.json
  def index
    @etsy_listings = EtsyListing.all
  end

  # GET /etsy_listings/1
  # GET /etsy_listings/1.json
  def show
  end

  # GET /etsy_listings/new
  def new
    @etsy_listing = EtsyListing.new
    @product = Product.find(params[:product_id])
  end

  # GET /etsy_listings/1/edit
  def edit
  end

  # POST /etsy_listings
  # POST /etsy_listings.json
  def create
      @etsy_id = add_item(params)
      @product_id = params["product_id"]
      add_images(@etsy_id,@product_id)
      @etsy_listing = EtsyListing.create(:product_id=>@product_id,:etsy_id=>@etsy_id)
      if @etsy_listing.save
        redirect_to @etsy_listing, notice: "etsy listing created"
      else 
        redirect_to :back, status: :unprocessable_entity
      end
    #@etsy_listing = EtsyListing.new(etsy_listing_params)

#    respond_to do |format|
#      if @etsy_listing.save
#        format.html { redirect_to :back, notice: 'Etsy listing was successfully created.' }
#        format.json { render action: 'show', status: :created, location: @etsy_listing }
#      else
#        format.html { render action: 'new' }
#        format.json { render json: @etsy_listing.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # PATCH/PUT /etsy_listings/1
  # PATCH/PUT /etsy_listings/1.json
  def update
    respond_to do |format|
      if @etsy_listing.update(etsy_listing_params)
        format.html { redirect_to @etsy_listing, notice: 'Etsy listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @etsy_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etsy_listings/1
  # DELETE /etsy_listings/1.json
  def destroy
    @etsy_listing.destroy
    respond_to do |format|
      format.html { redirect_to etsy_listings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etsy_listing
      @etsy_listing = EtsyListing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.


    def etsy_listing_params
      params.require(:etsy_listing).permit(:product_id,:etsy_id)
    end
end
