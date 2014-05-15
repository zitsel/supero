# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    order_id 1
    user_id 1
    payment_method "MyString"
    amount "9.99"
  end
end
