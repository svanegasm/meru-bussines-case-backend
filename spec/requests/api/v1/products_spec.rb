require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password') }
  let!(:admin_user) { create(:user, email: 'admin@example.com', password: 'password', role: 'admin') }

  before do
    post '/api/v1/auth/login', params: { user: { email: 'user@example.com', password: 'password' } }
    token = response.headers['Authorization']
    @auth_headers = { 'Authorization': token }

    post '/api/v1/auth/login', params: { user: { email: 'admin@example.com', password: 'password' } }
    admin_token = response.headers['Authorization']
    @admin_auth_headers = { 'Authorization': admin_token }
  end

  describe "GET /products" do
    it "returns all available products" do
      get api_v1_products_path, headers: @auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /products" do
    let(:valid_attributes) { { product: { name: 'Product 1', description: 'Description 1', price: 100, stock: 5 } } }
    let(:invalid_attributes) { { product: { name: '', description: '', price: 200, stock: 10 } } }

    it "creates a new Product with valid attributes" do
      expect {
        post api_v1_products_path, params: valid_attributes, headers: @admin_auth_headers
      }.to change(Product, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it "does not create a new Product with invalid attributes" do
      post api_v1_products_path, params: invalid_attributes, headers: @admin_auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /products/:id" do
    let(:product) { create(:product) }

    it "returns a product by id" do
      get api_v1_product_path(product), headers: @auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /products/:id" do
    let(:product) { create(:product) }
    let(:new_attributes) { { product: { name: 'Product Updated' } } }

    it "updates the requested product" do
      put api_v1_product_path(product), params: new_attributes, headers: @admin_auth_headers
      product.reload
      expect(product.name).to eq('Product Updated')
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /products/:id" do
    let!(:product) { create(:product) }

    it "soft deletes the product" do
      expect {
        delete api_v1_product_path(product), headers: @admin_auth_headers
      }.to change(Product.availables, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end