require 'rails_helper'

RSpec.describe PricingService do
    let(:product) { create(:product, price: 100.0, percentage_discount: 10, percentage_tax: 20) }
  
    describe '.calculate_for_order_product' do
      it 'returns correct pricing details' do
        pricing_details = PricingService.calculate_for_order_product(product)
        expect(pricing_details[:unit_price]).to eq(90.0) # 10% discount
        expect(pricing_details[:tax_value]).to eq(18.0) # 20% tax on discounted price
      end
    end
end