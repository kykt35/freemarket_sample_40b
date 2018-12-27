include ActionDispatch::TestProcess
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
    trait(:image) do
      images { fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.jpg", "image/jpg") }
    end
    trait(:image_jpeg) do
      images { fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.jpeg", "image/jpeg") }
    end
    trait(:image_png) do
      images { fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.png", "image/png") }
    end
    trait(:image_gif) do
      images { fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.gif", "image/gif") }
    end
    trait(:text) do
      images { fixture_file_upload("#{::Rails.root}/spec/fixtures/sample.txt", "text/txt") }
    end
    trait(:image_10m) do
      images { fixture_file_upload("#{::Rails.root}/spec/fixtures/sample_10m.jpg", "image/jpg") }
    end
  end
end
