class PagesController < ApplicationController
  def home
  	@products = Product.available.order("created_at desc").limit(24)
  end

  def help
  end

  def about
  end

  def contact
  end
end
