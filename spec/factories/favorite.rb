FactoryBot.define do
  factory :favorite do
    user { create(:user) }
    item { create(:item, :image) }
  end
end
