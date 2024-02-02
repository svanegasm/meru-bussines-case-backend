require 'rails_helper'

RSpec.describe StockAdjustmentService do
    let(:product) { create(:product, stock: 50) }
    let(:order) { create(:order) }
    let!(:order_product) { create(:order_product, order: order, product: product, quantity: 5) }
  
    describe '.adjust_stock_for_order' do
      context 'when the order is completed' do
        it 'decreases the product stock' do
          StockAdjustmentService.adjust_stock_for_order(order, :decrease)
          expect(product.reload.stock).to eq(45)
        end
      end
  
      context 'when the order is canceled' do
        it 'increases the product stock' do
          StockAdjustmentService.adjust_stock_for_order(order, :increase)
          expect(product.reload.stock).to eq(55)
        end
      end
    end
end