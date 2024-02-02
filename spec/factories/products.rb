FactoryBot.define do
    factory :product do
      name { Faker::Commerce.product_name }
      description { Faker::Lorem.sentence }
      price { Faker::Commerce.price(range: 10.0..100.0) }
      stock { Faker::Number.between(from: 1, to: 100) }
      percentage_discount { Faker::Number.between(from: 0, to: 30) }
      percentage_tax { 16.00 }
      deleted_at { nil }
    end
end