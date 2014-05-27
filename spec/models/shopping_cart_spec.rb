require 'spec_helper'

describe ShoppingCart do
	it "has a valid factory" do
  	FactoryGirl.create(:shopping_cart).should be_valid
  end
end
