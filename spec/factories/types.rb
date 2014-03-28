# spec/factories/types.rb
require 'faker'

FactoryGirl.define do
	factory :type do |f|
		f.name { Faker::Lorem.word }
		f.display_name { Faker::Commerce.department }
		f.ebay_category_id { Faker::Number.number(5) }
		f.etsy_category_id { Faker::Number.number(10) }
		f.etsy_shop_section_id { Faker::Number.number(5) }
		f.etsy_shipping_template_id { Faker::Number.number(10) }
		f.package_weight { Faker::Number.number(3) }
		f.about { Faker::Lorem.paragraph(2) }
	end
end