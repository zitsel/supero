#spec/factories/products.rb
require "faker"

FactoryGirl.define do
	factory :product do
		sku { Faker::Number.number(5) }
		type { Category.all.shuffle[0].name }
		#category
		status "active"
		weight { Faker::Number.number(4) }
		condition "Good"
		price { Faker::Number.number(2) }
		vintage true
		mfg_date "1990s"
		mfg_country nil
		on_hand "1"
		needs_repair false
		needs_cleaning false
		notes { Faker::Lorem.sentence(1) }
		condition_notes { Faker::Lorem.sentence(1)}

		after(:build) { |product| product.class.skip_callback(:save, :before, :save_brand) }
	end
end