FactoryBot.define do
  factory :item_transaction do
    user_id { create(:user).id }
    item { create(:item,:image) }
  end
end
