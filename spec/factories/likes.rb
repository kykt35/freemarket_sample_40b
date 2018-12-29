FactoryBot.define do
  factory :like do
    user { create(:user) }
    item { create(:item, :image) }
  end
end
