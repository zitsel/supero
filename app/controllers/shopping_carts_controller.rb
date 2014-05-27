class ShoppingCartsController < ApplicationController
  before_filter :extract_shopping_cart, except: [:destroy]

  def create
    @product = Product.find(params[:product_id])
    @shopping_cart.add(@product, @product.price)
    respond_to do |format|
      format.html {redirect_to shopping_cart_path}
      format.js
    end
  end

  def show

  end

  def destroy
  #shopping_cart_id = session[:shopping_cart_id]
  #@shopping_cart = ShoppingCart.find(shopping_cart_id)
  #@shopping_cart.clear
  @shopping_cart.clear
  redirect_to { products_path }

  end

  private
  def extract_shopping_cart
    @shopping_cart = current_cart
   
  end
end
