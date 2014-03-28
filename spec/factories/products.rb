#spec/factories/products.rb
require "faker"

FactoryGirl.define do
	factory :product do |f|
		f.sku { Faker::Number.number(5) }
		f.type { Type.all.shuffle[0].name }
		f.weight { Faker::Number.number(4) }
		f.condition "Good"
		f.price { Faker::Number.number(2) }
		f.vintage true
		f.mfg_date "1990s"
		f.mfg_country nil
		f.on_hand "1"
		f.needs_repair false
		f.needs_cleaning false
		f.notes { Faker::Lorem.sentence(1) }
		f.condition_notes { Faker::Lorem.sentence(1)}
	end
end