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
    	shopping_cart_id = session[:shopping_cart_id]
    	@shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    	session[:shopping_cart_id] = @shopping_cart.id
	end

end
