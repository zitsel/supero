require 'spec_helper'

describe OrderedItem do
	it "has a valid factory" do
		FactoryGirl.create(:ordered_item).should be_valid
	end
	it "should be invalid without a product, product price or order" do
		FactoryGirl.build(:ordered_item, product: nil).should_not be_valid
		FactoryGirl.build(:ordered_item, order: nil).should_not be_valid
		FactoryGirl.build(:ordered_item, price: nil).should_not be_valid
	end
end
