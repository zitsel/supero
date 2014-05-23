class OrderStepsController < ApplicationController
	include Wicked::Wizard
	steps :shipping, :payment, :confirm

	def show
		if user_signed_in?
			@order = Order.find(session[:order_id])
			render_wizard
		else
			render "signin"
		end
	end
	def update
		@order = Order.find(session[:order_id])
		@order.attributes = order_params
		render_wizard @order
	end
	private
	def order_params
		params.require(:order).permit(:buyer_message,
		shipments_attributes: [:name,:first_line,:second_line,:city,:state,:zip,:country,:clone_address])
	end

end
