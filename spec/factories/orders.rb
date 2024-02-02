FactoryBot.define do
  factory :order do
    association :client
    status { :pending }
    payment_method { :cash }

    after(:build) do |order|
      order.order_products << build_list(:order_product, 2, order: order)
    end
  end
end