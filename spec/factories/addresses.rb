# Read about factories at https://github.com/thoughtbot/factory_girl
require "faker"

FactoryGirl.define do
  factory :address do
    name { Faker::Name.name }
    address_line1 { Faker::Address.street_address }
    address_line2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip_code }
    country { Faker::Address.country }
    association :addressable, :factory => :order

    trait :in_state do
    	state "IA"
    end

    factory :address_in_state, traits: [:in_state]
    
  end

end
