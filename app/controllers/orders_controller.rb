class OrdersController < InheritedResources::Base
	def signin
		redirect_to orders_shipping_path if user_signed_in?
	end
	def shipping
	end
	def payment
	end
	def confirmation
	end

end
