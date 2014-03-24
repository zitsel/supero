class AddFieldsToTypes < ActiveRecord::Migration
  def change
    add_column :types, :display_name, :string
    add_column :types, :ebay_category_id, :string
    add_column :types, :etsy_category_id, :string
    add_column :types, :etsy_shop_section_id, :string
    add_column :types, :etsy_shipping_template_id, :string
    add_column :types, :package_weight, :string
    add_column :types, :about, :text
  end
end
