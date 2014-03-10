class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :destroy]
  before_action :verify_user
  # GET /uploads
  # GET /uploads.json
  def index
    
    @product = Product.find(params[:product_id]) unless params[:product_id]==nil
    @uploads = params[:product_id] ? Upload.where(:product_id=>params[:product_id]) : Upload.all
    
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
    @upload.product_id=params[:product_id]
    @uploads=Upload.where(:product_id=>params[:product_id])
  end

  # GET /uploads/1/edit
  def edit
  end

  def edit_multiple
    @uploads = Upload.find(params[:upload_ids])
  end

  def update_multiple
    Upload.update(params[:uploads].keys, params[:uploads].values)
    redirect_to uploads_url
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.create(upload_params)
    @count = Product.find(@upload.product_id).uploads.count
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    @upload = Upload.find(params[:id])
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def verify_user
      unless user_signed_in? && current_user.email=="admin@revive-clothiers.com"
        redirect_to "/"
      end
    end
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params[:upload].permit(:uploaded_file,:product_id)
    end
end
