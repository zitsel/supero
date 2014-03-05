class ShoppingCartItemsController < ApplicationController

	def destroy
		@cart = ShoppingCart.find(session[:shopping_cart_id])
	    @product = Product.find(params[:id])
		@cart.remove(@product,1)
		redirect_to shopping_cart_path
	end
end