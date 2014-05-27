require 'spec_helper'
describe Category do
	it "has a valid factory" do
		FactoryGirl.create(:category).should be_valid
	end
	it "is invalid without a name or display name" do
		FactoryGirl.build(:category, name: nil).should_not be_valid
		FactoryGirl.build(:category, display_name: nil).should_not be_valid
	end
	it "does not allow duplicate names" do
		FactoryGirl.create(:category, name: "Foo")
		FactoryGirl.build(:category, name: "Foo").should_not be_valid
	end
	it "does not allow duplicate display names" do
		FactoryGirl.create(:category, display_name: "Foo")
		FactoryGirl.build(:category, display_name: "Foo").should_not be_valid
	end
	it "returns a symbol" do
		category = FactoryGirl.build(:category, name: "Foo")
		category.symbolize.should == :foos
	end
end