FactoryGirl.define do
  factory :user do
    password = "0a0a0a"

    nickname              Faker::Name.last_name
    email                 Faker::Internet.free_email
    password              password
    password_confirmation password
  end
end
