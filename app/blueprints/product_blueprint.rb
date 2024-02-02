class ProductBlueprint < Blueprinter::Base
  identifier :id

  view :list do
    fields :name,
           :description,
           :price,
           :stock,
           :percentage_discount,
           :percentage_tax
  end

  view :order_view do
    fields :name,
           :price,
           :percentage_discount,
           :percentage_tax
  
    field :quantity do |product|
      product.quantity
    end
  
    field :unit_price do |product|
      product.unit_price
    end
  
    field :tax_value do |product|
      product.tax_value
    end

    field :total_product_price do |product|
      product.total_products_price
    end

    field :total_product_tax do |product|
      PricingService.total_product_tax(product)
    end

    field :order_product_id do |product|
      product.order_product_id
    end
  end
end