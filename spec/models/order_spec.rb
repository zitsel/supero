require 'spec_helper'

describe Order do
	@cart = ShoppingCart.create
	@product = FactoryGirl.create(:product)
	@cart.add(@product,@product.price)
	

	it "has a valid factory" do
		FactoryGirl.create(:order).should be_valid
	end
	it "is invalid without a user" do
		FactoryGirl.build(:order, user: nil).should_not be_valid
	end
	
	describe "has 15.00 in items" do
		order = FactoryGirl.create(:order,:with_items_15)

		describe ".tax_rate" do
			it "in state" do
				FactoryGirl.create(:address,state: "IA",addressable: order)
				order.tax_rate.should eq(0.06)
			end
			it "out of state" do
				FactoryGirl.create(:address,state: "CA",addressable: order)
				order.tax_rate.should eq(0.00)
			end
		end
		describe ".tax" do
			it "in state" do
				FactoryGirl.create(:address,state: "IA",addressable: order)
				order.tax.should eq(0.90)
			end
			it "out of state" do
				FactoryGirl.create(:address,state: "CA",addressable: order)
				order.tax.should eq(0.00)
			end

		end

		describe ".balance" do
			FactoryGirl.create(:address,addressable: order)
			it "should return 0.00 when fully paid" do
				#FactoryGirl.create(:address,state: "IA",addressable: order)

				FactoryGirl.create(:payment,payment_amount: 15.00, order: order)
				order.balance.should eq(0.00)
			end
			it "should return a balance when not fully paid" do
				#FactoryGirl.create(:address,state: "IA",addressable: order)

				FactoryGirl.create(:payment,payment_amount: 10.00, order: order)
				order.balance.should eq(5.00)
			end
			it "should correctly handle multiple payments" do
				#FactoryGirl.create(:address,state: "IA",addressable: order)

				FactoryGirl.create(:payment,payment_amount: 10.00, order: order)
				FactoryGirl.create(:payment,payment_amount: 5.00, order: order)
				order.balance.should eq(0.00)
			end
		end
		describe ".paid_in_full?" do
			it "should return true when paid in full" do
				FactoryGirl.create(:payment,payment_amount:15.00,order:order)
				order.paid_in_full?.should eq(true)
			end
			it "should return false when not paid in full" do
				FactoryGirl.create(:payment,payment_amount:10.00,order:order)
				order.paid_in_full?.should eq(false)
			end
		end
		describe ".shipping" do
			it "should return 0" do #shipping calculation isn't implemented
				order.shipping.should eq(0)
			end
		end
		describe ".subtotal" do
			it "should correctly calculate the subtotal" do
				order.subtotal.should eq(15.00)
			end
		end
		describe ".grandtotal" do
			it "in state" do
				FactoryGirl.create(:address,state: "IA",addressable: order)
				order.grandtotal.should eq(15.90)
			end
			it "out of state" do
				FactoryGirl.create(:address,state: "CA",addressable: order)
				order.grandtotal.should eq(15.00)
			end
		end
		describe ".gt_cents" do
			it "should give back cents for the grand total" do
				order.gt_cents.should eq(1500)
			end
		end
	end
end



