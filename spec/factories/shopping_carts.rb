FactoryGirl.define do
	factory :shopping_cart do
		after(:create) do |shopping_cart,evaluator|
			create_list(:shopping_cart_item, 5, owner_id: evaluator.id)
		end
	end
end