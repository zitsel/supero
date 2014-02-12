json.array!(@products) do |product|
  json.extract! product, :id, :sku, :type, :weight
  json.url product_url(product, format: :json)
end
