# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shipment do
    order_id 1
    carrier_name "MyString"
    tracking_code "MyString"
    tracking_url "MyString"
    shipped_date "2014-05-12"
    amount "9.99"
  end
end
