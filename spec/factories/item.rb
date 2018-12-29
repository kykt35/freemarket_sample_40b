include ActionDispatch::TestProcess
Faker::Config.locale = :ja
FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description  { Faker::Lorem.sentence }
    category { create(:category_grandchild, name: "かてごり") }
    item_condition { create(:item_condition) }
    postage_select { create(:postage_select) }
    shipping { create(:shipping) }
    prefecture { create(:prefecture) }
    leadtime { create(:leadtime) }
    seller { create(:user) }
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
