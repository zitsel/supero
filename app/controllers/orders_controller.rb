class OrdersController < InheritedResources::Base
	before_filter :extract_shopping_cart, except: [:destroy]
	before_filter :verify_signed_in
	
	def new
	end	

	def create
		@customer = Stripe::Customer.create(
			:email  =>	params[:stripeEmail],
			:card   =>	params[:stripeToken]
			)

		@order = Order.create(
			:user_id => current_user.id,
			:paid => false, 
			:shipped => false,
			)
#
#	#add items from cart to order
#	@order.process_cart(@shopping_cart)
#
		@shopping_cart.shopping_cart_items.map do |item|
			unless item.sold_out?
				@order.ordered_items.create(
					:product_id=>item.item_id,
					:price=>item.price
					)
					#Product.find(item.item_id).mark_sold
			#else
				#flash[:danger] = "unable to add #{item}"
			end
		end
		
			
	@order.addresses.create(
		:name => params[:stripeShippingName], 
		:address_line1 => params[:stripeShippingAddressLine1],
		:address_line2 => params[:stripeShippingAddressLine2],
		:city => params[:stripeShippingAddressCity],
		:state => params[:stripeShippingAddressState],
		:zip => params[:stripeShippingAddressZip],
		:country => params[:stripeShippingAddressCountry]
		)
	
	#attempt to charge card

	@charge = Stripe::Charge.create(
		:customer	    =>  @customer.id,
		:amount	    	=>  @order.gt_cents,
	    #:description    =>	'Rails Stripe customer',
	    :currency	    =>	'usd'
	    )


	@order.payments.create(
	:user_id => current_user.id,
	:payment_method => "stripe",
	:payment_amount => @charge["amount"]/100
	)

	@order.paid = true if @order.paid_in_full?
	if @order.save
		@order.paid = true if @order.paid_in_full?
		@shopping_cart.destroy
		@order.ordered_items.map { |i| Product.find(i.product_id).mark_sold }
		flash[:notice] = "Created Order Successfully"
		redirect_to orders_path
	else 
		flash[:danger] = "Something went wrong"
		redirect_to orders_path
	end


rescue Stripe::CardError => e
	flash[:error] = e.message
	redirect_to new_order_path
end

def index
	@orders = current_user.orders.order("id DESC")
end
def show
	@order = Order.find(params[:id])
end

private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def charges_params
    	params.require(:charges).permit(
    		:stripeToken,:stripeEmail,
    		:stripeShippingName,:stripeShippingAddressLine1,:stripeShippingAddressLine2,:stripeShippingAddressZip,:stripeShippingAddressState,:stripeShippingAddressCity,:stripeShippingAddressCountry
    		)
    end
    def extract_shopping_cart
    	@shopping_cart = current_cart
    end
    def verify_signed_in
    	unless user_signed_in?
    		flash[:danger] = "Please log in or create an account first"
    		redirect_to new_user_session_path
    	end
    end

end
