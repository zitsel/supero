class ChargesController < ApplicationController
	before_filter :extract_shopping_cart, only: [:new, :create]
	
    def new
    end

    def create
	@amount = @shopping_cart.total_cents #amount in cents

	customer = Stripe::Customer.create(
	    :email  =>	params[:stripeEmail],
	    :card   =>	params[:stripeToken]
	)

	charge = Stripe::Charge.create(
	    :customer	    =>  customer.id,
	    :amount	    =>  @amount,
	    :description    =>	'Rails Stripe customer',
	    :currency	    =>	'usd'
	)
	@order = Order.new(
		:user_id => current_user.id,
		:status => "unshipped",
		:tax_amount => 0,
		:items_amount => @amount,
		:discounts_amount => 0,
		:shipping_amount => 0,
		:paid => true,
		:shipped => false,
	)
	@shopping_cart.shopping_cart_items.each do |i|
			#check product status here
			@order.ordered_items.build(:product_id=>i.item_id,:price=>i.price)
			Product.find(i.item_id).mark_sold
	end

	@order.shipments.build(:shipping_address=>current_user.cat_current_address)
	@order.payments.build(
		:user_id => current_user.id,
		:payment_method => "stripe",
		:amount => @amount,
		:currency_code => "USD",
		:success => true,
		)
	@order.save

    rescue Stripe::CardError => e
	flash[:error] = e.message
	redirect_to charges_path
    end

    private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def charges_params
    	params.require(:charges).permit(:stripeToken,:stripeEmail)
    end
    def extract_shopping_cart
    	#shopping_cart_id = session[:shopping_cart_id]
    	#@shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    	#session[:shopping_cart_id] = @shopping_cart.id
    	@shopping_cart = current_cart
	end

end
