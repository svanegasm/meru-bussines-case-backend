class Order < ApplicationRecord
  # Associations
  belongs_to :client
  has_many :order_products
  has_many :products, through: :order_products, dependent: :destroy

  # Constants
  STATUS = { pending: 0, completed: 1, canceled: 2, returned: 3 }.freeze
  enum status: STATUS

  PAYMENT_METHOD = { cash: 0, credit_card: 1, debit_card: 2 }.freeze
  enum payment_method: PAYMENT_METHOD

  #Validations
  validates :payment_method, presence: { message: "El método de pago es obligatorio" }

  accepts_nested_attributes_for :order_products, allow_destroy: true

  #Callbacks
  before_save :calculate_totals
  after_update :adjust_stock_if_necessary, if: :saved_change_to_status?

  private

  def calculate_totals
    self.subtotal = calculate_subtotal
    self.tax = calculate_tax
    self.total = subtotal + tax
  end

  def calculate_subtotal
    order_products.sum { |op| op.unit_price * op.quantity }
  end

  def calculate_tax
    order_products.sum { |op| op.tax_value * op.quantity }
  end

  def adjust_stock_if_necessary
    adjustment_type = status_previously_was == "pending" && completed? ? :decrease : :increase
    StockAdjustmentService.adjust_stock_for_order(self, adjustment_type) if adjustment_needed?
  end

  def adjustment_needed?
    (status_previously_was == "pending" && completed?) || (status_previously_was == "completed" && canceled?)
  end

  def completed?
    status == "completed"
  end

  def canceled?
    status == "canceled"
  end
end
