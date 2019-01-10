FactoryBot.define do
  factory :sns_credential do
    provider { "Test-provider" }
    uid { 1000000000 }
    user_id { create(:user).id }
  end
end
