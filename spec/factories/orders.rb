# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user_id 1
    payment_id 1
    status "MyString"
    shipment_id 1
  end
end
