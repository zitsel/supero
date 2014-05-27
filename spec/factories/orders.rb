# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user
    paid false
    shipped false
    
    trait :with_items_15 do
    	after(:create) do |order,evaluator|
    		create(:ordered_item, price: 5.00, order: order)
    		create(:ordered_item, price: 10.00, order: order)
    	end
    end
    trait :in_state do
    	after(:create) do |order,evaluator|
    		create(:address_in_state,addressable: order)
    	end
  	end
  	trait :out_of_state do
  		after(:create) do |order,evaluator|
  			create(:address,addressable: order)
  		end
  	end
  	trait :payment_1590 do
  		after(:create) do |order,evaluator|
  			create(:payment,payment_amount: 15.90,order: order)
  		end
  	end

  end
end
