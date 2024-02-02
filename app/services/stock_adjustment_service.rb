class StockAdjustmentService
    def self.adjust_stock_for_order(order, adjustment_type)
      order.order_products.includes(:product).find_each do |order_product|
        new_stock = calculate_new_stock(order_product.product, order_product.quantity, adjustment_type)
        order_product.product.update!(stock: new_stock)
      end
    end
  
    private
  
    def self.calculate_new_stock(product, quantity, adjustment_type)
      adjustment_type == :increase ? product.stock + quantity : product.stock - quantity
    end
end