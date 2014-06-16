class ProductsController < ApplicationController
  impressionist 
  include ProductsHelper
  add_breadcrumb "All Products", :products_path

  before_action :set_product, only: [:show]
  before_action :set_type

  def index
    @products = type_class.active.order('size ASC')
    add_breadcrumb Category.find_by_name(type).display_name, sti_product_path(type) unless type == "Product" 
  end

  

  def show
    add_breadcrumb @product.category.display_name, sti_product_path(@product.type)
    add_breadcrumb "#{@product.brand} #{@product.description.try(:titleize)}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = type_class.unscoped.find(params[:id])
    end
    def set_type
      @type = type
    end
    def type
      params[:type] || "Product"
    end
    def type_class
      type.constantize
    end
end
