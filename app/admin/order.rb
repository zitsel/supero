ActiveAdmin.register Order do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  index do
    column :id
    column "Ordered Date", :sortable => :created_at do |order|
      order.created_at
    end
    column :paid
    column :shipped

    column "Qty" do |order|
      order.ordered_items.count
    end
    column "Weight" do |order|
      order.products.sum(&:weight)
    end
    column "Subtotal" do |order|
      number_to_currency order.subtotal
    end
    column "Shipping" do |order|
      number_to_currency order.shipping
    end
    column "Discoust" do |order|
     number_to_currency order.discounts
    end
    column "Tax" do |order|
     number_to_currency order.tax
    end
    column "GrandTotal" do |order|
     number_to_currency order.grandtotal
    end
  end

end
