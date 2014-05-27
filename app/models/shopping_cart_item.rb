class ShoppingCartItem < ActiveRecord::Base
    acts_as_shopping_cart_item
    def sync_quantities
    	#self.quantity = 0 if self.sold_out?
    	#self.save
    	if self.sold_out? && self.quantity != 0
    		self.update_attributes(:quantity=>0)
    		return self.item.description
    	end
    end
    def sold_out?
    	self.item.on_hand == 0
    end
    def nla?
    	self.quantity == 0
    end
 
end
