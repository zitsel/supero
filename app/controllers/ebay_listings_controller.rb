class EbayListingsController < ApplicationController
  before_action :set_ebay_listing, only: [:show, :edit, :update, :destroy]

  # GET /ebay_listings
  # GET /ebay_listings.json
  def index
    @ebay_listings = EbayListing.all
  end

  # GET /ebay_listings/1
  # GET /ebay_listings/1.json
  def show
  end

  # GET /ebay_listings/new
  def new
    @product = Product.find(params[:product_id])
    @ebay_listing = EbayListing.new
  end

  # GET /ebay_listings/1/edit
  def edit
  end

  # POST /ebay_listings
  # POST /ebay_listings.json
  def create
    listing_info=EbayHelper::Ebay::AddItem(params[:listing_type],params[:duration],params[:quantity],params[:condition_id],params[:free_shipping],params[:start_price],params[:buy_it_now_price],params[:product_id])
    @ebay_listing = EbayListing.new(listing_info)
    respond_to do |format|
      if @ebay_listing.save
        format.html { redirect_to @ebay_listing, notice: 'Ebay listing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ebay_listing }
      else
        format.html { render action: 'new' }
        format.json { render json: @ebay_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ebay_listings/1
  # PATCH/PUT /ebay_listings/1.json
  def update
    respond_to do |format|
      if @ebay_listing.update(ebay_listing_params)
        format.html { redirect_to @ebay_listing, notice: 'Ebay listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ebay_listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ebay_listings/1
  # DELETE /ebay_listings/1.json
  def destroy
    @ebay_listing.destroy
    respond_to do |format|
      format.html { redirect_to ebay_listings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ebay_listing
      @ebay_listing = EbayListing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ebay_listing_params
      params.require(:ebay_listing).permit(:item_id, :ebay_item_id, :start_time, :end_time, :insertion_fees)
    end
end
