# Read about factories at https://github.com/thoughtbot/factory_girl
require "faker"

FactoryGirl.define do
  factory :ordered_item do
  	product
  	order
  	price { Faker::Commerce.price }
  end

  	
end
