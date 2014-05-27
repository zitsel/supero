require 'spec_helper'

describe ShoppingCartItem do
	it "has a valid factory" do
  	FactoryGirl.create(:shopping_cart_item).should be_valid
  end
end
