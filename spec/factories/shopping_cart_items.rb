FactoryGirl.define do
	factory :shopping_cart_item do
		owner_type "ShoppingCart"
		quantity 1
		owner_id 1
		item_id 1
		item_type "Product"
		price { Faker::Commerce.price }
	end
end