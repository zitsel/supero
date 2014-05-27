require 'spec_helper'

describe Address do
  it "has a valid factory" do
  	FactoryGirl.create(:address).should be_valid
  end
  it "is invalid without a name" do
  	FactoryGirl.build(:address, name: nil).should_not be_valid
  end
  it "is invalid without an address" do
  	FactoryGirl.build(:address, address_line1: nil).should_not be_valid
  end
  it "is invalid without a city" do
  	FactoryGirl.build(:address, city: nil).should_not be_valid
  end
  it "is invalid without a state" do
  	FactoryGirl.build(:address, state: nil).should_not be_valid
  end
  it "is invalid without a zip" do
  	FactoryGirl.build(:address, zip: nil).should_not be_valid
  end
  it "is invalid without a country" do
  	FactoryGirl.build(:address, country: nil).should_not be_valid
  end
  it "returns true when state is IA" do
  	address = FactoryGirl.build(:address, :in_state)
  	address.needs_taxed?.should == true
  end
  it "returns false when state is not IA" do
  	address = FactoryGirl.build(:address)
  	address.needs_taxed?.should == false
  end
end
