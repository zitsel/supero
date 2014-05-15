class CheckoutController < ApplicationController
	def signin
		redirect_to checkout_shipping_path if user_signed_in?
	end
	def shipping
	end
	def payment
	end
	def confirmation
	end
end
