# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@etsy_category_id="69164513"
@etsy_shipping_id="2175562941"

Type.create(
	name: "Belt",
	display_name: "Belts",
	ebay_category_id: "2993",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15197347",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "75"
	)

Type.create(
	name: "Blazer",
	display_name: "Blazers & Sport Coats",
	ebay_category_id: "3002",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15142337",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "75"
	)

Type.create(
	name: "CasualShirt",
	display_name: "Casual Shirts",
	ebay_category_id: "57990",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15145404",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "25"
	)
Type.create(
	name: "DressShirt",
	display_name: "Dress Shirts",
	ebay_category_id: "57991",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15145404",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "25"
	)

Type.create(
	name: "DressShoe",
	display_name: "Dress Shoes",
	ebay_category_id: "53120",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15145414",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "300"
	)

Type.create(
	name: "Jacket",
	display_name: "Jackets & Light Coats",
	ebay_category_id: "57988",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15145408",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "25"
	)

Type.create(
	name: "Neckwear",
	display_name: "Neckwear",
	ebay_category_id: "15662",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15142335",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "20"
	)
Type.create(
	name: "Overcoat",
	display_name: "Overcoats",
	ebay_category_id: "57988",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15145408",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "75"
	)
Type.create(
	name: "Suit",
	display_name: "Suits",
	ebay_category_id: "3001",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15142339",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "75"
	)
Type.create(
	name: "Sweater",
	display_name: "Sweaters",
	ebay_category_id: "11484",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15142341",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "75"
	)
Type.create(
	name: "Trouser",
	display_name: "Trousers",
	ebay_category_id: "57989",
	etsy_category_id: @etsy_category_id,
	etsy_shop_section_id: "15145416",
	etsy_shipping_template_id: @etsy_shipping_id,
	package_weight: "75"
	)
