include ActionDispatch::TestProcess
Faker::Config.locale = :ja
FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description  { Faker::Lorem.sentence }
    category_id { create(:category_grandchild, name: "かてごり").id }
    item_condition_id { create(:item_condition).id }
    postage_select_id { create(:postage_select).id }
    shipping_id { create(:shipping).id }
    prefecture_id { create(:prefecture).id }
    leadtime_id { create(:leadtime).id }
    seller_id { create(:user).id }
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
