ActiveAdmin.register Upload do
	permit_params :uploaded_file, :product_id
	belongs_to :product
	form :partial => "form"
	controller do
		def create
			@upload = Upload.create(upload_params)
			#create! {create.js}
			#@count = Product.find(@upload.product_id).uploads.count
		end
		def new
			@upload = Upload.new
			@product = params[:product_id]
			@uploads = Product.find(@product).uploads
		end	
		def destroy
			@upload=Upload.find(params[:id])
			@upload.destroy
		end
		def upload_params
     		 i=params[:upload].permit(:uploaded_file)
     		 i[:product_id]=params[:product_id]
     		 i
   		end

	end
end
