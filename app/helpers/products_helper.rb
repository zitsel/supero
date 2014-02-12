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
end
