# spec/models/product.rb
require 'spec_helper'

describe Type do
	it "has a valid factory" do
		FactoryGirl.create(:product).should be_valid
	end
	it "is invalid without a sku, type, weight, condition or on hand" do
		FactoryGirl.build(:product, sku: nil).should_not be_valid
		FactoryGirl.build(:product, type: nil).should_not be_valid
		FactoryGirl.build(:product, weight: nil).should_not be_valid
		FactoryGirl.build(:product, condition: nil).should_not be_valid
		FactoryGirl.build(:product, on_hand: nil).should_not be_valid
	end
	it "does not allow duplicate skus" do
		FactoryGirl.create(:product, sku: "12345")
		FactoryGirl.build(:product, sku: "12345").should_not be_valid
	end
end
