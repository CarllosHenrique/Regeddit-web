FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "password123" }
    password_confirmation { "password123" }
    name { Faker::Name.name }
    username { Faker::Internet.unique.username(separators: %w[_ -]) }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { "+55 11 9999-9999" }
    bio { Faker::Lorem.sentence(word_count: 10) }
  end
end
