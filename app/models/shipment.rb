class Shipment < ActiveRecord::Base
	belongs_to :order
	has_one :user, :through => :order
end
