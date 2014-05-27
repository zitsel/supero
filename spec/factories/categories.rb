require "faker"
FactoryGirl.define do
	factory :category do
		name  { Faker::Lorem.word }
		display_name { Faker::Lorem.word }
		ebay_category_id { Faker::Number.number(10) }
		etsy_category_id { Faker::Number.number(8) }
		etsy_shop_section_id { Faker::Number.number(8) }
		etsy_shipping_template_id { Faker::Number.number(8) }
		package_weight { Faker::Number.number(3) }
		about { Faker::Lorem.paragraph(3) }
	end
end

