class Order < ActiveRecord::Base
	has_many :ordered_items
	belongs_to :user
	has_many :payments
	has_many :shipments
	accepts_nested_attributes_for :payments
	accepts_nested_attributes_for :shipments
	accepts_nested_attributes_for :ordered_items

end
