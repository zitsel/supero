class ShoppingCart < ActiveRecord::Base
    acts_as_shopping_cart
    def tax_pct
	0
    end
    def self.has_product?(item_id,cart_id)
		ShoppingCartItem.where("owner_id=? AND item_id=?",cart_id,item_id).present?
    end
   
end
