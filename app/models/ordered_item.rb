class OrderedItem < ActiveRecord::Base
	has_one :product
	belongs_to :order
	has_one :user, :through => :order
end
