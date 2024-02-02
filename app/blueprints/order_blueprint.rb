class OrderBlueprint < Blueprinter::Base
    identifier :id

    view :basic do
        fields :status,
               :payment_method,
               :subtotal,
               :tax,
               :total

        field :client_name do |order|
            order.client&.full_name
        end
    end

    view :order_products do
        include_view :basic

        association :products, blueprint: ProductBlueprint, view: :order_view do |order, _|
            order.products.joins(:order_products).distinct.select(
                "products.*,
                order_products.id as order_product_id,
                order_products.quantity,
                order_products.unit_price,
                order_products.tax_value,
                order_products.total_products_price"
            ).order(order_product_id: :asc)
        end
    end
end