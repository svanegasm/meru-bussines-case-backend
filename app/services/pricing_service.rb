class PricingService
    def self.calculate_for_order_product(product)
        price_with_discount = product.price * (1 - product.percentage_discount / 100.0)
        tax_value = price_with_discount * (product.percentage_tax / 100.0)
        discount_value = product.price - price_with_discount

        { unit_price: price_with_discount, tax_value: tax_value, discount_value: discount_value }
    end

    def self.total_product_tax(product)
        product.quantity * product.tax_value
    end
end