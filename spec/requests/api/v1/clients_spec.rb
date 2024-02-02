require 'rails_helper'

RSpec.describe "Clients", type: :request do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password') }

  before do
    post '/api/v1/auth/login', params: { user: { email: 'user@example.com', password: 'password' } }
    token = response.headers['Authorization']
    @auth_headers = { 'Authorization': token }
  end

  describe "GET /clients" do
    it "returns all available clients" do
      get api_v1_clients_path, headers: @auth_headers

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /clients" do
    let(:valid_attributes) { { client: { identification: '12345678', full_name: 'John Doe', phone: '+123456789', email: 'johndoe@example.com' } } }
    let(:invalid_attributes) { { client: { identification: '', full_name: '', phone: '', email: '' } } }

    it "creates a new Client with valid attributes" do
      expect {
        post api_v1_clients_path, headers: @auth_headers , params: valid_attributes
      }.to change(Client, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it "does not create a new Client with invalid attributes" do
      post api_v1_clients_path, headers: @auth_headers , params: invalid_attributes
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /clients/:id" do
    let(:client) { create(:client) }

    it "returns a client by id" do
      get api_v1_client_path(client), headers: @auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /clients/:id" do
    let(:client) { create(:client) }
    let(:new_attributes) { { client: { full_name: 'Jane Doe' } } }

    it "updates the requested client" do
      put api_v1_client_path(client), headers: @auth_headers, params: new_attributes
      client.reload
      expect(client.full_name).to eq('Jane Doe')
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /clients/:id" do
    let!(:client) { create(:client) }

    it "soft deletes the client" do
      delete api_v1_client_path(client), headers: @auth_headers
      expect(response).to have_http_status(:forbidden)
    end
  end
end