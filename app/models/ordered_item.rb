class OrderedItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :order
	has_one :user, :through => :order
	#before_save { Product.find(:product_id).mark_sold }
	validates :product_id, :order_id, :price, presence: true
	
end
