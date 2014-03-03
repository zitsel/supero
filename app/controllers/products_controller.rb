class ProductsController < ApplicationController
  include ProductsHelper
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_type
  before_action :verify_user, only: [:edit, :update, :destroy, :new, :create]
  
  # GET /products
  # GET /products.json
  def index
    @filter = params[:filter] || "available"
    @products = type_class.send(@filter.to_sym)
   end
  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = type_class.new
    @product.sku =  Random.new.rand(10000..99999)
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to sti_product_path(@product.type, @product, :edit) , notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to sti_product_path(@product.type, @product, nil), notice: 'Product was successfully updated.' }
        #format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = type_class.find(params[:id])
    end
    def verify_user
      unless user_signed_in? && current_user.email=="admin@revive-clothiers.com"
        redirect_to "/"
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(type.underscore.downcase.to_sym).permit(:brand, :tagged_size, :price, :size_only,:coat_size, :size_type, :size, :sleeve_length, :material, :style, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :sleeve_measure, :coat_length, :coat_chest_measure, :mfg_date, :needs_cleaning, :needs_repair, :vintage, :product, :fit, :material, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :mfg_date, :mfg_country, :retail, :on_hand, :buttons, :vents, :lining, :notes, :condition, :shoulder_measure, :chest_measure, :waist_measure, :seat_measure, :full_length_measure, :sleeve_measure, :tagged_size, :style, :pattern, :color, :shoulder_measure, :sleeve_measure, :chest_measure, :waist_measure, :seat_measure, :length_measure, :condition, :notes, :label, :retailer, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, :cloth_pattern, :trouser_style, :trouser_fly, :trouser_waistband_style, :trouser_waistband_lining, :belt_loops, :brace_buttons, :tab_adjust, :crotch_shield, :front_closure, :front_pockets_style, :trouser_lining, :trouser_bottoms, :trouser_condition, :trouser_waistband_width_measure, :trouser_waist_outlet_measure, :trouser_seat_measure, :thigh_measure, :knee_measure, :cuff_width_measure, :inseam_measure, :outseam_measure, :inseam_outlet_measure, :brand, :label, :retailer, :cloth_mill, :cloth_composition, :cloth_weave, :cloth_color, :cloth_pattern, :coat_style, :no_buttons, :button_stance, :lapel_style, :lapel_width, :gorge, :no_vents, :canvas, :lining, :lining_material, :cuff_style, :no_cuff_buttons, :button_type, :pocket_style, :notes, :coat_condition, :coat_shoulder_measure, :coat_waist_measure, :coat_seat_measure, :coat_sideseam_outlet_measure, :coat_full_length_measure, :left_sleeve_top_measure, :left_sleeve_bottom_measure, :left_sleeve_outlet_measure, :right_sleeve_top_measure, :right_sleeve_bottom_measure, :right_sleeve_outlet_measure, :armscye_measure, :elbow_measure, :cuff_width_measure, :sku, :type, :weight, :properties, :maker, :model, :model_number, :style, :color, :size, :width, :upper_material, :upper_condition, :sole_material, :sole_type, :sole_condition, :heel_material, :heel_condition, :insole_type, :insole_condition, :lining_type, :lining_condition, :brand, :label, :weaves, :retailer, :color, :pattern, :collar_type, :cuff_type, :brand, :label, :retailer, :material, :width, :length, :pattern, :color, :style, :collar_size, :sleeve_size, :belt_material, :color, :size, :buckle_material, :length, :width, :fhole, :notes, :condition_notes, :lhole)
    end
    def set_type
      @type = type
    end
    def type
      params[:type] || "Product"
    end
    def type_class
      type.constantize
    end
end
