module ApplicationHelper
	def sti_product_path(type ="product", product = nil, action = nil)
		send "#{format_sti(action, type, product)}_path", product
	end
	def format_sti(action, type, product)
		action || product ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
	end
	def format_action(action)
		action ? "#{action}_" : ""
	end
	def sti_filter_products_path(type="product",filter=nil)
		send "#{filter}_#{type.underscore.pluralize}_path"
	end
	#def count_shopping_cart_items
#		@cart_id = session[:shopping_cart_id]
#		ShoppingCart.find(@cart_id).total_unique_items || "0"
#		#@count = @cart_id ? ShoppingCart.find(@cart_id).total_unique_items : "0"
#		#@count
#  	end
	def resource_name
	:user
	end

	def resource
	@resource ||= User.new
	end

	def devise_mapping
	@devise_mapping ||= Devise.mappings[:user]
	end

end
