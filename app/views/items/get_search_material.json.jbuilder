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
if @brands_categories_ids.present?
  json.array! @brands_categories_ids do |brand_category_id|
    json.name brand_category_id.brand.name
  end
end
if @brands.present?
  json.array! @brands do |brand|
    json.name brand.name
  end
end
