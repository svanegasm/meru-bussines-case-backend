require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password') }

  before do
    post '/api/v1/auth/login', params: { user: { email: 'user@example.com', password: 'password' } }
    token = response.headers['Authorization']
    @auth_headers = { 'Authorization': token }
  end
  
  let!(:client) { create(:client) }
  let!(:product) { create(:product, stock: 50) }

  describe "POST /orders" do
    let(:valid_attributes) {
      {
        order: {
          client_id: client.id,
          payment_method: 'cash',
          order_products_attributes: [
            { product_id: product.id, quantity: 2 }
          ]
        }
      }
    }

    it "creates a new Order" do
      expect {
        post api_v1_orders_path, params: valid_attributes, headers: @auth_headers
      }.to change(Order, :count).by(1)

      expect(response).to have_http_status(:created)

      order = Order.last

      expect(order.subtotal).to eq(order.order_products.sum { |op| op.unit_price * op.quantity })
      expect(order.tax).to eq(order.order_products.sum { |op| op.tax_value * op.quantity })
      expect(order.total).to eq(order.subtotal + order.tax)

      order.order_products.each do |order_product|
        price_with_discount = order_product.product.price * (1 - order_product.product.percentage_discount / 100.0)

        expect(order_product.unit_price.round(2)).to eq(price_with_discount.round(2))
        expect(order_product.tax_value.round(2)).to eq((price_with_discount * (order_product.product.percentage_tax / 100.0)).round(2))
        expect(order_product.discount_value.round(2)).to eq((order_product.product.price - price_with_discount).round(2))
      end
    end
  end

  describe "PUT /orders/:id" do
    let!(:order) { create(:order, client: client, status: 'pending') }
    let!(:order_product) { create(:order_product, order: order, product: product, quantity: 2) }
    let(:update_attributes) {
      { order: { status: 'completed' } }
    }
    let(:update_attributes_2) {
      { order: { status: 'canceled' } }
    }

    it "updates the order's status and adjusts stock accordingly" do
      expect {
        put api_v1_order_path(order), params: update_attributes, headers: @auth_headers
      }.to change { order.reload.status }.from('pending').to('completed')

      expect(response).to have_http_status(:ok)
      expect(product.reload.stock).to eq(48)

      expect {
        put api_v1_order_path(order), params: update_attributes_2, headers: @auth_headers
      }.to change { order.reload.status }.from('completed').to('canceled')

      expect(response).to have_http_status(:ok)
      expect(product.reload.stock).to eq(50)
    end
  end

  describe "GET /orders" do
    it "returns all orders" do
      get api_v1_orders_path, headers: @auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /orders/:id" do
    let!(:order) { create(:order, client: client) }

    it "returns an order by id" do
      get api_v1_order_path(order), headers: @auth_headers
      expect(response).to have_http_status(:ok)
    end
  end
end