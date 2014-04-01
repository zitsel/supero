ActiveAdmin.register Category do
permit_params :name, :display_name, :ebay_category_id, :etsy_category_id, :package_weight, :about
index do
  column :name
  column :display_name
  column :ebay_category_id
  column :etsy_category_id
  column :package_weight
  default_actions
end
form do |f|
f.inputs do
f.input  :name
f.input  :display_name
f.input  :ebay_category_id
f.input  :etsy_category_id
f.input  :etsy_shop_section_id
f.input  :etsy_shipping_template_id
f.input  :package_weight
f.input  :about
  end
  f.actions
end
controller do
  def create
    create! { admin_categories_path }
  end
  def update
    update! { admin_categories_path }
  end
end
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
  
end
