# spec/models/type.rb
require 'spec_helper'

describe Type do
	it "has a valid factory" do
		FactoryGirl.create(:type).should be_valid
	end
	it "is invalid without a display name" do
		FactoryGirl.build(:type, display_name: nil).should_not be_valid
	end
	it "is invalid without a name" do
		FactoryGirl.build(:type, name: nil).should_not be_valid
	end
	it "does not allow duplicate names" do
		FactoryGirl.create(:type, name: "Foo")
		FactoryGirl.build(:type, name: "Foo").should_not be_valid
	end
	it "does not allow duplicate display names" do
		FactoryGirl.create(:type, display_name: "Bar")
		FactoryGirl.build(:type, display_name: "Bar").should_not be_valid
	end
	it "does not allow non-numeric ebay category ids" do
		FactoryGirl.build(:type, ebay_category_id: "Foo").should_not be_valid
	end
	it "does not allow non-numeric etsy category ids" do
		FactoryGirl.build(:type, etsy_category_id: "Foo").should_not be_valid
	end
	it "does not allow non-numeric etsy shipping template ids" do
		FactoryGirl.build(:type, etsy_shipping_template_id: "Foo").should_not be_valid
	end
	it "does not allow non-numeric etsy shop section ids" do
		FactoryGirl.build(:type, etsy_shop_section_id: "Foo").should_not be_valid
	end
	it "does not allow non-numeric package weight" do
		FactoryGirl.build(:type, package_weight: "Foo").should_not be_valid
	end
	it "returns a symbol" do 
		type1 = FactoryGirl.create(:type, name: "FooBar" )
		type1.symbolize.should == :foo_bars
		type2 = FactoryGirl.create(:type, name: "Bing" )
		type2.symbolize.should == :bings
	end

end