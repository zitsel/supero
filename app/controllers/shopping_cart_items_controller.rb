class ShoppingCartItemsController < ApplicationController

	def destroy
		#@cart = ShoppingCart.find(session[:shopping_cart_id])
	    #@product = Product.find(params[:id])
		#@cart.remove(@product,1)
		#redirect_to shopping_cart_path
		@shopping_cart_item = ShoppingCartItem.find(params[:id])
		@shopping_cart = current_cart
		@product = Product.find(@shopping_cart_item.item_id)
		@shopping_cart.remove(@product,1)
	end
end