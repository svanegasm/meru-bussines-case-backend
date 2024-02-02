require 'rails_helper'

RSpec.describe Client, type: :model do
  subject { FactoryBot.create(:client) }

  it 'has a valid factory' do
    expect(build(:client)).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:identification).with_message('La identificación es obligatoria') }
    it { should validate_uniqueness_of(:identification).case_insensitive.with_message('Ya tenemos un cliente con esa identificación') }
    it { should validate_presence_of(:full_name).with_message('El nombre completo es obligatorio') }
    it { should validate_presence_of(:email).with_message('El correo electrónico es obligatorio') }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email).with_message('El formato del correo electrónico no es válido') }
    it { should validate_presence_of(:phone).with_message('El teléfono es obligatorio') }
    it { should allow_value('+123456789').for(:phone) }
    it { should_not allow_value('invalid_phone').for(:phone).with_message('El teléfono debe ser numérico') }
  end
end