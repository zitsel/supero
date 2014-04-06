module ProductsHelper
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
	def count_shopping_cart_items
		@cart_id = session[:shopping_cart_id]
		@count = @cart_id ? ShoppingCart.find(@cart_id).total_unique_items : "0"
		@count
  	end
	def decades_col
		["2010s","2000s","1990s","1980s","1970s","1960s","1950s","1940s","1930s","1920s","1910s","1900s"]
	end
	
	def conditions_col
		["Poor","Fair","Good","Very Good","New"]
	end

end
