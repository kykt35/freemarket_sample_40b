FactoryBot.define do
  factory :favorite do

    trait(:with_user) do
      after(:build) do |favorite|
        favorite.user = FactoryBot.create(:user)
      end
    end
    trait(:with_item) do
      after(:build) do |favorite|
        favorite.item = FactoryBot.create(:item,:image)
      end
    end
  end
end
