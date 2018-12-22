json.set! :size do
  json.array! @sizes do |size|
    json.id  size.id
    json.name  size.name
  end
end
json.hasBrand @hasBrand
