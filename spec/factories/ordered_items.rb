# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ordered_item do
    order_id 1
    product_id 1
    price "9.99"
  end
end
