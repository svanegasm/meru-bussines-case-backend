FactoryBot.define do
    factory :client do
      identification { Faker::Number.number(digits: 10) }
      full_name { Faker::Name.name }
      phone { "+#{Faker::Number.number(digits: 10)}" }
      email { Faker::Internet.email }
      deleted_at { nil }
    end
end