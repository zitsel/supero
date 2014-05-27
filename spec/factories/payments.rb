# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    order
    user
    payment_method "MyString"
    payment_amount { Faker::Commerce.price }
  end
end
