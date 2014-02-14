json.array!(@ebay_listings) do |ebay_listing|
  json.extract! ebay_listing, :id, :item_id, :ebay_item_id, :start_time, :end_time, :insertion_fees
  json.url ebay_listing_url(ebay_listing, format: :json)
end
