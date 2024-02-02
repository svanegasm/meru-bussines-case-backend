class OrderProduct < ApplicationRecord
  # Associations
  belongs_to :order
  belongs_to :product

  before_validation :set_pricing

  private

  def set_pricing
    pricing = PricingService.calculate_for_order_product(product)
    self.unit_price = pricing[:unit_price]
    self.tax_value = pricing[:tax_value]
    self.discount_value = pricing[:discount_value]
    self.total_products_price = self.unit_price * self.quantity
  end
end
