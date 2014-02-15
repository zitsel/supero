class PagesController < ApplicationController
  def home
  	@recent_products = Product.available.order("created_at desc").limit(6)
  end

  def help
  end

  def about
  end

  def contact
  end
end
