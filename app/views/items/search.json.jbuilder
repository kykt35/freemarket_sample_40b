if @price_tag.present?
  json.price_tag
    json.id         @price_tag.id
    json.min_price  @price_tag.min_price
    json.max_price  @price_tag.max_price
end
if @category_sizes_ids.present?
  json.array! @category_sizes_ids do |category_sizes_id|
    json.id  category_sizes_id.size.id
    json.name category_sizes_id.size.name
  end
end
