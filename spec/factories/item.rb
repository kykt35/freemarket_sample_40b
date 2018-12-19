Faker::Config.locale = :ja
FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description  { Faker::Lorem.sentence }
    category_id { 1 }
    item_condition_id { 1 }
    postage_select_id { 1 }
    shipping_id { 1 }
    prefecture_id { 1 }
    leadtime_id { 1 }
    seller_id { 1 }
    price { 100 }
    trait(:images) do
      images { fixture_file_upload("#{::Rails.root}/public/images/sample.jpg", "image/jpeg") }
    end
  end
end
