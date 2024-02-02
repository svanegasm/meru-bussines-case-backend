require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let!(:user) { FactoryBot.create(:user, email: 'user@example.com', password: 'password') }

  describe 'POST /login' do
    let(:valid_credentials) {
      { user: { email: 'user@example.com', password: 'password' } }
    }

    let(:invalid_credentials) {
      { user: { email: 'user@example.com', password: 'wrong' } }
    }

    context 'when request is valid' do
      before { post user_session_path, params: valid_credentials }

      it 'returns a JWT token' do
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'when request is invalid' do
      before { post user_session_path, params: invalid_credentials }

      it 'does not return a JWT token' do
        expect(response.headers['Authorization']).to be_nil
      end
    end
  end
end
