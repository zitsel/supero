require 'spec_helper'

describe Payment do
	it "has a valid factory" do
  	FactoryGirl.create(:payment).should be_valid
  end
end

