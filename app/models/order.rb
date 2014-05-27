class Order < ActiveRecord::Base
	has_many :ordered_items
	has_many :products, through: :ordered_items
	belongs_to :user
	has_many :payments
	has_many :shipments
	has_many :addresses, as: :addressable

	accepts_nested_attributes_for :payments
	accepts_nested_attributes_for :shipments
	accepts_nested_attributes_for :ordered_items
	accepts_nested_attributes_for :addresses

	validates :user_id, presence: :true


	def paid_in_full?
		self.balance > 0 ? false : true 
	end
	def balance
		self.grandtotal - self.amount_paid
	end
	def amount_paid
		self.payments.sum(&:payment_amount)
	end
	def subtotal
		self.ordered_items.sum(&:price)
	end
	def tax
		self.subtotal * self.tax_rate
	end
	def tax_rate
		#self.addresses.last.needs_taxed? ? 0.06 : 0
		0
	end
	def shipping
		0
	end
	def grandtotal
		self.subtotal+self.tax+self.shipping
	end
	def discounts
		0 
	end
	def gt_cents
		(self.grandtotal*100).floor
	end
	def create_etsy_order
		@order = Order.create(
		:user_id => current_user.id,
		:paid => false, 
		:shipped => false,
		)
		@order.ordered_items.create(
			:product_id=>item.item_id,
			:price=>item.price
		)

		@order.addresses.create(
			:name => params[:stripeShippingName], 
			:address_line1 => params[:stripeShippingAddressLine1],
			:address_line2 => params[:stripeShippingAddressLine2],
			:city => params[:stripeShippingAddressCity],
			:state => params[:stripeShippingAddressState],
			:zip => params[:stripeShippingAddressZip],
			:country => params[:stripeShippingAddressCountry]
			)
		@order.payments.create(
		:user_id => current_user.id,
		:payment_method => "stripe",
		:payment_amount => @charge["amount"]/100
		)
	end

end
