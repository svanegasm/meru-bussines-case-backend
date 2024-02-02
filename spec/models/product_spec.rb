require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'has a valid factory' do
    expect(build(:product)).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:name).with_message('El nombre es obligatorio') }
    it { should validate_presence_of(:price).with_message('El precio es obligatorio') }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0).with_message('El precio debe ser un valor positivo') }
    it { should validate_presence_of(:stock).with_message('Stock de Producto obligatorio') }
    it { should validate_numericality_of(:stock).is_greater_than_or_equal_to(0).only_integer.with_message('El stock debe ser un número entero no negativo') }
  end
end