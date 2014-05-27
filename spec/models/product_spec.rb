# spec/models/product.rb
require 'spec_helper'

describe Product do
	it "has a valid factory" do
		FactoryGirl.create(:product).should be_valid
	end
	it "is invalid without a sku, type, weight, condition" do
		FactoryGirl.build(:product, sku: nil).should_not be_valid
		FactoryGirl.build(:product, type: nil).should_not be_valid
		FactoryGirl.build(:product, weight: nil).should_not be_valid
		FactoryGirl.build(:product, condition: nil).should_not be_valid
	end
	it "does not allow duplicate skus" do
		FactoryGirl.create(:product, sku: "12345")
		FactoryGirl.build(:product, sku: "12345").should_not be_valid
	end
end
