class ProductsController < ApplicationController
  include ProductsHelper

  before_action :set_product, only: [:show]
  before_action :set_type

  def index
    @products = type_class.available
   end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = type_class.find(params[:id])
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
