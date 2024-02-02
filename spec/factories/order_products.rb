FactoryBot.define do
  factory :order_product do
    association :order
    association :product
    quantity { Faker::Number.between(from: 1, to: 10) }
  end
end